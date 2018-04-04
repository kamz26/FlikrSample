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
    
    func setUp(vm:PhotoViewModel){
        
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData =  try Data.init(contentsOf: vm.url)
                DispatchQueue.main.async {
                    let image = UIImage.init(data: imageData)
                    self.flikrImage.image = image
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
