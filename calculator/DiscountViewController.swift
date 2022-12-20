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

    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var amountOfDiscount: UITextField!
    
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
        
            let price = Double(self.itemPrice!.text!)
        
            let discount = Double(self.amountOfDiscount!.text!)!/100 * price!
        
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
                            self.myLocationDisplay.text? = zip
                        }
                        else {
                           print("Problem with the data received from geocoder")
                        }
                    })
        }
    var manager: CLLocationManager!
    
        override func viewDidLoad(){
    
            super.viewDidLoad()
            manager = CLLocationManager()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.distanceFilter = 5.0
            manager.startUpdatingLocation()
    
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}



struct DiscountViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
