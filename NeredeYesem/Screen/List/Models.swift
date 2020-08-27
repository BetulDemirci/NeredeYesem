//
//  Models.swift
//  NeredeYesem
//
//  Created by Semafor on 24.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

struct Type : Decodable {
    var nearby_restaurants : [Type1]
}
struct Type1 : Decodable{
    var restaurant : Type2
}
struct Type2 : Decodable {
    var id : String
    var name : String
    var url : String
    var thumb : String
    var user_rating : Type3
    var location : Type4
    var currency : String
    var cuisines : String
    var price_range : Int64
    var average_cost_for_two : Int64
}
struct Type3 : Decodable {
    var aggregate_rating : String
    var rating_text : String
}
struct Type4 : Decodable {
    var latitude : String
    var longitude : String
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
