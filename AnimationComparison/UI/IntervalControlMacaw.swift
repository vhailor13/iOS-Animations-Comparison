//
//  IntervalControlMacaw.swift
//  AnimationComparison
//
//  Created by Victor Sukochev on 22/12/2016.
//  Copyright © 2016 Victor Sukochev. All rights reserved.
//

import Macaw

class IntervalControlMacaw: MacawView {
    @IBOutlet weak var internalLabel: UILabel?
    
    var value = 0 {
        didSet {
            if value == oldValue {
                return
            }
            
            let progress = Double(value) / 25.0
            let angle = 2 * M_PI * progress
            updateInterval(angle: angle)
            updateIntevalLabel(currentValue: value)
            onValueChanged?(value)
        }
    }
    
    var onValueChanged: ( (Int) -> Void )?
    
    @IBAction func onPanAction(recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        updateInterval(location: location)
    }

    
    fileprivate func updateInterval(location: CGPoint) {
        //let center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let rx = self.bounds.width  / 2.0
        let ry = self.bounds.height / 2.0
        let x = Double((location.x - rx) / rx)
        let y = Double((location.y - ry) / ry)
        var angle = atan2(y, x) + M_PI_2
        if angle < 0.0 {
            angle = 2 * M_PI + angle
        }
        
        let progress = angle / ( 2.0 * M_PI)
        let currentValue = Int(25.0 * progress)
        if value == currentValue {
            return
        }
        
        value = currentValue
    }
    
    fileprivate func updateInterval(angle: Double) {
        let restAngle = 2 * M_PI - angle
        let center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let rx = Double(center.x) - 10.0
        let ry = Double(center.y) - 10.0
        let ellipse = Ellipse(cx: Double(center.x), cy: Double(center.y), rx: rx, ry: ry)
 
        self.node = [
            Arc(ellipse: ellipse, shift: -1.0 * M_PI_2, extent: angle)
                .stroke(fill: Color.rgb(r: 200, g: 200, b: 200), width: 10.0),
            Arc(ellipse: ellipse, shift: -1.0 * M_PI_2 + angle, extent: restAngle)
                .stroke(fill: Color.white, width: 10.0)
            ].group()
    }
    
    fileprivate func updateIntevalLabel(currentValue: Int) {
        internalLabel?.text = "\(currentValue)"
    }
}
