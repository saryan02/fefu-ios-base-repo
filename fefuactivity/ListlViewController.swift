//
//  ListlViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 28.10.2021.
//

import UIKit

var myIndex = 0

class ListlViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "TableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.dataSource = self
        tableView.rowHeight = 115

        registerCells()
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        present(ListlViewController(nibName: "ListlViewController", bundle: nil), animated: true, completion: nil)
//    }
    
    private func registerCells(){
        tableView.register(UINib(nibName:cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

}



extension ListlViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.layer.cornerRadius = 10
        
        return cell
        
    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let destination = CellViewController()
////      navigationController?.pushViewController(destination, animated: true)
//        self.shouldPerformSegue(withIdentifier: "Showinfo", sender: self)
//    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        myIndex = indexPath.row
//        perfromSegue(withIdentifier: "Showinfo", sender: self)
//    }


}




