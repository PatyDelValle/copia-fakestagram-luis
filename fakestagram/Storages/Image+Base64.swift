//
//  Image+Base64.swift
//  fakestagram
//
//  Created by patricia  D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    //encripta los datos en Base64
    func encodedBase64() -> String? {
        guard let data = self.jpegData(compressionQuality: 0.95) else {return  nil}
        return "data:image/jpeg;base64,\(data.base64EncodedString())" //encriptando
        
    }
}
