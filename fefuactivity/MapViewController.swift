//
//  MapViewController.swift
//  fefuactivity
//
//  Created by wsr3 on 18.11.2021.
//

import UIKit
import CoreLocation
import MapKit



class MapViewController: UIViewController {
    
    
    var cellIndex = 0
    var prevDate = Date()
    var isPaused = false
    var timer = Timer()
    var pauseDate = Date()
    var prevDiff = TimeInterval()
    var startDate  =  Date()
    var start : CLLocation?
    
    private let fefuCoreDate = FEFUCoreDataContainer.instance
    
    @IBOutlet weak var mapOutlet: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var ActivityCollection: UICollectionView!
    @IBOutlet weak var mainStart: UIView!
    @IBOutlet weak var progressStart: UIView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    let locationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    var userLocation: CLLocation?{
        didSet{
            guard let userLocation = userLocation else{
                return
            }
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                latitudinalMeters: 500,
                longitudinalMeters: 500)
            
            mapOutlet.setRegion(region, animated: true)
            userLocationsHistory.append(userLocation)

        }
    }

    var startUserPoint = [CLLocation()]
    
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet{
            let coordinates = userLocationsHistory.map{ $0.coordinate}
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            
            route.title = "Маршрут"
            mapOutlet.addOverlay(route)
        }
    }
    
    
    private let userLocationIdentifier = "user_icon"
    private let reuseIdentifier = "activityCell"
    
    
    let motivationWords = ["Только вперёд!", "На Олимп!", "Не сдаваться!", "Топление к мечте!", "Наваливание!"]
    

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
     
        mapOutlet.showsUserLocation = true
        mapOutlet.delegate = self
        
        ActivityCollection.delegate = self
        ActivityCollection.dataSource = self
       
        
        startButton.addTarget(self, action: #selector(startActivity), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseActivity), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishActivity), for: .touchUpInside)
        
    }
    
    
    @objc func pauseActivity(sender: UIButton){
        if isPaused{
            isPaused = false
            
            prevDiff += pauseDate.timeIntervalSince(prevDate)
            
            prevDate = Date()

            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                             selector: #selector(updateLabel), userInfo: nil, repeats: true)
            
        }else{
            pauseDate = Date()
            timer.invalidate()
            isPaused = true
            
        }
        
    }
    
    
    @objc func finishActivity(sender: UIButton){
        
        mainStart.isHidden = !mainStart.isHidden
        progressStart.isHidden = !progressStart.isHidden
        
        let formatter = DateFormatter()
        
        let finish  = startUserPoint.last
        timer.invalidate()
        
        let date = Date()
        let diff = date.timeIntervalSince(prevDate) + prevDiff
        prevDate = Date()
        
        
        formatter.dateFormat = "d MMMM yyyy"
        let userActivity = ActivityEntity(context: fefuCoreDate.context)
    
        userActivity.activityDate = formatter.string(for: startDate)

        let formatterDuration = DateComponentsFormatter()
            

        formatterDuration.zeroFormattingBehavior = .pad
        formatterDuration.allowedUnits = [.hour, .minute, .second]
        
    
        
        userActivity.activityDuration = formatterDuration.string(from: diff)!
        print(userActivity.activityDuration!)
      

        userActivity.activityType = "На велике"
 
        userActivity.activityDistance = Double(String(format: "%.2f", start!.distance(from: finish!) / 1_000))!
        
        do{
            try fefuCoreDate.context.save()
            print(fefuCoreDate)
            
        }catch{
            print("не сохранился(")
        }
       
    }
    
    
    @objc func startActivity(sender: UIButton){
        
        mainStart.isHidden = !mainStart.isHidden
        progressStart.isHidden = !progressStart.isHidden
        activityName.text = motivationWords.randomElement()
        start = startUserPoint.first
        
        prevDate = Date()
        startDate = Date()
        

        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(updateLabel), userInfo: nil, repeats: true)
      
    }
    
    
    @objc func updateLabel(){
        let to = startUserPoint.last
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        let date = Date()
        let diff = date.timeIntervalSince(prevDate) + prevDiff
        
        timeLabel.text = formatter.string(from: diff)!
        distanceLabel.text = String(format: "%.2f", start!.distance(from: to!) / 1_000) + " км"
    

    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        print("cordinates:", currentLocation.coordinate)
        userLocation = currentLocation
        startUserPoint = locations
    }
}
    
let words = ["Велосипед", "Бег", "Ходьба" ]

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
     
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
            
        }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return words.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            let cell = ActivityCollection.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
            
            
            cell.label.text = words[indexPath.row]
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            return cell
        }
        
    
        
        
    }


    
    extension MapViewController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)-> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let render = MKPolylineRenderer(polyline:polyline)
                render.fillColor = UIColor.blue
                render.strokeColor = UIColor.blue
                render.lineWidth = 5
                return render
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? MKUserLocation{
                let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
                
                let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: userLocationIdentifier)
                view.image = UIImage(named: "ic_user_location")
                return view
            }
            return nil
        }
    }

