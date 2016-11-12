//
//  ViewController.swift
//  RetroCalculatorExercise
//
//  Created by Younoussa Ousmane Abdou on 11/10/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var BTNSound: AVAudioPlayer!
    
    //Math logic
    
    enum Operation: String {
        
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case empty = "empty"
    }
    
    var leftValueSTR = ""
    var rightValueSTR = ""
    var result = ""
    var runningNumber = ""
    var currentOperation: Operation = Operation.empty
    
    @IBOutlet weak var outputLBL: UILabel!
    
    @IBAction func onBTNPressed(_ sender: UIButton) {
        
        playSound()
        
        runningNumber = "\(sender.tag)"
        
        outputLBL.text = runningNumber
    }
    
    @IBAction func onAddBTNPressed(_ sender: UIButton) {
        
        processOperation(.add)
    }
    
    @IBAction func onSubtractBTNPressed(_ sender: UIButton) {
        
        processOperation(.subtract)
    }

    @IBAction func onMultiplyBTNPressed(_ sender: UIButton) {
        
        processOperation(.multiply)
    }

    @IBAction func onDivideBTNPressed(_ sender: UIButton) {
        
        processOperation(.divide)
    }

    @IBAction func onEqualBTNPressed(_ sender: UIButton) {
        
        processOperation(currentOperation)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        outputLBL.text = "0"
        
        let filePath = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: filePath!)
        
        do {
            
            try BTNSound = AVAudioPlayer(contentsOf: soundURL)
            BTNSound.prepareToPlay()
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
        
    }
    
    func playSound() {
        
        BTNSound.play()
        
    }
    
    func processOperation(_ operation: Operation) {
        
        if currentOperation != Operation.empty {
            
            if runningNumber != "" {
                
                rightValueSTR = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.add {
                    
                    result = "\(Double(leftValueSTR)! +  (Double(rightValueSTR)!))"
                } else if currentOperation == Operation.subtract {
                    
                    result = "\(Double(leftValueSTR)! -  (Double(rightValueSTR)!))"
                } else if currentOperation == Operation.multiply {
                    
                    result = "\(Double(leftValueSTR)! *  (Double(rightValueSTR)!))"
                } else if currentOperation == Operation.divide {
                    
                    result = "\(Double(leftValueSTR)! /  (Double(rightValueSTR)!))"
                }
                
                leftValueSTR = result
                
                outputLBL.text = result
            }
            
            currentOperation = operation
        } else {
            
            leftValueSTR = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
        playSound()
    }
}

