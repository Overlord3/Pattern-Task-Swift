//
//  FlickerNetworkModel.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


struct FlickerNetworkModel : Codable
{
	
	/// Ключи для декодирования данных из JSON
	///
	/// - stat: статус запроса
	/// - photos: структура, содержащая массив ссылок на картинки
	enum CodingKeys: String, CodingKey
	{
		case stat
		case photos
	}
	
	var stat: String /**< Статус запроса, если ок, то "ок" */
	var photos: PhotosModel /**< Модель с URL для картинок */
}
