//
//  ListlViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 28.10.2021.
//

import UIKit
import CoreLocation
import CoreData

struct ActivitiesTableModel{
    let date: String
    let distance: Double
    let duration: String
    let type: String
    
}


class ListlViewController: UIViewController,  UITableViewDelegate{
    var myIndex = 0
    
    var section:[String] = ["A", "B", "C"]
    var titles: [String] = ["Today", "Yesterday", "1 October"]

    private var data: [ActivitiesTableModel] = []
    
    
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
        fetch()
        print("!!!!!!!!!!!!!!!!!!!!!!")
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        present(ListlViewController(nibName: "ListlViewController", bundle: nil), animated: true, completion: nil)
//    }
    
    
    private func registerCells(){
        tableView.register(UINib(nibName:cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func fetch() {
        let context = FEFUCoreDataContainer.instance.context
        let activityRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        do{
            print(activityRequest)
            print(000000000000000000000000000000000000000000000000)
            let rawActivites = try context.fetch(activityRequest)
            print(rawActivites[0].activityDistance)
            print(rawActivites.count)
            let activitiesModels: [ActivitiesTableModel] = rawActivites.map{ rawActivity in
                return ActivitiesTableModel(date: rawActivity.activityDate ?? "" ,
                                            distance: rawActivity.activityDistance,
                                            duration: rawActivity.activityDuration ?? "",
                                            type: rawActivity.activityType ?? "")
               
            }
//            self.data = [ActivitiesTableModel(date: rawActivites[0].activityDate!, distance: rawActivites[0].activityDistance, duration: rawActivites[0].activityDuration!, type: rawActivites[0].activityType!)]
            self.data = activitiesModels.reversed()
//            self.data = [ActivitiesTableModel(date: "24", distance: 11, duration: "11", type: "11")]
            print(data.count)
            print("data: \(data)")
        } catch{
            print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK")
        }

}

//    do {
//        let data = try  context.fetch(activityRequest)
////        print(data.last!.activityDistance, String(data.last!.activityDuration!))
//        data != nil ? data.map{
//                        dataActivity in
//            return dataActivity.activityDuration!
//            } : data
//    } catch {
//        print("Oh.. no")
//    }
}



extension ListlViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activity = self.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let upcastedCell = cell as? TableViewCell
            
        upcastedCell!.bild(activity)
        return upcastedCell!
        
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
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(titles[section])"
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
//    }

}




