//
//  NotOptimizedViewController.swift
//  TableViewPerformanceOptimizationDemo
//
//  Created by wuqh on 2019/10/29.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class NotOptimizedViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.description())
        tableView.rowHeight = 50
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
    }

}

extension NotOptimizedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.description(), for: indexPath) as! CustomCell
        
        cell._view.backgroundColor = UIColor.random
        cell._view.layer.cornerRadius = 20
        cell._view.layer.masksToBounds = true
        
        cell._imageView1.image = UIImage(named: "\(Int.random(in: 1...17))")
        cell._imageView1.layer.cornerRadius = 20
        cell._imageView1.layer.masksToBounds = true
        
        cell._imageView2.image = UIImage(named: "\(Int.random(in: 1...17))")
        cell._imageView2.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell._imageView2.layer.shadowOpacity = 0.5
        
        cell._label.text = "\(indexPath.row)。中文中文是蝶恋蜂狂塑料袋积分雷克萨打积分拉速度快放假拉速度快甲方拉速度快甲方商量的复健科是老地方见第三方塑料袋积分拉斯科订房间拉萨的会计法拉斯柯达积分拉束带结发拉萨的会计法拉速度快放假绿色的发"
        cell._label.backgroundColor = UIColor.clear
        cell._label.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell._label.layer.shadowOpacity = 0.5
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(indexPath.row == 0 ? NotOptimizedViewController() : OptimizedViewController(), animated: true)
    }
}

