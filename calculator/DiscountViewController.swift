//
//  DiscountViewController.swift
//  calculator
//
//  Created by Andrey Kurganov on 10/3/17.
//  Copyright © 2017 Andrey Kurganov. All rights reserved.
//

import SwiftUI
import CoreLocation

class DiscountViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var myPrice: UITextField!
    
    
    @IBOutlet weak var currentDiscount: UITextField!
    
    @IBOutlet weak var priceAfterDiscount: UITextField!
    
    @IBOutlet weak var saleTax: UITextField!
    
    @IBOutlet weak var saleTaxField: UITextField!
    
    @IBOutlet weak var total: UITextField!
    
    @IBOutlet weak var myLocationDisplay: UILabel!
    
    @IBAction func calculate(_ sender: Any)  {
        
        Api().getSaleTax(zipCode: Int(myLocationDisplay.text!)!) {
        (saleTaxResp) in
            self.saleTax.text! = "\(saleTaxResp.totalRate * 100)"
        
            let tax = Double(self.saleTax!.text!)
        
            let price = Double(self.myPrice!.text!)
        
            let discount = Double(self.currentDiscount!.text!)!/100 * price!
        
        let priceWithDiscount = price! - discount
        
        let saleTaxCalc = priceWithDiscount * tax! / 100
        
        let finalPrice = priceWithDiscount + saleTaxCalc
        
            self.priceAfterDiscount.text! = String(format: "%.2f", priceWithDiscount)
        
            self.saleTaxField.text! = String(format: "%.2f",saleTaxCalc)
        
            self.total.text! = String(format: "%.2f",finalPrice)
        }
    }
    
             func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    
                let location = locations[0]
        
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { [self](placemarks, error) -> Void in

                        if error != nil {
                            print("Reverse geocoder failed with error" + error!.localizedDescription)
                            return
                        }

                        if placemarks!.count > 0 {
                            
                            let zip = placemarks![0].postalCode!

                            print(zip) //prints zip code
                            myLocationDisplay.text? = zip
                        }
                        else {
                           print("Problem with the data received from geocoder")
                        }
                    })
        }

        let manager = CLLocationManager()
    
        override func viewDidLoad(){
    
            super.viewDidLoad()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
    
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
