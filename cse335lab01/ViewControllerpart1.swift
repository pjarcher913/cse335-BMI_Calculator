//
//  ViewControllerpart1.swift
//  cse335lab01
//
//  Created by Patrick Archer on 8/29/18.
//  Copyright © 2018 Patrick Archer - Self. All rights reserved.
//

import UIKit
import AVFoundation // for video/audio playback
import AVKit    // for video/audio playback

class ViewControllerpart1: UIViewController {

    @IBOutlet weak var userHeight: UITextField!
    @IBOutlet weak var userWeight: UITextField!
    @IBOutlet weak var userBMI: UILabel!
    
    var playerController = AVPlayerViewController()
    var player:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /********************************************/
        //  Additional setup after loading the view
        /********************************************/
        
        // hide displayed BMI @ first load
        userBMI.isHidden = true
        /*
        // set up Easter Egg video playback
        let videoString:String? = Bundle.main.path(forResource: "outputMemeVid", ofType: ".mp4")
        
        if let url = videoString {
            let videoURL = NSURL(fileURLWithPath: url)
            self.player = AVPlayer(url: videoURL as URL)
            self.playerController.player = self.player
        }
        */
        //...
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // set up Easter Egg video playback
        let videoURL = NSURL(fileURLWithPath: "/Users/parcher/Desktop/Schoolwork/Year 4/Fall 2018/CSE 335/Labs/1/cse335lab01/cse335lab01/outputMemeVid.mp4")
        self.player = AVPlayer(url: videoURL as URL)
        self.playerController.player = self.player
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /********************************************/
    //  Start custom methods
    /********************************************/
    
    func calculateBMI() -> Float
    {
        var bmi:Float = 0.00
        
        if (Float(self.userHeight.text!) != nil) && (Float(self.userWeight.text!) != nil)
            // If entries are anything other than Ints/Doubles, catch the error and report to user
        {
            // print("inside bmi calc section")    // used for debugging
            
            let height:Float = Float(self.userHeight.text!)!
            let weight:Float = Float(self.userWeight.text!)!
            
            bmi = (weight * 0.45) / ((height * 0.025) * (height * 0.025))   /* bmi algorithm taken from < http://extoxnet.orst.edu/faqs/dietcancer/web2/twohowto.html > versus the faulty algorithm given to students via the Lab 1 instructions */
        }
        else    // else some other data type entered into the fields; catch and prevent crash
        {
            print("ERROR: Data type other than Int/Double entered into either height or weight text field.")
        }
        
        return bmi
    }

    // what happens when the user presses the "SUBMIT" button on-screen
    @IBAction func submitData(_ sender: UIButton) {
        
        if (Float(self.userHeight.text!) != nil) && (Float(self.userWeight.text!) != nil)
            // If entries are anything other than Ints/Doubles, catch the error and report to user
        {
            let calculatedBMI:Float = self.calculateBMI()
            // calculatedBMI = calculatedBMI.round()
            
            if Float(self.userHeight.text!)! == 1111 &&
                Float(self.userWeight.text!)! == 1111
                // Easter Egg ;)
            {
                // print("DEV NOTE: Inside Easter Egg handler.")    // for debug
                eePART1()   // run Easter Egg function
            }
            else if calculatedBMI < 18
            {
                // user is underweight -> blue color
                // print("blue color")  // used for debugging
                
                userBMI.text = String(format: "Your BMI is %.2f, which means your are underweight.", calculatedBMI)
                userBMI.textColor = UIColor.blue
                userBMI.isHidden = false
                
                
            }
            else if calculatedBMI >= 18 && calculatedBMI < 25
            {
                // user is normal -> green color
                // print("green color")  // used for debugging
                
                userBMI.text = String(format: "Your BMI is %.2f, which means your are normal.", calculatedBMI)
                userBMI.textColor = UIColor.green
                userBMI.isHidden = false
                
            }
            else if calculatedBMI >= 25 && calculatedBMI < 30
            {
                // user is pre-obese -> purple color
                // print("purple color")  // used for debugging
                
                userBMI.text = String(format: "Your BMI is %.2f, which means your are pre-obese.", calculatedBMI)
                userBMI.textColor = UIColor.purple
                userBMI.isHidden = false
                
            }
            else if calculatedBMI >= 30
            {
                // user is obese -> red color
                // print("red color")  // used for debugging
                
                userBMI.text = String(format: "Your BMI is %.2f, which means your are obese.", calculatedBMI)
                userBMI.textColor = UIColor.red
                userBMI.isHidden = false
                
            }
            else
            {
                // print("Invalid height and/or weight entered.")  // used for debugging
                userBMI.text = "Invalid height and/or weight entered.  Please try again."
                userBMI.textColor = UIColor.red
                userBMI.isHidden = false
            }
        }
        else    // else some other data type entered into the fields; catch and prevent crash
        {
            print("ERROR: Data type other than Int/Double entered into either height or weight text field.")
        }
        
    }
    
    func eePART1() -> Void
    {
        // play video (w/ sound) (using AVKit) using OS video player (?in a new view?)
        self.present(self.playerController, animated: true, completion: {
            self.playerController.player?.play()
        })
    }
    
    
    
    
}
