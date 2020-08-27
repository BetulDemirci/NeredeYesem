//
//  DetailsViewController.swift
//  NeredeYesem
//
//  Created by Semafor on 23.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    let imageUrls: [UIImage] = [#imageLiteral(resourceName: "food1"),#imageLiteral(resourceName: "food2"),#imageLiteral(resourceName: "food3"),#imageLiteral(resourceName: "food10"),#imageLiteral(resourceName: "food5"),#imageLiteral(resourceName: "food6"),#imageLiteral(resourceName: "food9"),#imageLiteral(resourceName: "food7"),#imageLiteral(resourceName: "food4")]
    var name = String()
    var price = String()
    var currency = String()
    var rating = String()
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantPrice: UILabel!
    @IBOutlet weak var restaurantCurrency: UILabel!
    @IBOutlet weak var restaurantAggregateRating: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: datatype? {
          didSet {
           print(viewModel!.name)
            updateView()
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        restaurantName.text = name
        restaurantPrice.text = price
        restaurantCurrency.text = currency
        restaurantAggregateRating.text = rating
        let coordinate = CLLocation(latitude: lat, longitude: lon)
        centerMap(for: coordinate)
    }
    
    func updateView() {
        if let viewModel = viewModel {
            name = viewModel.name
            price = String(viewModel.average_cost_for_two)
            currency = viewModel.cuisines
            rating = viewModel.rating
            lat = Double(viewModel.latitude)!
            lon = Double(viewModel.longitude)!
           
        }
    }
    
    func centerMap(for coordinate: CLLocation) {
        let region = MKCoordinateRegion(center: coordinate.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
    }
}
extension DetailsViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailCollectionViewCell
        cell.imageView.image = imageUrls[indexPath.row]
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height-70)
       }
}
