//
//  ViewController.swift
//  FlikrSample
//
//  Created by Abhishek K on 27/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit
import WaterfallLayout


class ViewController: UIViewController {
    
    var numberOfColum:CGFloat = 2
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet   weak var flikrResultVm:FlikrResultViewModel!
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
   var lastOrientation:UIDeviceOrientation!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        lastOrientation = UIDevice.current.orientation
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func rotated() {
        
        let currentOrientation = UIDevice.current.orientation
        
        guard UIDeviceOrientationIsLandscape(currentOrientation) || UIDeviceOrientationIsPortrait(currentOrientation) else {   // we are only interested in Portrait and Landscape orientations
            return
        }
        
        guard currentOrientation != lastOrientation else { //remember the case of Portrait-FaceUp-Portrait? Here we make sure that in such cases we don't reload table view
            return
        }
        
        if UIDeviceOrientationIsLandscape(currentOrientation){
            numberOfColum = 3
        }else{
            numberOfColum = 2
        }
        
        lastOrientation = currentOrientation
        
        collectionView.reloadData()
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (numberOfColum + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / numberOfColum
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
       return flikrResultVm.photoViewModelArr.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        return flikrResultVm.photoViewModelArr[indexPath.row].cellInstance(collectionView,indexPath: indexPath)

    }
}




extension ViewController : UITextFieldDelegate {
    
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      var  finalStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
      finalStr = finalStr.replacingOccurrences(of: " ", with: "%20")
    if string == "\n"  {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
       finalStr = finalStr.replacingOccurrences(of: "\n", with: "")
       textField.resignFirstResponder()
        DispatchQueue.global().async {
            self.flikrResultVm.searchForStr(str: finalStr){(result) in
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
                
            }
   
    }
    }
        return true
    }
}









