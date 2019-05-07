//
//  WordModel.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


struct WordModel
{
	var word: String  /**< Основное слово */
	var definitions: [DefinitionModel] = [] /**< Массив определений для слова */
	
	/**
	Инициализатор для модели слова
	
	@param word основное слово, которое искали
	@return экземпляр класса
	*/
	init(word: String)
	{
		self.word = word
	}
}
