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
        self.node = contentNode(angle: angle).group()
    }
    
    fileprivate func contentNode(angle: Double) -> [Node] {
        let restAngle = 2 * M_PI - angle
        let center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let cx = Double(center.x)
        let cy = Double(center.y)
        let rx = Double(center.x) - 10.0
        let ry = Double(center.y) - 10.0
        let ellipse = Ellipse(cx: Double(center.x), cy: Double(center.y), rx: rx, ry: ry)
        
        let text = Text(text: "\(value)", font: Font.init(name: "System", size: 38), fill: Color.white)
        let textCenter = GeomUtils.center(node: text)
        text.place = Transform.move(dx: cx - textCenter.x, dy: cy - textCenter.y)
        
        return  [
            text,
            Arc(ellipse: ellipse, shift: -1.0 * M_PI_2, extent: angle)
                .stroke(fill: Color.rgb(r: 200, g: 200, b: 200), width: 10.0),
            Arc(ellipse: ellipse, shift: -1.0 * M_PI_2 + angle, extent: restAngle)
                .stroke(fill: Color.white, width: 10.0)
        ]
    }
    
    fileprivate func updateIntevalLabel(currentValue: Int) {
        internalLabel?.text = "\(currentValue)"
    }
    
    func animate1() {
        let scaleAnimation = self.node.placeVar.animation(to: GeomUtils.centerScale(node: self.node, sx: 0.1, sy: 0.1), during: 2.0).easing(.easeOut)
        scaleAnimation.autoreversed().play()
    }
    
    func animate2() {
        guard let rootNode = self.node as? Group else {
            return
        }
        
        rootNode.contentsVar.animate({ t -> [Node] in
            return self.contentNode(angle: 2 * M_PI * t)
        }, during: 2.0)
    }
}
