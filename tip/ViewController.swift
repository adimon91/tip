//
//  ViewController.swift
//  tip
//
//  Created by Angela Dimon on 12/19/20.
//



import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var firstBox: UIView!
    @IBOutlet weak var secondBox: UIView!
    @IBOutlet weak var resetBox: UIView!
    @IBOutlet weak var partyField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style view boxes
        firstBox.layer.borderWidth = 5
        firstBox.layer.borderColor = UIColor.darkGray.cgColor
        firstBox.layer.cornerRadius = 25
        
        secondBox.layer.borderWidth = 5
        secondBox.layer.borderColor = UIColor.darkGray.cgColor
        secondBox.layer.cornerRadius = 25
        
        resetBox.layer.borderWidth = 5
        resetBox.layer.borderColor = UIColor.darkGray.cgColor
        resetBox.layer.cornerRadius = 25
        
        // make the bill field the first responder
        billField.becomeFirstResponder()
        
        // customize currency for billField placeholder
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        
        // localize to current locale
        currencyFormatter.locale = Locale.current
        
        // update placeholder for billField
        billField.placeholder = currencyFormatter.string(from: NSNumber(value: 0))!
        }
    
    @IBAction func onTapReset(_ sender: Any) {
        // get defaults
        let defaults = UserDefaults.standard
        
        // set tip control bar titles
        tipControl.setTitle("\(15)%", forSegmentAt: 0)
        tipControl.setTitle("\(18)%", forSegmentAt: 1)
        tipControl.setTitle("\(20)%", forSegmentAt: 2)
        
        // reset defaults to common tip percentages
        defaults.set(15, forKey: "tip1")
        defaults.set(18, forKey: "tip2")
        defaults.set(20, forKey: "tip3")
        
        // clear billField and call calculateTip to clear tip and total labels
        billField.text = ""
        partyField.text = "1"
        self.calculateTip(UIView.self)
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func partyChange(_ sender: Any) {
        self.calculateTip(UITextField.self)
    }
    @IBAction func calculateTip(_ sender: Any) {
        // get defaults
        let defaults = UserDefaults.standard
        
        // get the bill amount from billField
        let bill = Double(billField.text!) ??  0
        
        let partySize = Double(partyField.text!) ?? 1
        
        // get tip percentages from defaults
        let tip1 = defaults.double(forKey: "tip1") / 100
        let tip2 = defaults.double(forKey: "tip2") / 100
        let tip3 = defaults.double(forKey: "tip3") / 100
        
        // set tip percentages
        let tipPercentages = [tip1, tip2, tip3]
        
        // calculate tip and total
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let total = bill + tip
        
        // customize currency
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        
        // localize to current locale
        currencyFormatter.locale = Locale.current
        
        // update the tip and total labels
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip/partySize))!
        
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total/partySize))!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // update the tip amount from settings
        let defaults = UserDefaults.standard
        let tip1 = defaults.double(forKey: "tip1") / 100
        let tip2 = defaults.double(forKey: "tip2") / 100
        let tip3 = defaults.double(forKey: "tip3") / 100
        
        // set tip control bar titles
        tipControl.setTitle("\(Int(tip1*100))%", forSegmentAt: 0)
        tipControl.setTitle("\(Int(tip2*100))%", forSegmentAt: 1)
        tipControl.setTitle("\(Int(tip3*100))%", forSegmentAt: 2)
        
        // dark mode
        let darkOn = defaults.bool(forKey: "darkOn")
        if darkOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // calculate tip after returning from settings
        self.calculateTip(UIView.self)
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("view will disappear")
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("view did disappear")
//    }
    

}

