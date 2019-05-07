//
//  ViewController.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, NetworkServiceOutputProtocol
{

	var tableView: UITableView!
	var searchBar: UISearchBar!
	
	var wordModel: WordModel?
	
	var networkService: NetworkService!
	var imagesArray: Array<UIImage> = []
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.prepareUI()
		self.prepareModels()
		
	}

	func prepareModels()
	{
		self.networkService = NetworkService()
		self.networkService.outputDelegate = self
		self.tableView.register(DefinitionTableViewCell.self, forCellReuseIdentifier: DefinitionTableViewCell.description())
		self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.description())
	}
	
	func prepareUI()
	{
		self.view.backgroundColor = UIColor.white
		//Отступ сверху для навигейшн бара
		let topInset: CGFloat = (self.navigationController?.navigationBar.frame.maxY)!
		let screenHeight: CGFloat = UIScreen.main.bounds.size.height
		let screenWidth: CGFloat = UIScreen.main.bounds.size.width
		
		//Инициализация серч бара
		let searchBarHeight: CGFloat = 50
		searchBar = UISearchBar(frame: CGRect(x: 0, y: topInset, width: screenWidth, height: searchBarHeight))
		searchBar.placeholder = "Введите слово для поиска (англ.)"
		searchBar.delegate = self
		self.view.addSubview(searchBar)
		
		self.tableView = UITableView(frame: CGRect(x: 0, y: self.searchBar.frame.maxY, width: screenWidth, height: screenHeight - searchBarHeight) , style: UITableView.Style.plain)
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.view.addSubview(tableView)
	}
	
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		self.title = "Поиск определений слов"
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
	{
		//скрыть клавиатуру
		searchBar.resignFirstResponder()
		//Удалить все с прошлого поиска
		self.tableView.setContentOffset(CGPoint.zero, animated: true)
		self.imagesArray.removeAll()
		self.setArraySize(count: 10)
		if let text = searchBar.text, text != ""
		{
			//Вызвать поиск
			self.networkService.searchDefinitionsForString(searchString: text)
			self.networkService.searchImagesForString(searchString: text, page: 1)
		}
	}
	
	//MARK: - UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return (self.wordModel?.definitions.count ?? 0) + self.imagesArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		if let model = self.wordModel, indexPath.row < model.definitions.count
		{
			let cell = tableView.dequeueReusableCell(withIdentifier: DefinitionTableViewCell.description(), for: indexPath) as! DefinitionTableViewCell
			
			if let model = self.wordModel?.definitions[indexPath.row]
			{
				cell.definitionLabel.text = model.definition
				cell.exampleLabel.text = model.example
				cell.authorLabel.text = model.author
				cell.dateLabel.text = model.date.description
			}
			
			return cell
		}
		else
		{
			let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.description(), for: indexPath) as! ImageTableViewCell
			let shift = self.wordModel?.definitions.count ?? 0
			cell.customImageView.image = self.imagesArray[indexPath.row - shift]
			return cell
		}
	}

	//MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		if let model = self.wordModel, indexPath.row < model.definitions.count
		{
			let model = self.wordModel!.definitions[indexPath.row]
			
			let height = DefinitionTableViewCell.calculateHeightWithDefinition(definition: model.definition, example: model.example, author: model.author, date: model.date.description)
			return height
		}
		else
		{
			//Для ячейки с картинкой 250 и по 8 границы
			return 250+16
		}
	}
	
	/**
	Возвращает данные в презентер, когда запрос выполнен
	
	@param word Определения к найденному слову
	*/
	func searchingFinishedWithWord(word: WordModel)
	{
		self.wordModel = word
		self.tableView.reloadData()
	}
	
	/**
	Задает размер массива с изображениями и количество ячеек в коллекшн вью
	
	@param count размер массива
	*/
	func prepareArrayForImagesCount(count: Int)
	{
		self.setArraySize(count: count)
	}
	
	func setArraySize(count: Int)
	{
		while self.imagesArray.count < count
		{
			self.imagesArray.append(UIImage())
		}
		self.tableView.reloadData()
	}
	
	/**
	Устанавливает картинку в массив
	
	@param imageData Данные изображения
	@param number Индекс в массиве
	*/
	func loadingImageFinishedWith(imageData: Data, number: Int)
	{
		let image = UIImage(data: imageData)
		//Проверка, что изображение успешно получено
		if (image != nil)
		{
			self.imagesArray[number] = image!
		}
		self.tableView.reloadData()
	}
}
