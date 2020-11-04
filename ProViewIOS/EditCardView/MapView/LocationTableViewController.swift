//
//  LocationTableViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/11.
//


import UIKit
import MapKit

class LocationTableViewController: UITableViewController {
    var mapView: MKMapView? = nil
    var matchingItems: [MKMapItem] = []
    
    var handleMapSearchDelegate: HandleMapSearch? = nil
    var handleLocatuonInfo: HandleLocationInfo? = nil
    
   func parseAddress(selectedItem:MKPlacemark) -> String {
       // put a space between "4" and "Melrose Place"
       let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
       // put a comma between street and city/state
       let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
       // put a space between "Washington" and "DC"
       let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
       let addressLine = String(
           format:"%@%@%@%@%@%@%@",
           // street number
           selectedItem.subThoroughfare ?? "",
           firstSpace,
           // street name
           selectedItem.thoroughfare ?? "",
           comma,
           // city
           selectedItem.locality ?? "",
           secondSpace,
           // state
           selectedItem.administrativeArea ?? ""
       )
       return addressLine
   }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        let locationName = selectedItem.name!
        let locationAdress = parseAddress(selectedItem: selectedItem)
        handleMapSearchDelegate?.clearPins()
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        handleLocatuonInfo?.updateInfo(name: locationName, adress: locationAdress)
        
        dismiss(animated: true, completion: nil)
    }
}

extension LocationTableViewController: UISearchResultsUpdating {
    //MARK: - Set up API
    func updateSearchResults(for searchBarController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchBarController.searchBar.text else { return }
        let request  = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
