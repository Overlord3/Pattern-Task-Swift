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
	enum CodingKeys: String, CodingKey {
		case photo
	}
	var photo: [PhotoModel]
}
