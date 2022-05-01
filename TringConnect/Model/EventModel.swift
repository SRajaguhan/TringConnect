//
//  EventModel.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import Foundation

struct ResponseData: Decodable {
    var event: [Events]
}
struct Events : Decodable {
    var name: String
    var image: String
}

