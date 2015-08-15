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
            Display.text = Display.text! + digit
        } else {
            Display.text = digit
            userIsInTheMiddleOfTypingANumber = true
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
    
    @IBAction func operate(sender: UIButton) {
    }
}