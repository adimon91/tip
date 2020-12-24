//
//  SettingsViewController.swift
//  tip
//
//  Created by Angela Dimon on 12/19/20.
//
 
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tip1Field: UITextField!
    @IBOutlet weak var tip2Field: UITextField!
    @IBOutlet weak var tip3Field: UITextField!
    @IBOutlet weak var darkToggle: UISwitch!
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set default tip percentages for text fields
        let defaults = UserDefaults.standard
        
        tip1Field.text = defaults.string(forKey: "tip1")
        tip2Field.text = defaults.string(forKey: "tip2")
        tip3Field.text = defaults.string(forKey: "tip3")
        
        // set dark mode
        let darkOn = defaults.bool(forKey: "darkOn")
        darkToggle.isOn = darkOn
        if darkOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    @IBAction func changeMode(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        
        // set to dark mode if switched
        if (sender.isOn) {
            defaults.set(true, forKey: "darkOn")
           overrideUserInterfaceStyle = .dark
        } else {
           defaults.set(false, forKey: "darkOn")
            overrideUserInterfaceStyle = .light
        }
    }
    
    @IBAction func setDefault1(_ sender: Any) {
        // set default for tip1 percentage
        let defaults = UserDefaults.standard

        // get tip1 amount
        let tip1 = Double(tip1Field.text!) ??  0
                
        // set default value for tip1
        defaults.set(tip1, forKey: "tip1")

        // Force UserDefaults to save
        defaults.synchronize()
    }
    
     @IBAction func setDefault2(_ sender: Any) {
        // set default for tip2 percentage
        let defaults = UserDefaults.standard
        
        let tip2 = Double(tip2Field.text!) ??  0
        
        defaults.set(tip2, forKey: "tip2")
        defaults.synchronize()
     }
    
    @IBAction func setDefault3(_ sender: Any) {
        // set default for tip3 percentage
        let defaults = UserDefaults.standard
        
        let tip3 = Double(tip3Field.text!) ??  0
        
        defaults.set(tip3, forKey: "tip3")
        defaults.synchronize()
    }
}
