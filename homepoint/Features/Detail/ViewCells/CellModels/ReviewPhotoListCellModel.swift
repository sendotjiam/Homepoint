//
//  ReviewPhotoListCellModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/07/22.
//

import Foundation

final class ReviewPhotoListCellModel {
    let imageUrl : String
    let index : Int
    
    init(imageUrl: String, index: Int) {
        self.imageUrl = imageUrl
        self.index = index
    }
}
