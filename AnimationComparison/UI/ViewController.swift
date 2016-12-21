//
//  ViewController.swift
//  AnimationComparison
//
//  Created by Victor Sukochev on 21/12/2016.
//  Copyright © 2016 Victor Sukochev. All rights reserved.
//

import Macaw

class ViewController: UIViewController {
    
    @IBOutlet weak var cgExample1View: ExampleView1!
    @IBOutlet weak var cgExample2View: UIView!
    @IBOutlet weak var macawExample1: MacawView!
    @IBOutlet weak var macawExample2: MacawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMacawExample1()
    }
    
    private func showMacawExample1() {
        var radius = 50.0
        let circle = Ellipse(cx: radius, cy: radius, rx: radius, ry: radius)
        let shape = Shape(form: circle, fill: .none, stroke: Stroke(fill: Color.blue, width: 1.0))
        macawExample1.node = shape
    }

}

