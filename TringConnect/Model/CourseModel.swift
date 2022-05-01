//
//  CourseModel.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import Foundation

struct ResponseDataItem: Decodable {
    var course: [Course]
}
struct Course : Decodable {
    var name: String
    var image: String
}
