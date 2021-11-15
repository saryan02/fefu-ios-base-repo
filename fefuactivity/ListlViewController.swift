//
//  ListlViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 28.10.2021.
//

import UIKit

var myIndex = 0

var section:[String] = ["A", "B", "C"]
var titles: [String] = ["Today", "Yesterday", "1 October"]

class ListlViewController: UIViewController,  UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "TableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.delegate = self
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
        
        return cell
        
    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let destination = CellViewController()
////      navigationController?.pushViewController(destination, animated: true)
//        self.shouldPerformSegue(withIdentifier: "Showinfo", sender: self)
//    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "Showinfo", sender: self)
    }

    
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return section
//    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(titles[section])"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

}




