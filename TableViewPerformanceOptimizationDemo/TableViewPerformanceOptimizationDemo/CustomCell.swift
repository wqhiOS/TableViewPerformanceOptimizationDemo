//
//  CustomCell.swift
//  TableViewPerformanceOptimizationDemo
//
//  Created by wuqh on 2019/10/29.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    lazy var _view: UIView = {
        let view = UIView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        return view
    }()

    lazy var _imageView1: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 47.5, y: 5, width: 40, height: 40))
        return imageView
    }()
    
    lazy var _imageView2: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 90, y: 5, width: 40, height: 40))
        return imageView
    }()
    
    lazy var _label: UILabel = {
        let label = UILabel(frame: CGRect(x: 135, y: 8, width: UIScreen.main.bounds.width-140, height: 40))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(_view)
        contentView.addSubview(_imageView1)
        contentView.addSubview(_imageView2)
        contentView.addSubview(_label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
