//
//  DefinitionTableViewCell.swift
//  Pattern-Task-Swift
//
//  Created by Александр Плесовских on 07/05/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class DefinitionTableViewCell : UITableViewCell
{
	
	var definitionLabel = UILabel()
	var authorLabel = UILabel()
	var exampleLabel = UILabel()
	var dateLabel = UILabel()
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		//Допустим такое расположение:
		//Определение, ниже пример, ниже автор и дата помельче
		let width: CGFloat = self.bounds.size.width
		let border: CGFloat = 8
		let shift: CGFloat = 5
		
		let maximumLabelSize = CGSize.init(width: width - 2*border, height: 9999)
		
		//Лейбл для определения
		self.definitionLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
		self.definitionLabel.textAlignment = .left
		self.definitionLabel.numberOfLines = 0;
		
		//вычисляем размер
		
		
		var expectedLabelSize = self.definitionLabel.sizeThatFits(maximumLabelSize)
		self.definitionLabel.frame = CGRect(x: border, y: border, width: width - border*2, height: expectedLabelSize.height);
		self.contentView.addSubview(self.definitionLabel)
		
		//Лейбл для примера использования
		self.exampleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
		self.exampleLabel.textAlignment = .left;
		self.exampleLabel.numberOfLines = 0;
		//вычисляем размер
		expectedLabelSize = self.exampleLabel.sizeThatFits(maximumLabelSize)
		self.exampleLabel.frame = CGRect(x: border, y: shift + self.definitionLabel.frame.maxY, width: width - border*2, height: expectedLabelSize.height);
		self.contentView.addSubview(self.exampleLabel)
		
		
		//Лейбл для примера использования
		self.authorLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
		self.authorLabel.textAlignment = .left;
		self.authorLabel.numberOfLines = 0;
		//вычисляем размер
		expectedLabelSize = self.authorLabel.sizeThatFits(maximumLabelSize)
		self.authorLabel.frame = CGRect(x: border, y: shift + self.exampleLabel.frame.maxY, width: width - border*2, height: expectedLabelSize.height);
		self.contentView.addSubview(self.authorLabel)
	
		
		//Лейбл для примера использования
		self.dateLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
		self.dateLabel.textAlignment = .left;
		self.dateLabel.numberOfLines = 0;
		//вычисляем размер
		expectedLabelSize = self.dateLabel.sizeThatFits(maximumLabelSize)
		self.dateLabel.frame = CGRect(x: border, y: shift + self.authorLabel.frame.maxY, width: width - border*2, height: expectedLabelSize.height);
		self.contentView.addSubview(self.dateLabel)
	}
	
	/**
	Функция для вычисления высоты ячейки, на основе параметров
	
	@param definition Текст определения
	@param example Текст примера
	@param author Текст автора
	@param date Текст даты
	@return Высота ячейки
	*/
	static func calculateHeightWithDefinition(definition: String, example: String, author: String, date: String) -> CGFloat
	{
		//Определение, ниже пример, ниже автор и дата помельче
		let width: CGFloat = UIScreen.main.bounds.size.width
		let border: CGFloat = 8
		let shift: CGFloat = 5
		let maximumLabelSize = CGSize(width: width - 2*border, height: 9999);
		let testLabel = UILabel()

		var cellHeight: CGFloat = 0;
		
		//Общие настройки
		testLabel.textAlignment = .left
		testLabel.numberOfLines = 0;
		
		//Лейбл для определения
		testLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
		testLabel.text = definition;
		cellHeight += border + testLabel.sizeThatFits(maximumLabelSize).height
		
		//Лейбл для примера использования
		testLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
		testLabel.text = example;
		cellHeight += shift + testLabel.sizeThatFits(maximumLabelSize).height
		
		//Лейбл для автора
		testLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
		testLabel.text = author;
			cellHeight += shift + testLabel.sizeThatFits(maximumLabelSize).height
		
		//Лейбл для даты
		testLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
		testLabel.text = date;
				cellHeight += shift + testLabel.sizeThatFits(maximumLabelSize).height
		
		cellHeight += border;
		
		return cellHeight;
	}
}
