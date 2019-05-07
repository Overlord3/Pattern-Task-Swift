//
//  DefinitionModel.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class DefinitionModel
{
	let definition: String
	let author: String
	let date: Date
	let example: String
	
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
