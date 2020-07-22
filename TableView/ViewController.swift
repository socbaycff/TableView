//
//  ViewController.swift
//  TableView
//
//  Created by L Khang on 7/21/20.
//  Copyright © 2020 L Khang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dataSource2 = ["khang", "da", "dqwe", "dqwd"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var data: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dang ky cell cho tableview
        tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "item")
        // 2 dong ben duoi co the dung giao dien
//        tableView.delegate = self // set thang xu ly su kien
//        tableView.dataSource = self // set adapter
        
        // nut tren navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit/Done", style: .done, target: self, action: #selector(edit))
        
    }
    // ham xu ly nut navigation ben tren
    @objc func edit() {
        tableView.isEditing.toggle()
    }
}
extension ViewController: UITableViewDataSource, Click, UITableViewDelegate {
    // button click
    func onClick(_ str: String) {
        data.text = str
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource2.count // return  so tuong phan tu
    }
    
    // bind va tao cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item") as! MyTableViewCell
        cell.bind(dataSource2[indexPath.row], self)
        return cell
    }
    
    
    // su kien click cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Chon dong \(indexPath.row)")
    }
    
    // xu ly vuot mac dinh
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) { // neu la delete action
            dataSource2.remove(at: indexPath.row)      // xoa tren data
            tableView.deleteRows(at: [indexPath], with: .fade) // xoa tren giao dien
        }
    }
    
    
    // xu ly vuot nang cao
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // khoi tao va tuy bien nut
        let like = UIContextualAction(style: .normal, title: "Like") {
            (action,view,completion) in
            print("like")
        }
        like.backgroundColor = .blue
        
        // return lai array cac nut
        return UISwipeActionsConfiguration(actions: [like])
    }
    

}
