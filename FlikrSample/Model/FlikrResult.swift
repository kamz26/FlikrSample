//
//  FlikrResult.swift
//  FlikrSample
//
//  Created by Abhishek K on 29/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation

class FlikrResult:Codable{
    
    var page:Double?
    var pages:Double?
    var perpage:Double?
    var total:String?
    var photo:[Photo]?
}



