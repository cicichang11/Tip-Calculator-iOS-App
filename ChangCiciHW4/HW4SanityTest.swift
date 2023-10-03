//
//  HW4SanityTest.swift
//  HW4
//
//  Created by Harrison Weinerman on 8/24/18.
//  Copyright © 2018 Harrison Weinerman. All rights reserved.
//

import XCTest

class HW4SanityTest: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        XCUIApplication().launch()
        
    }
    
    /// This test should pass regardless of how you configured your app; should have all these components
    func testBasicUIElements() {
        
        // test ui components that you can interact with
        let billTextField = app.textFields[HW4AccessibilityIdentifiers.billTextField]
        let segmentedTax = app.segmentedControls[HW4AccessibilityIdentifiers.segmentedTax]
        let includeTaxSwitch = app.switches[HW4AccessibilityIdentifiers.includeTaxSwitch]
        let tipSlider = app.sliders[HW4AccessibilityIdentifiers.tipSlider]
        let splitStepper = app.steppers[HW4AccessibilityIdentifiers.splitStepper]
        let resetButton = app.buttons[HW4AccessibilityIdentifiers.resetButton]

        //dynamic labels changing on input
        let taxAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.taxAmountLabel]
        let subtotalAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.subtotalAmountLabel]
        let tipAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipAmountLabel]
        let totalWithTipAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.totalWithTipAmountLabel]
        let totalPerPersonAmountLabel = app.staticTexts[HW4AccessibilityIdentifiers.totalPerPersonAmountLabel]
        let sliderLabel = app.staticTexts[HW4AccessibilityIdentifiers.sliderLabel]
        let splitLabel = app.staticTexts[HW4AccessibilityIdentifiers.splitLabel]

        //static labels
        let tipCalculaterLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipCalculaterLabel]
        let billLabel = app.staticTexts[HW4AccessibilityIdentifiers.billLabel]
        let segmentedLabel = app.staticTexts[HW4AccessibilityIdentifiers.segmentedLabel]
        let includeTaxLabel = app.staticTexts[HW4AccessibilityIdentifiers.includeTaxLabel]
        let evenSplitLabel = app.staticTexts[HW4AccessibilityIdentifiers.evenSplitLabel]
        let taxLabel = app.staticTexts[HW4AccessibilityIdentifiers.taxLabel]
        let subtotalLabel = app.staticTexts[HW4AccessibilityIdentifiers.subtotalLabel]
        let tipLabel = app.staticTexts[HW4AccessibilityIdentifiers.tipLabel]
        let totalWithTipLabel = app.staticTexts[HW4AccessibilityIdentifiers.totalWithTipLabel]
        let totalPerPersonLabel = app.staticTexts[HW4AccessibilityIdentifiers.totalPerPersonLabel]
        
        //connecting at least one view
        let calcView = app.otherElements[HW4AccessibilityIdentifiers.view]
        
        //verify that the components exist on the screen
        XCTAssert(billTextField.exists)
        XCTAssert(segmentedTax.exists)
        XCTAssert(includeTaxSwitch.exists)
        XCTAssert(tipSlider.exists)
        XCTAssert(splitStepper.exists)
        XCTAssert(taxAmountLabel.exists)
        XCTAssert(subtotalAmountLabel.exists)
        XCTAssert(tipAmountLabel.exists)
        XCTAssert(totalWithTipAmountLabel.exists)
        XCTAssert(totalPerPersonAmountLabel.exists)
        XCTAssert(sliderLabel.exists)
        XCTAssert(splitLabel.exists)
        XCTAssert(tipCalculaterLabel.exists)
        XCTAssert(billLabel.exists)
        XCTAssert(segmentedLabel.exists)
        XCTAssert(includeTaxLabel.exists)
        XCTAssert(evenSplitLabel.exists)
        XCTAssert(taxLabel.exists)
        XCTAssert(subtotalLabel.exists)
        XCTAssert(tipLabel.exists)
        XCTAssert(totalWithTipLabel.exists)
        XCTAssert(totalPerPersonLabel.exists)
        XCTAssert(resetButton.exists)
        
        //seeing if the user has at least 1 view
        XCTAssert(calcView.exists)
        
        //checks to see if there is a placeholder
        XCTAssertNotEqual(billTextField.placeholderValue, "")
    }
    
    /// simulates a real life scenario to test your app
        func testCase1() {
        let billTextField = app.textFields["billTextField"]
        //added for students who are making keyboard come up on runtime
        if (app.keyboards.count != 0)
        {
            billTextField.typeText("\n")
        }
        
        //type 100$ into the textfield
        billTextField.tap()
        billTextField.typeText("100")
        
        //simulate background press
        let tipCalcLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalcLabel.tap()
        
        //grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let subtotalAmountLabel = app.staticTexts["subtotalAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let totalWithTipAmountLabel = app.staticTexts["totalWithTipAmountLabel"]
        let totalPerPersonAmountLabel = app.staticTexts["totalPerPersonAmountLabel"]
        let sliderLabel = app.staticTexts["sliderLabel"]
        let splitLabel = app.staticTexts["splitLabel"]

        // split 1 case: works when the tip is .1 of your slider and the split is 1
        let switchtax = app.switches["includeTaxSwitch"]
        switchtax.tap()
        let isOn = switchtax.value as! String
        if (isOn == "0")
        {
            // want to make sure this is enable, so tap again
            switchtax.tap()
        }
        
        //set tax to .1 of slider
        let slider = app.sliders["tipSlider"]
        slider.adjust(toNormalizedSliderPosition: 0.10)
        let sliderval = Double((slider.value as! String).components(separatedBy: "%").first!)
        
        // do the math
        let mathfortip = 108.50 * ((sliderval!) / 100.00)
        print (mathfortip)

        let tipamountString = String(format: "$%.02f", mathfortip)
        let totalwTip = mathfortip + 108.50
        let totalwTipString = String(format: "$%.02f", totalwTip)

        //set segmented control to 8.5
        let segmented = app.segmentedControls["segmentedTax"]
        segmented.tap()
        
        // grabs the split value because not everyones may start at 1
        let stepperValue = Int(splitLabel.label)
        let totalperperson = totalwTip / Double(stepperValue!)
        let totalperpersonstring = String(format: "$%.02f", totalperperson)
        
        //verify labels
        XCTAssertEqual(taxAmountLabel.label, "$8.50")
        XCTAssertEqual(subtotalAmountLabel.label, "$108.50")
        
        //check for a range +- 0.01
        //calc tip amount
        let mathfortipplusone = Double(mathfortip + 0.005)
        let mathfortipplusonestring = String(format: "$%.02f", mathfortipplusone)
        let mathfortipminusone = Double(mathfortip - 0.005)
        let mathfortipminusonestring = String(format: "$%.02f", mathfortipminusone)
        
        XCTAssert([mathfortipplusonestring, mathfortipminusonestring, tipamountString].contains(tipAmountLabel.label))
        
        //calc total with tip amount
        let totalwTipplusone = Double(totalwTip + 0.005)
        let totalwTipplusonestring = String(format: "$%.02f", totalwTipplusone)
        let totalwTipminusone = Double(totalwTip - 0.005)
        let totalwTipminusonestring = String(format: "$%.02f", totalwTipminusone)
        
        XCTAssert([totalwTipplusonestring, totalwTipminusonestring, totalwTipString].contains(totalWithTipAmountLabel.label))
        
        //calc total per person
        let totalperpersonplusone = Double(totalperperson + 0.005)
        let totalperpersonplusonestring = String(format: "$%.02f", totalperpersonplusone)
        let totalperpersonminusone = Double(totalperperson - 0.005)
        let totalperpersonminusonestring = String(format: "$%.02f", totalperpersonminusone)
        
        XCTAssert([totalperpersonplusonestring, totalperpersonminusonestring, totalperpersonstring].contains(totalPerPersonAmountLabel.label))

        //calc the slider based on display
        let sliderplusone = Int((slider.value as! String).components(separatedBy: "%").first!)! + 1
        let sliderminusone = Int((slider.value as! String).components(separatedBy: "%").first!)! - 1
        let sliderplusonestring = "\(sliderplusone)%"
        let sliderminusonestring = "\(sliderminusone)%"
        
        XCTAssert([sliderplusonestring, sliderminusonestring, slider.value as! String].contains(sliderLabel.label))
    }
}
