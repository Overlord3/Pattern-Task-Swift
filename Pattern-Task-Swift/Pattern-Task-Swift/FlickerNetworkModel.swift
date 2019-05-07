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
	enum CodingKeys: String, CodingKey
	{
		case stat
		case photos
	}
	
	var stat: String
	var photos: PhotosModel
}
