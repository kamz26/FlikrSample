//
//  FlikrSearchManager.swift
//  FlikrSample
//
//  Created by Abhishek K on 29/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
class FlikrSearchClient:NSObject{
   
    var responseData:PicCollection?
    func searchFlickrForTerm(_ searchText:String, completion:@escaping (_ success: Bool, _ error: NSError?) -> ()){
        
        let urlStr = "\(FlikrSearchClient.Constant.searchUrl)\(searchText)"
        let url = URL.init(string: urlStr)
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            guard let data = data else { return }
            do{
                strongSelf.responseData = try JSONDecoder().decode(PicCollection.self, from: data)
                completion(true,nil)
            }catch{
                completion(false,error as NSError)
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
    
    struct Constant{
        static let searchUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f2ddfcba0e5f88c2568d96dcccd09602&format=json&nojsoncallback=1&safe_search=1&text="
    }
    
}
