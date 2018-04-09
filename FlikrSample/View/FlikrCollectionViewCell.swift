//
//  FlikrCollectionViewCell.swift
//  FlikrSample
//
//  Created by Abhishek K on 28/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit

class FlikrCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flikrImage: UIImageView!
    
    var cache = NSCache<AnyObject, UIImage>()
    
    func setUp(vm:PhotoViewModel){
        
        if cache.object(forKey: vm.url as AnyObject) != nil{
            
            
            self.flikrImage.image = self.cache.object(forKey: vm.url as AnyObject)
            
        }else{
        
            DispatchQueue.global(qos: .userInitiated).async{
      
            do{
                let imageData =  try Data.init(contentsOf: vm.url)
                DispatchQueue.main.async {
                    let image = UIImage.init(data: imageData)
                    self.flikrImage.image = image
                    self.cache.setObject(image!, forKey: vm.url as AnyObject)
                }
            }catch{
                print(error.localizedDescription)
            }
            
        }
        }
    }
}
