//
//  ViewController.swift
//  TipCalculater
//
//  Created by Kim Abbott on 8/19/17.
//  Copyright © 2017 com.jdark. All rights reserved.
//

import UIKit

extension String {
    // formatting text to currency

    func cleanString() -> String {
        // remove from String: "$", ".", ","
        var stringToUpdate = self
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        stringToUpdate = regex.stringByReplacingMatches(in: stringToUpdate, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        return stringToUpdate
    }
    
    func formatStringToCurrency() -> String {
        // let's create some variables
        let stringFormatter = NumberFormatter()
        var numberToString = NSNumber()
        // update our formatter with some formats
        stringFormatter.minimumFractionDigits = 2
        stringFormatter.maximumFractionDigits = 2
        stringFormatter.numberStyle = .currency
        stringFormatter.decimalSeparator = "."
        // clean up to remove any pre-existing currency formatting
        let amountWithPrefix = self
        let double = (amountWithPrefix.cleanString() as NSString).doubleValue
        
        numberToString = NSNumber(value: double)
        // if first number is 0 or all numbers were delete        
        guard numberToString != 0 as NSNumber else {
            return "111"
        }
        return stringFormatter.string(from: numberToString)!
        // return "999"
    }
}

func formatDoubleToCurrency(value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    let result = formatter.string(from: value as NSNumber)
    return result!
}

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBAction func onEditChange(_ sender: AnyObject) {
        var tipPercentages = [0.1, 0.15, 0.2]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmountUsedForCalculation = NSString(string: billField.text!.cleanString()).doubleValue
        var tipAmount = billAmountUsedForCalculation * tipPercentage
        var total = billAmountUsedForCalculation + tipAmount
        
        // Display values in fields
        tipLabel.text = "\(formatDoubleToCurrency(value: tipAmount))"
        totalLabel.text = "\(formatDoubleToCurrency(value: total))"
        
        // Stuff for logs
        print("billField = \(billField)")
        print("billAmountUsedForCalculation = \(billAmountUsedForCalculation)")
        print("tipAmount = \(tipAmount)")
        print("tipControl index = \(tipControl.selectedSegmentIndex)")
        print("tipPercentage = \(tipPercentage)")
        print("---------------------------")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.backgroundColor = UIColor.yellow
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        //billField.addTarget(self, action: #selector(myBillFieldDidChange), for: .editingChanged)
    }
    
    func myBillFieldDidChange(_ billField: UITextField) {
        
        if let amountString = billField.text?.formatStringToCurrency() {
            billField.text = amountString
        }
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

