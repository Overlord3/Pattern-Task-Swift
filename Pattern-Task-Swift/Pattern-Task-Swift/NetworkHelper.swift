//
//  NetworkHelper.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


class NetworkHelper
{
	/**
	Получение URL с запросом к сервису с текстом поиска
	
	@param searchString текст поиска
	@param page страница, с 1
	@return URL в строке
	*/
	static func URLForSearchString(searchString: String, page: Int)->String
	{
		//Ключ работает, проверено
		let APIkey = "5553e0626e5d3a905df9a76df1383d98"
		return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIkey)&tags=\(searchString)&per_page=10&format=json&nojsoncallback=1&page=\(page)"
		
	}
}
