//
//  PhotoModel.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct PhotoModel: Codable
{
	enum CodingKeys: String, CodingKey {
		case farm
		case server
		case id
		case secret
	}
	var farm: Int
	var server: String
	var id: String
	var secret: String
	
	// Получение фото
	// https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
	// example https://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg
	var urlString: String
	{
		return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
	}

}
