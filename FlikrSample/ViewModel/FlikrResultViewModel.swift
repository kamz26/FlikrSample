//
//  FlikrResultViewModel.swift
//  FlikrSample
//
//  Created by Abhishek K on 01/04/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit

class FlikrResultViewModel:NSObject{
    
    @IBOutlet weak var flikrsearchclient:FlikrSearchClient!
    var photoViewModelArr = [PhotoViewModel]()
    
    func searchForStr(str:String, completion: @escaping ((Bool) -> Void)){
        
        self.flikrsearchclient.searchFlickrForTerm(str){(sucess, error) in
            
            if sucess{
                for photo in (self.flikrsearchclient.responseData?.photos.photo)!{
                    let pic = PhotoViewModel(pic: photo)
                    self.photoViewModelArr.append(pic)
                }
                completion(true)
                
            }else{
                completion(false)
                return
            }
        }
    }
    
    
}

