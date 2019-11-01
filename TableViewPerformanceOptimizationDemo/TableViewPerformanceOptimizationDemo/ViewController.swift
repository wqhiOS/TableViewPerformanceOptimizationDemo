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
        tableView.rowHeight = 60
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
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = indexPath.row == 0 ? "Not optimized \n Avg frames per second on iPhone5s:16fps" : "Optimized \n Avg frames per second on iPhone5s:55fps"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(indexPath.row == 0 ? NotOptimizedViewController() : OptimizedViewController(), animated: true)
    }
}

