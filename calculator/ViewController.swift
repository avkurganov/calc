//
//  ViewController.swift
//  calculator
//
//  Created by Andrey Kurganov on 9/20/17.
//  Copyright © 2017 Andrey Kurganov. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var totalSumm: UITextField!

    @IBOutlet weak var grandTotalField: UILabel!
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var result15: UILabel!
    
    @IBOutlet weak var result18: UILabel!
    
    @IBOutlet weak var result20: UILabel!
    
    @IBOutlet weak var grandTotalField15: UILabel!

    @IBOutlet weak var grandTotalField18: UILabel!
    
    @IBOutlet weak var grandTotalField20: UILabel!
    
    @IBOutlet weak var myLocationDisplay: UILabel!

   
    @IBAction func calculateTips(_ sender: UIButton) {
        
        let total = Double(totalSumm!.text!)
        
        let tip10 = total! * 0.10
        let tip15 = total! * 0.15
        let tip18 = total! * 0.18
        let tip20 = total! * 0.20
        
        let grandTotal10 = total! + tip10
        let grandTotal15 = total! + tip15
        let grandTotal18 = total! + tip18
        let grandTotal20 = total! + tip20
        
        result.text! = String(format: "%.2f",tip10)
        result15.text! = String(format: "%.2f",tip15)
        result18.text! = String(format: "%.2f",tip18)
        result20.text! = String(format: "%.2f",tip20)
    
        grandTotalField.text! = String(format: "%.2f",grandTotal10)
        grandTotalField15.text! = String(format: "%.2f",grandTotal15)
        grandTotalField18.text! = String(format: "%.2f",grandTotal18)
        grandTotalField20.text! = String(format: "%.2f",grandTotal20)
        
       
    }

}

