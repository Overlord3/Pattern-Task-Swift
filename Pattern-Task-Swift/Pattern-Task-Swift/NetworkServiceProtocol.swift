//
//  NetworkServiceProtocol.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


/**
Протокол для вывода результатов работы сервиса
*/
protocol NetworkServiceOutputProtocol
{
	/**
	Возвращает данные в презентер, когда запрос выполнен
	
	@param word Определения к найденному слову
	*/
	func searchingFinishedWithWord(word: WordModel)

	/**
	Уведомляет View, когда загрузка завершена
	
	@param imageData Данные изображения
	@param number Номер этого изображения (ячейка)
	*/
	func loadingImageFinishedWith(imageData: Data, number: Int)
	
	/**
	Сообщает сколько всего изображений будет, чтобы подготовить массив (так как изображения могут прийти в любом порядке)
	
	@param count Количество изображений
	*/
	func prepareArrayForImagesCount(count: Int)
}


/**
Протокол для функций сервиса
*/
protocol NetworkServiceInputProtocol
{
	/**
	Поиск определений слов в сервисе
	
	@param searchString Строка поиска, на английском обязательно
	*/
	func searchDefinitionsForString(searchString: String)
	
	/**
	Поиск изображений в сервисе
	
	@param searchSrting Строка поиска, на английском обязательно
	@param page Номер страницы, с 1
	*/
	func searchImagesForString(searchString: String, page: Int)
}
