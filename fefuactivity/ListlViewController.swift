//
//  ListlViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 28.10.2021.
//

import UIKit

class ListlViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "TableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.dataSource = self

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
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        print(#function)
        return cell
        
    }
    


}




