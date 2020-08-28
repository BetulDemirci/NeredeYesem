//
//  Utils.swift
//  NeredeYesem
//
//  Created by Semafor on 24.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//
import UIKit

class NetworkingService{
    
    static let shared = NetworkingService()
    private init(){}
        
    let api = "327e75c31ca03dbb55cbabe4257acfa9"
    var urlString = "https://developers.zomato.com/api/v2.1/geocode?&";
    var datas = [datatype]()
    
    public func getRestaurantsInformation(lat:Double,lon:Double,completionHandler:@escaping ([datatype], Error?)->Void) {
    
        DispatchQueue.global(qos: .userInteractive).sync {
            urlString += "lat=\(lat)&lon=\(lon)"
           // urlString += "lat=\(37.7981555556)&lon=\(-122.4072638889)"
            print(urlString)
            let url = URL(string: urlString)
            var request = URLRequest(url: url!)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(api, forHTTPHeaderField: "user-key")
            request.httpMethod = "GET"
            
            let sess = URLSession(configuration: .default)
            sess.dataTask(with: request) { (data, _, _) in
                
                do{
                    let fetch = try JSONDecoder().decode(Type.self, from: data!)
                    print(fetch)
                    dump(fetch.nearby_restaurants)
                   
                    for i in fetch.nearby_restaurants!{
                        self.datas.append(datatype(id: i.restaurant?.id ?? "", name: i.restaurant?.name ?? "", image: i.restaurant?.thumb ?? "", rating: i.restaurant?.user_rating.aggregate_rating ?? "", webUrl: i.restaurant?.url ?? "", currency: i.restaurant?.currency ?? "", cuisines: i.restaurant?.cuisines ?? "", average_cost_for_two: i.restaurant?.average_cost_for_two ?? 0, rating_text: i.restaurant?.user_rating.rating_text ?? "", latitude: i.restaurant?.location.latitude ?? "0", longitude: i.restaurant?.location.longitude ?? "0"))
                        
                    }
                    print("kontrol")
                    dump(self.datas)
                    completionHandler(self.datas,nil)
                }
                catch {
                    print(error.localizedDescription)
                    completionHandler(self.datas,error)
                }
            }.resume()
        }
    }
}
