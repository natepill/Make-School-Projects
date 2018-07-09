//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    // 1
    var isDefaultStatusBar = true
    
    // 2
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDefaultStatusBar ? .default : .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setTheme(isDark: false)
        
        self.billAmountTextField.delegate = self
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var outputCardView: UIView!
    
    
    //Output View
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    
    //Input View
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var calculateButton: UIButton!
    
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        
            setTheme(isDark: sender.isOn)
    }
    
    
    
    @IBAction func percentageChange(_ sender: UISegmentedControl) {
    }
    
    func setupViews() {
        
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        inputCardView.layer.cornerRadius = 8
        inputCardView.layer.masksToBounds = true
        
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        
        calculateButton.layer.cornerRadius = 8
         calculateButton.layer.masksToBounds = true
        
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
        
        calculateButton.layer.cornerRadius = 8
        calculateButton.layer.masksToBounds = true
       
    }
    
    
    func setTheme(isDark: Bool) {
        
        
        let theme = isDark ? ColorTheme.dark : ColorTheme.light
        
            isDefaultStatusBar = theme.isDefaultStatusBar
            setNeedsStatusBarAppearanceUpdate()
        
  
        view.backgroundColor = theme.viewControllerBackgroundColor
        
        headerView.backgroundColor = theme.primaryColor
        titleLabel.textColor = theme.primaryTextColor
        
        inputCardView.backgroundColor = theme.secondaryColor
        
        billAmountTextField.tintColor = theme.accentColor
        tipPercentSegmentedControl.tintColor = theme.accentColor
        
        outputCardView.backgroundColor = theme.primaryColor
        outputCardView.layer.borderColor = theme.accentColor.cgColor
        
        tipAmountTitleLabel.textColor = theme.primaryTextColor
        totalAmountTitleLabel.textColor = theme.primaryTextColor
        
        tipAmountLabel.textColor = theme.outputTextColor
        totalAmountLabel.textColor = theme.outputTextColor
        
        calculateButton.backgroundColor = theme.secondaryColor
        
    }
    
    
    
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let bill = Double(billAmountTextField.text!)
        var tipPercentage: Double = 0
        
        if tipPercentSegmentedControl.selectedSegmentIndex == 0 {
            tipPercentage = 0.15
        }
        if tipPercentSegmentedControl.selectedSegmentIndex == 1 {
            tipPercentage = 0.18
        }
        if tipPercentSegmentedControl.selectedSegmentIndex == 2 {
            tipPercentage = 0.20
        }
        
        let tip: Double = (Double(bill! * tipPercentage))
        tipAmountLabel.text = String(tip)
        
        let total: Double = (bill! + tip)
        totalAmountLabel.text = String(total)
        
        
    }
    
    
    
    
    
 
}

