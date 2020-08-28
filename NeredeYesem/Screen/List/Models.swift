//
//  Models.swift
//  NeredeYesem
//
//  Created by Semafor on 24.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

struct Type : Codable {
    var nearby_restaurants : [Type1]?
    enum CodingKeys: String, CodingKey {
           case nearby_restaurants = "nearby_restaurants"
       }

       init(from decoder: Decoder) throws {
           let values = try? decoder.container(keyedBy: CodingKeys.self)
           nearby_restaurants = try? values?.decodeIfPresent([Type1].self, forKey: .nearby_restaurants)
       }
}
struct Type1 : Codable{
    var restaurant : Type2?
    enum CodingKeys: String, CodingKey {
        case restaurant = "restaurant"
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        restaurant = try? values?.decodeIfPresent(Type2.self, forKey: .restaurant)
    }
}
struct Type2 : Codable {
    var id : String?
    var name : String?
    var url : String?
    var thumb : String?
    var user_rating : Type3
    var location : Type4
    var currency : String?
    var cuisines : String?
    var price_range : Int64?
    var average_cost_for_two : Int64?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case thumb = "thumb"
        case user_rating = "user_rating"
        case location = "location"
        case currency = "currency"
        case cuisines = "cuisines"
        case price_range = "price_range"
        case average_cost_for_two = "average_cost_for_two"
        
    }
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
         thumb = try? values?.decodeIfPresent(String.self, forKey: .thumb)
        user_rating = try! Type3(from: decoder)
        location = try! Type4(from: decoder)
         currency = try? values?.decodeIfPresent(String.self, forKey: .currency)
         cuisines = try? values?.decodeIfPresent(String.self, forKey: .cuisines)
         price_range = try? values?.decodeIfPresent(Int64.self, forKey: .price_range)
         average_cost_for_two = try? values?.decodeIfPresent(Int64.self, forKey: .average_cost_for_two)
    }
    
   
}
struct Type3 : Codable {
    var aggregate_rating : String?
    var rating_text : String?
    enum CodingKeys: String, CodingKey {
        case aggregate_rating = "aggregate_rating"
         case rating_text = "rating_text"
    }
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        aggregate_rating = try? values?.decodeIfPresent(String.self, forKey: .aggregate_rating)
        rating_text = try? values?.decodeIfPresent(String.self, forKey: .rating_text)
    }
}
struct Type4 : Codable {
    var latitude : String?
    var longitude : String?
    enum CodingKeys: String, CodingKey {
          case latitude = "latitude"
           case longitude = "rating_text"
      }
      init(from decoder: Decoder) throws {
          let values = try? decoder.container(keyedBy: CodingKeys.self)
          latitude = try? values?.decodeIfPresent(String.self, forKey: .latitude)
          longitude = try? values?.decodeIfPresent(String.self, forKey: .longitude)
      }
}
struct datatype : Identifiable {
    var id : String
    var name : String
    var image : String
    var rating : String
    var webUrl : String
    var currency : String
    var cuisines : String
    var average_cost_for_two : Int64
    var rating_text : String
    var latitude : String
    var longitude : String
}
