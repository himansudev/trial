//
//  JSON Parse Data.swift
//  MapModuleFinal
//
//  Created by VIDUSHI DUHAN on 06/02/20.
//  Copyright © 2020 Osos Private Limited. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Sending Media data requirements

struct Media
{
    let key : String
    let filename : String
    let data : Data
    let mimetype : String
    
    init?(withImage image : UIImage, forKey key : String)
    {
        self.key = key
        self.mimetype = "image/jpeg"
        self.filename = "pic\(arc4random()).jpeg"
   
        guard let data1 = image.jpegData(compressionQuality: 0.75) else { return nil }
        self.data = data1
        
    }
}
