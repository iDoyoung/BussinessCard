//
//  SearchLocationViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/11.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
    func clearPins()
}

protocol HandleLocationInfo {
    func updateInfo(name: String?, adress: String?)
}

protocol SetCompanyDelegate {
    func setCompanyInfo(name: String?, location: String?)
}

class SearchLocationViewController: UIViewController {

    var resultSearchController: UISearchController? = nil
    var locationManager = CLLocationManager()
    var selectPin: MKPlacemark? = nil
    var delegate : SetCompanyDelegate!


    
    @IBOutlet weak var locationInfoView: UIView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationAdress: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func doneSetting(_ sender: UIButton) {
        if let company = self.locationName.text, let adress = self.locationAdress.text {
            self.delegate?.setCompanyInfo(name: company, location: adress)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationInfoView.isHidden = true
        
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        //MARK: - Set up resultSearchController
        let locationTableVC = storyboard!.instantiateViewController(withIdentifier: "LocationTableViewController") as! LocationTableViewController
        resultSearchController = UISearchController(searchResultsController: locationTableVC)
        resultSearchController?.searchResultsUpdater = locationTableVC
        
        //MARK: - Set up SearchBar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        //MARK: - UISearchBar Appearance
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationTableVC.mapView = mapView
        locationTableVC.handleMapSearchDelegate = self
        locationTableVC.handleLocatuonInfo = self
    }
    
}
extension SearchLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}
extension SearchLocationViewController: HandleMapSearch {
    
    func clearPins() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectPin = placemark
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}


extension SearchLocationViewController: HandleLocationInfo {
    
    func updateInfo(name: String?, adress: String?) {
//        var company = locationName.text
//        var location = locationAdress.text
        if name != nil{
            locationName.text = name
        } else {
            locationName.text = "Can't find.."
        }
        if adress != nil {
            locationAdress.text = adress
        } else {
            locationAdress.text = "Can't find.."
        }
        locationInfoView.isHidden = false
    }
}
