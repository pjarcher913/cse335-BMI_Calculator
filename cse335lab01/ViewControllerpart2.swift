//
//  ViewControllerpart2.swift
//  cse335lab01
//
//  Created by Patrick Archer on 8/29/18.
//  Copyright © 2018 Patrick Archer - Self. All rights reserved.
//

import UIKit

class ViewControllerpart2: UIViewController {
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var displayedBMI: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayedBMI.isHidden = true// hide displayed calculated BMI
        self.heightValueLabel.isHidden = true   // hide displayed height value
        self.weightValueLabel.isHidden = true   // hide displayed weight value
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /********************************************/
    //  Start custom methods
    /********************************************/
    
    @IBAction func userHeightSlider(_ sender: UISlider) {
        // print("Inside userHeightSlider")
        //heightValueLabel.text = String(Int(sender.value))
        
        // update label(s)
        let sHeight = Int(sender.value)
        self.heightValueLabel.text = String(sHeight)
        self.heightValueLabel.isHidden = false   // show displayed height value
        
        // recalc BMI & display new value to user
        updateBMI()
    }
    
    @IBAction func userWeightSlider(_ sender: UISlider) {
        // print("Inside userWeightSlider")
        //weightValueLabel.text = String(Int(sender.value))
        
        // update label(s)
        let sWeight = Int(sender.value)
        self.weightValueLabel.text = String(sWeight)
        self.weightValueLabel.isHidden = false   // show displayed height value
        
        // recalc BMI & display new value to user
        updateBMI()
    }
    
    func calculateBMI() -> Float
    {
        var bmi:Float = 0
        
        if (Float(self.heightValueLabel.text!) != nil) && (Float(self.weightValueLabel.text!) != nil)
            // If entries are anything other than Ints/Doubles, catch the error and report to user
        {
            // print("inside bmi calc section")    // used for debugging
            
            let height:Float = Float(self.heightValueLabel.text!)!
            let weight:Float = Float(self.weightValueLabel.text!)!
            
            bmi = (weight * 0.45) / ((height * 0.025) * (height * 0.025))   /* bmi algorithm taken from < http://extoxnet.orst.edu/faqs/dietcancer/web2/twohowto.html > versus the faulty algorithm given to students via the Lab 1 instructions */
        }
        else    // else some other data type entered into the fields; catch and prevent crash
        {
            print("ERROR: Data type other than Int/Double entered into either height or weight text field.")
            // bmi = 0
        }
        
        return bmi
    }
    
    func updateBMI () -> Void
    {
        let calculatedBMI:Float = self.calculateBMI()
        // calculatedBMI = calculatedBMI.round()
        
        if calculatedBMI < 18
        {
            // user is underweight -> blue color
            // print("blue color")  // used for debugging
            
            displayedBMI.text = String(format: "Your BMI is %.2f, which means your are underweight.", calculatedBMI)
            displayedBMI.textColor = UIColor.blue
            displayedBMI.isHidden = false
            
            
        }
        else if calculatedBMI >= 18 && calculatedBMI < 25
        {
            // user is normal -> green color
            // print("green color")  // used for debugging
            
            displayedBMI.text = String(format: "Your BMI is %.2f, which means your are normal.", calculatedBMI)
            displayedBMI.textColor = UIColor.green
            displayedBMI.isHidden = false
            
        }
        else if calculatedBMI >= 25 && calculatedBMI < 30
        {
            // user is pre-obese -> purple color
            // print("purple color")  // used for debugging
            
            displayedBMI.text = String(format: "Your BMI is %.2f, which means your are pre-obese.", calculatedBMI)
            displayedBMI.textColor = UIColor.purple
            displayedBMI.isHidden = false
            
        }
        else if calculatedBMI >= 30
        {
            // user is obese -> red color
            // print("red color")  // used for debugging
            
            displayedBMI.text = String(format: "Your BMI is %.2f, which means your are obese.", calculatedBMI)
            displayedBMI.textColor = UIColor.red
            displayedBMI.isHidden = false
            
        }
        else
        {
            // print("Invalid height and/or weight entered.")  // used for debugging
            displayedBMI.text = "Invalid height and/or weight entered.  Please try again."
            displayedBMI.textColor = UIColor.red
            displayedBMI.isHidden = false
        }
    }
    
}
