//
//  ImageTableViewCell.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class ImageTableViewCell: UITableViewCell
{
	var customImageView = UIImageView()
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		//Всего высота - 250
		let height: CGFloat = 250+16;
		let width: CGFloat = self.bounds.size.width;
		let leftRightBorder: CGFloat = (width - 250)/2;
		let border: CGFloat = 8;
		
		self.customImageView.frame =  CGRect(x: leftRightBorder, y: border, width: width - leftRightBorder*2, height: height - border*2)
		self.customImageView.backgroundColor = UIColor.red;
		self.contentView.addSubview(self.customImageView)
	}
	
}
