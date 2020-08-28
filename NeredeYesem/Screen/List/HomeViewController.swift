//
//  HomeViewController.swift
//  NeredeYesem
//
//  Created by Semafor on 23.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit
import CoreLocation
protocol ListActions: class {
    func didTapCell(_ viewController: UIViewController, viewModel: datatype)
}

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    var restaurants = [datatype]()
    var index = Int()
    weak var delegete: ListActions?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
               
               
                latitude = locValue.latitude
                longitude = locValue.longitude
                print("locations = \(latitude) \(longitude)")
                if latitude != 0 || longitude != 0 {
                       if !CheckInternet.Connection(){
                           self.Alert(Message: "Your Device is not connected with internet!")
                       }else{
                           self.activityIndicator.center = self.view.center
                           self.activityIndicator.hidesWhenStopped = true
                           self.activityIndicator.style = UIActivityIndicatorView.Style.gray
                           self.view.addSubview(self.activityIndicator)
                           self.activityIndicator.startAnimating()
                           //lat: 38.5317271069,lon: 27.1564288379)
                           //lat: 38.4237,lon: 27.1428
                           NetworkingService.shared.getRestaurantsInformation(lat: latitude,lon: longitude) { (datas, error) in
                               DispatchQueue.main.async {
                                   
                                   self.restaurants = datas
                                   if self.restaurants.count != 0{
                                       dump(self.restaurants)
                                       self.tableView.dataSource = self
                                       self.tableView.delegate = self
                                       self.tableView.reloadData()
                                       self.activityIndicator.stopAnimating()
                                      self.activityIndicator.isHidden = true
                                      self.activityIndicator.hidesWhenStopped = true
                                       
                                   }else{
                                      let errorString = error?.localizedDescription ?? "An error has occurred!Restaurants informations could not be fetched!"
                                      self.Alert(Message: errorString)
                                      self.activityIndicator.stopAnimating()
                                      self.activityIndicator.isHidden = true
                                      self.activityIndicator.hidesWhenStopped = true
                                      
                                   }
                               }
                           }
                       }
                 }else{
                     let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                                         storyBoard.modalPresentationStyle = .fullScreen
                                           self.present(storyBoard, animated: true, completion: nil)
                 }
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        
        
         latitude = locValue.latitude
         longitude = locValue.longitude
         print("locations = \(latitude) \(longitude)")
         if latitude != 0 || longitude != 0 {
                if !CheckInternet.Connection(){
                    self.Alert(Message: "Your Device is not connected with internet!")
                }else{
                    self.activityIndicator.center = self.view.center
                    self.activityIndicator.hidesWhenStopped = true
                    self.activityIndicator.style = UIActivityIndicatorView.Style.gray
                    self.view.addSubview(self.activityIndicator)
                    self.activityIndicator.startAnimating()
                    //lat: 38.5317271069,lon: 27.1564288379)
                    //lat: 38.4237,lon: 27.1428
                    NetworkingService.shared.getRestaurantsInformation(lat: 38.5317271069,lon: 27.1564288379) { (datas, error) in
                        DispatchQueue.main.async {
                            
                            self.restaurants = datas
                            if self.restaurants.count != 0{
                                dump(self.restaurants)
                                self.tableView.dataSource = self
                                self.tableView.delegate = self
                                self.tableView.reloadData()
                                self.activityIndicator.stopAnimating()
                               self.activityIndicator.isHidden = true
                               self.activityIndicator.hidesWhenStopped = true
                                
                            }else{
                               let errorString = error?.localizedDescription ?? "An error has occurred!Restaurants informations could not be fetched!"
                               self.Alert(Message: errorString)
                               self.activityIndicator.stopAnimating()
                               self.activityIndicator.isHidden = true
                               self.activityIndicator.hidesWhenStopped = true
                               
                            }
                        }
                    }
                }
          }else{
              let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
                                  storyBoard.modalPresentationStyle = .fullScreen
                                    self.present(storyBoard, animated: true, completion: nil)
          }
        
        
    }*/
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let vc = segue.destination as! DetailsViewController
            
        }
        
    }*/
    
    func Alert (Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        let logIn: UserDefaults? = UserDefaults.standard
        logIn?.set(false, forKey: "isUserLoggedIn")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "page") as! PageViewController
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestaurantTableViewCell
        dump(restaurants)
        cell.restaurantImage.imageFromURL(urlString:  restaurants[indexPath.row].image, PlaceHolderImage: UIImage.init(named: "placeholder")!)
        cell.restaurantName.text = restaurants[indexPath.row].name
        cell.restaurantRange.text = restaurants[indexPath.row].rating
        
       return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
       /* guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") else { return }
        navigationController?.pushViewController(detailsViewController, animated: true)
        let vm = restaurants[indexPath.row]
        delegete?.didTapCell(detailsViewController, viewModel: vm)*/
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        vc?.viewModel = restaurants[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
      
    }
    
}
extension UIImageView {
public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {

       if self.image == nil || urlString==""{
             self.image = PlaceHolderImage
       }
        
       URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

           if error != nil {
               print(error ?? "No Error")
               return
           }
           DispatchQueue.main.async(execute: { () -> Void in
               let image = UIImage(data: data!)
               self.image = image
           })

       }).resume()
   }}
