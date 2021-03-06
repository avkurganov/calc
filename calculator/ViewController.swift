//
//  ViewController.swift
//  calculator
//
//  Created by Andrey Kurganov on 9/20/17.
//  Copyright © 2017 Andrey Kurganov. All rights reserved.
//

import SwiftUI


class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var totalSumm: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var result15: UILabel!
    
    @IBOutlet weak var result18: UILabel!
    
    @IBOutlet weak var result20: UILabel!
    
    @IBOutlet weak var grandTotalField: UILabel!
    
    @IBOutlet weak var grandTotalField15: UILabel!
    
    @IBOutlet weak var grandTotalField18: UILabel!
    
    @IBOutlet weak var grandTotalField20: UILabel!
    
    @IBOutlet weak var sliderCustomTip: UISlider!

    @IBOutlet weak var customTipTextField: UILabel!
    
    @IBOutlet weak var grandTotalCustomField: UILabel!
    
    @IBOutlet weak var totalCustomSummary: UILabel!
    
    @IBAction func sliderDidValue(_ sender: UISlider) {
        customTipTextField.text! = "\(Int(sender.value))"
        calculateCustomTips(total: Double(totalSumm.text!)!)
    }

    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        calculateTips(total: Double("0.00")!)
        sliderCustomTip.isEnabled = false
        sliderCustomTip.isSelected = false
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
   func textField(_ textField:UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Validating ...")
    
    let prospectiveText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    
    var pass = true
    
    if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
        pass = regex.numberOfMatches(in: prospectiveText, options: .reportProgress, range: NSRange(location: 0, length: (prospectiveText as NSString).length)) > 0
        
    }
    
    if pass {
        
        if prospectiveText.isEmpty || prospectiveText == "0.0" || Double(prospectiveText) == nil
            || prospectiveText == "0"{
            
            calculateTips(total: Double("0.00")!)
            sliderCustomTip.isEnabled = false
            sliderCustomTip.isSelected = false
      
        }else{
            sliderCustomTip.isEnabled = true
            sliderCustomTip.isSelected = true
            calculateTips(total: Double(prospectiveText)!)
        }
    }
   
   return pass
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalSumm.delegate = self
    }
    
    func calculateCustomTips(total: Double) {
        print("total calculateCustomTips")
        var tipCustom: Double
        
        if customTipTextField.text! == "" {
             tipCustom = 10
        }else{
            tipCustom = Double(customTipTextField.text!)!
        }
        
        print("tipCustom \(customTipTextField.text!)")
        let grandTotalCustom = total * Double(tipCustom) / 100
        let totalCustomSummaryValue = grandTotalCustom + total
        
        customTipTextField.text! = "\(tipCustom)"
        grandTotalCustomField.text! =  String(format: "%.2f",grandTotalCustom)
        totalCustomSummary.text! = String(format: "%.2f",totalCustomSummaryValue)
        
    }

    func calculateTips(total: Double) {
        
        let tip10 = total * 0.10
        let tip15 = total * 0.15
        let tip18 = total * 0.18
        let tip20 = total * 0.20
       
        let grandTotal10 = total + tip10
        let grandTotal15 = total + tip15
        let grandTotal18 = total + tip18
        let grandTotal20 = total + tip20
      
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

