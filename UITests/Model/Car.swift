//
//  DummyData.swift
//  UITests
//
//  Created by Benjamin Vigier on 5/26/18.
//  Copyright © 2018 Benjamin Vigier. All rights reserved.
//

import Foundation
import UIKit

enum CarBrand : String{
    case bmw = "BMW"
    case astonmartin = "ASTON MARTIN"
    case porsche = "PORSCHE"
    case audi = "AUDI"
}


class Car : NSObject{
    let brand : CarBrand
    let model : String
    let color : String
    let photo : UIImage
    let logo : UIImage
    let id = 0

    init(brand: CarBrand, model: String, color: String, photo: UIImage?, logo: UIImage){
        self.brand = brand
        self.model = model
        self.color = color
        if photo == nil{
            self.photo = UIImage(imageLiteralResourceName: "defaultcar")
        }
        else {self.photo = photo!}
        self.logo = logo
    }
    
    
}
