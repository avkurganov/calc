//
//  DiscountViewController.swift
//  calculator
//
//  Created by Andrey Kurganov on 10/3/17.
//  Copyright © 2017 Andrey Kurganov. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DiscountViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var amountOfDiscount: UITextField!
    
    @IBOutlet weak var priceAfterDiscount: UITextField!
    
    @IBOutlet weak var saleTax: UITextField!
    
    @IBOutlet weak var saleTaxField: UITextField!
    
    @IBOutlet weak var total: UITextField!
    
    @IBOutlet weak var myLocationDisplay: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        
        let tax = Double(saleTax!.text!)
        
        let price = Double(itemPrice!.text!)
        let discount = Double(amountOfDiscount!.text!)!/100 * price!
        
        let priceWithDiscount = price! - discount
        
        let saleTaxCalc = priceWithDiscount * tax! / 100
        
        let finalPrice = priceWithDiscount + saleTaxCalc
        
        priceAfterDiscount.text! = String(format: "%.2f", priceWithDiscount)
        
        saleTaxField.text! = String(format: "%.2f",saleTaxCalc)
        
        total.text! = String(format: "%.2f",finalPrice)
        
    }
    
             func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    
                let location = locations[0]
    
//                let myLocation = CLLocation(latitude : location.coordinate.latitude, longitude: location.coordinate.longitude)
    
                CLGeocoder().reverseGeocodeLocation(location)  { (placemarks, error) -> Void in
    
                    if error != nil {
    
                        print("fail")
                        return
                    }else{
    
                        print(placemarks![0].thoroughfare!)
                        
                        if (placemarks?[0]) != nil {
    
                        let pm = placemarks?[0] as CLPlacemark!
    
                        let address = (pm?.subThoroughfare)! + " " + (pm?.thoroughfare)! + "," + (pm?.locality)! + "," +
                            (pm?.administrativeArea)! + " " + (pm?.postalCode)! + " " + (pm?.isoCountryCode)!
    
    
    
                            if (pm?.subThoroughfare) != nil{
                                
                       print(address)
                                
                            self.myLocationDisplay.text! = address
                                
                        }
                            
                    }else{
    
                        print("Error")
                    }
    
                }
                }
        }
    
    
    
        let manager = CLLocationManager()
    
        override func viewDidLoad(){
    
            super.viewDidLoad()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
    
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
