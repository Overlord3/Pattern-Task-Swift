//
//  DefinitionModel.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


struct DefinitionModel : Codable
{
	
	/// Ключи для декодирования из JSON в объекты
	///
	/// - definition: Определение слова
	/// - author: Автор определения
	/// - example: Пример использования
	/// - date: Дата определения
	enum CodingKeys: String, CodingKey
	{
		case definition
		case author
		case example
		case date = "written_on"
	}
	
	let definition: String /**< Определение слова */
	let author: String /**< Автор определения */
	let date: Date /**< Дата определения */
	let example: String /**< Пример использования */
	
	/**
	Инициализатор модели определения
	
	@param definition Текст определения
	@param author Имя автора
	@param date Дата
	@param example Пример использования
	@return Модель определения
	*/
	init(definition: String, author: String, date: Date, example: String)
	{
		self.definition = definition
		self.author = author
		self.date = date
		self.example = example
	}
}
