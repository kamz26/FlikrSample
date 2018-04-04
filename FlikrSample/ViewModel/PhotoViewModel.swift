//
//  PhotoViewModel.swift
//  FlikrSample
//
//  Created by Abhishek K on 02/04/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit
protocol CellRepresent{
    func cellInstance(_ collectionView:UICollectionView, indexPath:IndexPath) -> UICollectionViewCell
}

class PhotoViewModel:CellRepresent{
    var photo:Photo?
    var farmStr:String{
        return String(describing:Int.init(photo!.farm!))
    }    
    var url:URL{
        let farm = String.init(describing: Int.init((photo?.farm!)!))
        let server = photo!.server!
        let id = photo!.id!
        let secret = photo!.secret!
        
        let urlStr = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        return URL.init(string: urlStr)!
        
        
        
    }
    
    init(pic:Photo) {
        self.photo = pic
    }
    
    
    
    func cellInstance(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FlikrCollectionViewCell
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        cell.setUp(vm:self)
        return cell
        
    }
    
    
    
    
}
