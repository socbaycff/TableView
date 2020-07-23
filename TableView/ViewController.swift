import Foundation
import UIKit

class ViewController: UIViewController {
    var dataSource2 = ["khang", "da", "dqwe", "dqwd"]
    var dataSource3 = [["2","3"],["df","d"],["12","3","421"]]
    var refreshControl = UIRefreshControl()
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
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh!!!")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // add refresh control vao table
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // refresh
        
        //refreshControl.endRefreshing()
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
    
    //  return lai so section : neu k cai -> tu dong la 1
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource3.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // dataSource2.count // return  so tuong phan tu
        dataSource3[section].count //
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "tua de \(section)"
    }
    
    // bind va tao cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item") as! MyTableViewCell
        // cell.bind(dataSource2[indexPath.row], self)
        cell.bind(dataSource3[indexPath.section][indexPath.row], self)
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
        if (editingStyle == .insert) {
            
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
        let config = UISwipeActionsConfiguration(actions: [like])
        // config.performsFirstActionWithFullSwipe = false
        // return lai array cac nut
        return config
    }
    
    
    // di chuyen
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = dataSource3[sourceIndexPath.section][sourceIndexPath.row]
        dataSource3[sourceIndexPath.section][sourceIndexPath.row] = dataSource3[destinationIndexPath.section][destinationIndexPath.row]
        dataSource3[destinationIndexPath.section][destinationIndexPath.row] = temp
        print("di chuyen")
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .insert // k cai mac dinh la delete
//    }
    
    
}

extension ViewController: UITableViewDataSourcePrefetching {
    // đưa cho indexpath chuẩn bị dc user thấy, để dev load trước
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let fakeapi = [String]()
        for indexpath in indexPaths {
            dataSource3[indexpath.section][indexpath.row] += fakeapi[indexpath.row] // cong viec nang
        }
        
        tableView.reloadData()
        
        
    }
    
    
}
