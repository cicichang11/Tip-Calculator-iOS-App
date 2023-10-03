//
//  TipSplitViewController.swift
//  ChangCiciHW4
//
//  Created by cici on 2022/2/16.
//

import UIKit

class TipSplitViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var billTextLabel: UILabel!

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var taxTextLabel: UILabel!
    
    @IBOutlet weak var taxSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var includeTaxTextLabel: UILabel!
    
    @IBOutlet weak var includeTaxSwitch: UISwitch!
    
    @IBOutlet weak var tipPercentSlider: UISlider!
    
    @IBOutlet weak var tipPercentLabel: UILabel!
    
    @IBOutlet weak var splitTextLabel: UILabel!
    
    @IBOutlet weak var splitStepper: UIStepper!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var infoInputView: UIView!
    
    @IBOutlet weak var outputView: UIView!

    @IBOutlet weak var calculatedTaxTextLabel: UILabel!
    
    @IBOutlet weak var calculatedTax: UILabel!
    
    @IBOutlet weak var calculatedSubTextLabel: UILabel!
    
    @IBOutlet weak var calculatedSubtotal: UILabel!
    
    @IBOutlet weak var calculatedTipTextLabel: UILabel!
    
    @IBOutlet weak var calculatedTip: UILabel!
    
    @IBOutlet weak var calculatedTotalWithTipTextLabel: UILabel!
    
    @IBOutlet weak var calculatedTotalWithTip: UILabel!
    
    @IBOutlet weak var eachPersonTextLabel: UILabel!
    
    @IBOutlet weak var calculatedPersonTotal: UILabel!
    
    @IBOutlet weak var clearAllTextButton: UIButton!
    
    @IBOutlet weak var hiddenButton: UIButton!
    
    func setDefaultValues(){
        taxSegmentControl.selectedSegmentIndex = 0
        includeTaxSwitch.isOn = false
        tipPercentSlider.value = 0.0
        splitStepper.value = 1
        tipPercentLabel.text = "0.0%"
        stepperLabel.text = "1"
        calculatedTax.text = "$0.00"
        calculatedSubtotal.text = "$0.00"
        calculatedTip.text = "$0.00"
        calculatedTotalWithTip.text = "$0.00"
        calculatedPersonTotal.text = "$0.00"
    }
    
    func updateUI() {
        // initialize variables
        var tax:Double = 0.00
        var subtotal:Double = 0.00
        var tip:Double = 0.00
        var total:Double = 0.00
        var totalSplit:Double = 0.00
        let taxPercent = taxSegmentControl.titleForSegment(at: taxSegmentControl.selectedSegmentIndex)!
        
        if billTextField.hasText {
            let bill = Double(billTextField.text!)
            // tax
            tax = (bill)! * Double(taxPercent)! / 100.0
            // subtotal
            if includeTaxSwitch.isOn {
                subtotal = (bill)! + tax
            } else {
                subtotal = (bill)!
            }
            // tip
            tip = subtotal * Double(tipPercentSlider.value.rounded()) / 100.0
            // total
            total = (bill)! + tax + tip
            // totalSplit
            totalSplit = total / Double(splitStepper.value)
        } else {
            print("Please enter a bill amount!")
        }
        
        // update labels
        calculatedTax.text = "$\(round(tax * 100) / 100.0)"
        calculatedSubtotal.text = "$\(round(subtotal * 100) / 100.0)"
        calculatedTip.text = "$\(round(tip * 100) / 100.0)"
        calculatedTotalWithTip.text = "$\(round(total * 100) / 100.0)"
        calculatedPersonTotal.text = "$\(round(totalSplit * 100) / 100.0)"
    }
    
    func clearAll(){
        setDefaultValues()
        billTextField.text = nil
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        billTextField.becomeFirstResponder()
        
        titleLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel
        
        billTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel
        
        billTextField.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField
        
        taxSegmentControl.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedTax
        
        includeTaxTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxLabel
        
        includeTaxSwitch.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxSwitch
        
        tipPercentSlider.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSlider
        
        splitTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitLabel
        
        splitStepper.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper
        
        infoInputView.accessibilityIdentifier = HW4AccessibilityIdentifiers.view
        
        calculatedTaxTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxLabel
        
        calculatedTax.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        
        calculatedTax.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        
        calculatedSubTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalLabel
        
        calculatedSubtotal.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalAmountLabel
        
        calculatedTipTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipLabel
        
        calculatedTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel
        
        calculatedTotalWithTipTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipLabel
        
        calculatedTotalWithTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipAmountLabel
        
        eachPersonTextLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonLabel
        
        calculatedPersonTotal.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonAmountLabel
        
        clearAllTextButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton
        
        
    }
    
    @IBAction func userDidReturn(_ sender: UITextField) {
        billTextField.resignFirstResponder()
    }
    
    
    @IBAction func includTaxSwitchDidTapped(_ sender: UISwitch) {
        print("\(#function)")
        
        includeTaxSwitch.isOn = true
        updateUI()
    }
    
    @IBAction func taxSegmentTapped(_ sender: UISegmentedControl) {
        print("\(#function)")
        
        updateUI()
    }
    
    @IBAction func tipPercentSliderDidChange(_ sender: UISlider) {
        print("\(#function)")
        tipPercentLabel.text = "\(tipPercentSlider.value.rounded())%"
        
        updateUI()
    }
    
    @IBAction func splitStepperDidChange(_ sender: UIStepper) {
        print("\(#function)")
        stepperLabel.text = "\(Int(splitStepper.value))"
        
        updateUI()
    }
    
    @IBAction func clearButtonDidTapped(_ sender: UIButton) {
        let alertMessage = "Do you really want to clear the fields?"
        let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                
        let clearButton = UIAlertAction(title: "Clear All", style: .destructive,
                                     handler: handleClearAction)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel,
                                         handler: nil)
        
        alert.addAction(clearButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func handleClearAction(_ action: UIAlertAction) -> Void{
        print("\(#function )")
        clearAll()
    }
    
    @IBAction func hiddenButtonDidTapped(_ sender: UIButton) {
        billTextField.resignFirstResponder()
    }
}
