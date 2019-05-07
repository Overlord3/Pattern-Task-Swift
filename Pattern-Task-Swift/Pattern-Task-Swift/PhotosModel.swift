//
//  PhotosModel.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


struct PhotosModel : Codable
{
	/// Ключи для декодирования данных из JSON
	///
	/// - photo: структура, содержащие ссылки на картинки
	enum CodingKeys: String, CodingKey
	{
		case photo
	}
	
	var photo: [PhotoModel] /**< Модель с ссылкой на картинку */
}
