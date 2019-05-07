//
//  ImageRequest.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


class ImageRequest
{
	let urlString: String
	let number: Int
	
	/**
	Инициализатор модели запроса
	
	@param url URL запроса
	@param number Номер изображения
	@return Обьект запроса к сервису
	*/
	init(url: String, number: Int)
	{
		self.number = number
		self.urlString = url
	}
}
