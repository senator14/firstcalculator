//
//  ViewController.swift
//  Calculator
//
//  Created by Timur Usmanov on 15.08.15.
//  Copyright (c) 2015 Timur Usmanov. All rights reserved.
//

// import UIKit

// class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
 //   }


//}

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var Display: UILabel!
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            Display.text! += Display.text!.rangeOfString(".") != nil && digit == "." ? "" : digit
            
        } else {
            Display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
 
    }
    

    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷":
            if operandStack.last == 0 {
                Display.text = "Error"
            } else {
                performOperation { $1 / $0 }
            }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "sin": performOperation { __sinpi($0/180) }
        case "cos": performOperation { __cospi($0/180) }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    @IBAction func Pi(sender: UIButton) {
        Display.text = "\(M_PI)"
        operandStack.append(M_PI)
        
    }
    
    
    private func performOperation (operation: (Double) -> Double ) {
        if operandStack.count >= 1 {
            displayValue = operation (operandStack.removeLast())
            enter()
        }
    }
        
    private func performOperation (operation: (Double, Double) -> Double ) {
        if operandStack.count >= 2 {
            displayValue = operation (operandStack.removeLast() , operandStack.removeLast())
            enter()
        }
    }

    
    var operandStack = Array <Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append( displayValue )
        println("operandStack = \(operandStack)")
        
    }
    var displayValue :Double {
        get {
            return NSNumberFormatter().numberFromString(Display.text!)!.doubleValue
        }
        set {
            Display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    @IBAction func AC(sender: UIButton) {
        operandStack.removeAll(keepCapacity: false)
        Display.text = "0"
        
    }
    
}