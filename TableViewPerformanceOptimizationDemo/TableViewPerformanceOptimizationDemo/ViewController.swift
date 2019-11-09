//
//  ViewController.swift
//  TableViewPerformanceOptimizationDemo
//
//  Created by wuqh on 2019/10/29.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.rowHeight = 100
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.numberOfLines = 0
        if indexPath.row == 0 {
            cell.textLabel?.text = "Not optimized \n Avg frames per second on iPhone5s:16fps"
        }else if indexPath.row == 1 {
            cell.textLabel?.text = "Optimized \n Avg frames per second on iPhone5s:55fps"
        }else {
            cell.textLabel?.text = "super big image"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(NotOptimizedViewController(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(OptimizedViewController(), animated: true)
        }else {
            navigationController?.pushViewController(ImageOptimizedViewController(), animated: true)
        }
        
        
    }
}

