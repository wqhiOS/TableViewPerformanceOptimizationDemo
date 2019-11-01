//
//  OptimizedViewController.swift
//  TableViewPerformanceOptimizationDemo
//
//  Created by wuqh on 2019/10/29.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class OptimizedViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension OptimizedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.description(), for: indexPath) as! CustomCell
        
        cell._view.backgroundColor = UIColor.random
        cell._view.layer.cornerRadius = 20
        
        cell._imageView1.image = UIImage(named: "\(Int.random(in: 1...17))")
        cell._imageView1.cornerRadiusOptimized(radius: 20)
        
        cell._imageView2.image = UIImage(named: "\(Int.random(in: 1...17))")
        cell._imageView2.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell._imageView2.layer.shadowOpacity = 0.5
        cell._imageView2.layer.shadowPath = UIBezierPath(rect: cell._imageView2.bounds).cgPath
        
        cell._label.backgroundColor = UIColor.white
        let text =  "\(indexPath.row)。中文中文是蝶恋蜂狂塑料袋积分雷克萨打积分拉速度快放假拉速度快甲方拉速度快甲方商量的复健科是老地方见第三方塑料袋积分拉斯科订房间拉萨的会计法拉斯柯达积分拉束带结发拉萨的会计法拉速度快放假绿色的发"
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowBlurRadius = 5
        shadow.shadowColor = UIColor(white: 0, alpha: 0.5)
        let attText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.shadow: shadow])
        cell._label.attributedText = attText

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(indexPath.row == 0 ? NotOptimizedViewController() : OptimizedViewController(), animated: true)
    }
}
