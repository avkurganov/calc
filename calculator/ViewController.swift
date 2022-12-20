//
//  ViewController.swift
//  calculator
//
//  Created by Andrey Kurganov on 9/20/17.
//  Copyright © 2017 Andrey Kurganov. All rights reserved.
//

import UIKit


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
        customTipTextField.isEnabled = true
        customTipTextField.text! = "\(Int(sender.value))"
        calculateCustomTips(total: Double(totalSumm.text!)!, splitOn: splitLabel.text!)
        calculateTips(total: Double(totalSumm.text!)!, splitOn: splitLabel.text!)
    }

    @IBOutlet weak var splitLabel: UILabel!
    
    @IBOutlet weak var sliderCustomSplit: UIStepper!
    
    @IBAction func splitStepper(_ sender: UIStepper) {
        splitLabel.text = "\(Int(sender.value))"
        print( customTipTextField.isEnabled)
        if customTipTextField.isEnabled{
        calculateCustomTips(total: Double(totalSumm.text!)!, splitOn: splitLabel.text!)
        }
        calculateTips(total: Double(totalSumm.text!)!, splitOn: splitLabel.text!)
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        calculateTips(total: Double("0.00")!, splitOn: splitLabel.text!)
        sliderCustomTip.isEnabled = false
        sliderCustomTip.isSelected = false
        sliderCustomSplit.isEnabled = false
        
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
            
            calculateTips(total: Double("0.00")!, splitOn: splitLabel.text!)
            sliderCustomTip.isEnabled = false
            sliderCustomTip.isSelected = false
            splitLabel.isEnabled = false
            customTipTextField.isEnabled = false
            sliderCustomSplit.isEnabled = false
      
        }else{
            splitLabel.isEnabled = true
            sliderCustomTip.isEnabled = true
            sliderCustomTip.isSelected = true
            sliderCustomSplit.isEnabled = true
            calculateTips(total: Double(prospectiveText)!, splitOn: splitLabel.text!)
        }
    }
   
   return pass
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalSumm.delegate = self
        customTipTextField.isEnabled = false
    }
    
    func calculateCustomTips(total: Double, splitOn: String) {
        if customTipTextField.isEnabled{
            print("total calculateCustomTips")
            var tipCustom: Double
            
            if customTipTextField.text! == "" {
                 tipCustom = 5
            }else{
             
                tipCustom = Double(customTipTextField.text!)!
                
            }
        
            
            print("tipCustom \(customTipTextField.text!)")
            let grandTotalCustom = total * Double(tipCustom) / 100
            let totalCustomSummaryValue = grandTotalCustom + total
            
            customTipTextField.text! = "\(tipCustom)"
            grandTotalCustomField.text! =  String(format: "%.2f",grandTotalCustom)
            totalCustomSummary.text! = String(format: "%.2f",totalCustomSummaryValue/Double(splitOn)!)
        }
    }

    func calculateTips(total: Double, splitOn: String) {
        
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
        
        grandTotalField.text! = String(format: "%.2f",grandTotal10/Double(splitOn)!)
        grandTotalField15.text! = String(format: "%.2f",grandTotal15/Double(splitOn)!)
        grandTotalField18.text! = String(format: "%.2f",grandTotal18/Double(splitOn)!)
        grandTotalField20.text! = String(format: "%.2f",grandTotal20/Double(splitOn)!)
       
       
    }

}

