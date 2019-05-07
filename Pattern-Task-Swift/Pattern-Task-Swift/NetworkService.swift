//
//  NetworkService.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class NetworkService: NSObject ,NetworkServiceInputProtocol, URLSessionDelegate
{
	let imagePerPage = 10
	
	var urlSession: URLSession /**< Сессия */
	var downloadTasksArray: Array<URLSessionDownloadTask> = [] /**< Массив для заданий подгрузки картинок, нужен для отмены заданий */
	var outputDelegate: NetworkServiceOutputProtocol? /**< Делегат внешних событий */
	
	/**
	Инициализатор сервиса
	
	@return Объект NetworkService
	*/
	override init()
	{
		// Настраиваем Session Configuration
		let sessionConfiguration = URLSessionConfiguration.default
		sessionConfiguration.allowsCellularAccess = true
		sessionConfiguration.httpAdditionalHeaders = ["Accept": "application/json"]
		
		// Создаем сессию
		urlSession = URLSession(configuration: sessionConfiguration)
		super.init()
		urlSession = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
	}
	
	/**
	Поиск определений слов в сервисе
	
	@param searchString Строка поиска, на английском обязательно
	*/
	func searchDefinitionsForString(searchString: String)
	{
		//http://api.urbandictionary.com/v0/define?term={word}
		let urlstring = "http://api.urbandictionary.com/v0/define?term=\(searchString)"
		
		var request = URLRequest(url: URL(string: urlstring)!)
		request.httpMethod = "GET"
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.timeoutInterval = 15
		
		let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
			
			guard let data = data else {return}
			do {
					//Создадим модель для слова
					var wordModel = WordModel(word: searchString)
					
					let decoder = JSONDecoder()
					let formatter = DateFormatter()
					formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
					decoder.dateDecodingStrategy = .formatted(formatter)
					
					let networkData = try decoder.decode(DefinitionNetworkModel.self, from: data)
					wordModel.definitions = networkData.list;
				
					// Отправим сообщение с данными на главный поток, для обновления UI
					DispatchQueue.main.async {
						self.outputDelegate?.searchingFinishedWithWord(word: wordModel)
					}

			} catch let error as NSError {
				print("Failed to load: \(error.localizedDescription)")
			}
		}
		dataTask.resume()
	}

	
	func loadImageFromRequest(request: ImageRequest, number: Int)
	{
		let url = URL(string: request.urlString)!
		let downloadTask = self.urlSession.downloadTask(with: url) { (location, response, error) in
			do
			{
				let data = try Data.init(contentsOf: location!)
				
				// Отправим сообщение с данными на главный поток, для обновления UI
				DispatchQueue.main.async {
					self.outputDelegate?.loadingImageFinishedWith(imageData: data, number: number)
				}
			}
			catch let error as NSError {
				print("Failed to load: \(error.localizedDescription)")
			}
		
			
		}
		self.downloadTasksArray.append(downloadTask)
		downloadTask.resume()
	}
	
	func cancelCurrentDownloadTasks()
	{
		for task in self.downloadTasksArray
		{
			if task.state == .running
			{
				task.cancel()
			}
		}
		self.downloadTasksArray.removeAll()
	}
	
	
	func searchImagesForString(searchString: String, page: Int)
	{
		//Отменим все текущие загрузки, если они есть
		self.cancelCurrentDownloadTasks()
		let urlString = NetworkHelper.URLForSearchString(searchString: searchString, page: page)
		
		var request = URLRequest(url: URL(string: urlString)!)
		request.httpMethod = "GET"
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.timeoutInterval = 15
		
		let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
			
			guard let data = data else {return}
			do {
				let networkData = try JSONDecoder().decode(FlickerNetworkModel.self, from: data)
				
				if networkData.stat
				{
					let photos: [PhotoModel] = []//networkData.photos.photo
					// Отсюда отправим сообщение на обновление UI с главного потока
					DispatchQueue.main.async {
						self.outputDelegate?.prepareArrayForImagesCount(count: photos.count)
					}
					var counter = 0
					for photo in photos
					{
						let request = ImageRequest(url: photo.urlString, number: counter)
						self.loadImageFromRequest(request: request, number: counter)
						counter += 1
					}
				}
			} catch let error as NSError {
				print("Failed to load: \(error.localizedDescription)")
			}
		}
		dataTask.resume()
	}
}
