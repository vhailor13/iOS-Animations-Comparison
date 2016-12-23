//
//  ViewController.swift
//  AnimationComparison
//
//  Created by Victor Sukochev on 21/12/2016.
//  Copyright © 2016 Victor Sukochev. All rights reserved.
//

import Macaw

class ViewController: UIViewController {
    
    @IBOutlet weak var cgControl: IntervalControlCG!
    @IBOutlet weak var macawControl: IntervalControlMacaw!
    
    @IBAction func animate1() {
        cgControl.animate1()
        macawControl.animate1()
    }
    
    @IBAction func animate2() {
        cgControl.animate2()
        macawControl.animate2()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cgControl.onValueChanged = { value in
            self.macawControl.value = value
        }
        
        macawControl.onValueChanged = { value in
            self.cgControl.value = value
        }

    }
    
}

