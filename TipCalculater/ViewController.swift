//
//  ViewController.swift
//  TipCalculater
//
//  Created by Jenkins on 8/19/17.
//  Copyright © 2017 com.jdark. All rights reserved.
//

import UIKit


extension String {
    var twoFractionDigits: String {
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 2
        styler.maximumFractionDigits = 2
        styler.numberStyle = .currency
        let converter = NumberFormatter()
        converter.decimalSeparator = "."
        if let result = converter.number(from: self) {
            return styler.string(from: result)!
        }
        return ""
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBAction func onEditChange(_ sender: AnyObject) {
        var tipPercentages = [0.1, 0.15, 0.2]
        
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        
        var tipAmount = billAmount * tipPercentage
        
        var total = billAmount + tipAmount
        
        print("billAmount = \(billAmount)")
        print("tipAmount = \(tipAmount)")
        print("tipControl index = \(tipControl.selectedSegmentIndex)")
        print("tipPercentage = \(tipPercentage)")
        print("---------------------------")
        
        tipLabel.text = "\(tipAmount)"
        totalLabel.text = "\(total)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.backgroundColor = UIColor.yellow
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
    }

    @IBAction func clearButton(_ sender: UIButton) {
        billField.text = ""
        tipLabel.text = ""
        totalLabel.text = ""
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

