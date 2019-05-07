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
	var word: String
	var definitions: [DefinitionModel] = []
	
	init(word: String)
	{
		self.word = word
	}
}
