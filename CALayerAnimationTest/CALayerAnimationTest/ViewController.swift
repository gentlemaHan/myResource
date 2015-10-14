//
//  ViewController.swift
//  CALayerAnimationTest
//
//  Created by 韩小东 on 15/9/9.
//  Copyright (c) 2015年 HXD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var replicatiorAnimationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstReplicatorAnimation()
        self.activityIndicatirAnimation()
    }
    
    func firstReplicatorAnimation(){
        let replicatorLayer = CAReplicatorLayer();
        replicatorLayer.bounds = CGRect(x: replicatiorAnimationView.frame.origin.x,y: replicatiorAnimationView.frame.origin.y, width: replicatiorAnimationView.frame.size.width, height: replicatiorAnimationView.frame.size.height);
        replicatorLayer.anchorPoint = CGPoint(x: 0, y: 0);
        replicatorLayer.backgroundColor = UIColor.lightGrayColor().CGColor;
        replicatorLayer.position = CGPoint(x: 0, y: 0)
        replicatiorAnimationView.layer.addSublayer(replicatorLayer)
        
        let rectangle = CALayer()
        rectangle.frame = CGRect(x: replicatiorAnimationView.frame.origin.x+10, y: replicatiorAnimationView.frame.origin.y + replicatiorAnimationView.frame.size.height - 40, width: 30, height: 90)
        rectangle.cornerRadius = 2
        rectangle.backgroundColor = UIColor.redColor().CGColor
        replicatorLayer.addSublayer(rectangle)
        
        let moveRectangle = CABasicAnimation(keyPath: "position.y")
        moveRectangle.toValue = rectangle.position.y - 50
        moveRectangle.duration = 0.7
        moveRectangle.autoreverses = true
        moveRectangle.repeatCount = HUGE
        rectangle.addAnimation(moveRectangle, forKey: nil)
        
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0)
        replicatorLayer.instanceDelay = 0.3
        replicatorLayer.masksToBounds = true
    }
    
    func activityIndicatirAnimation(){
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: activityIndicatorView.frame.size.width, height: activityIndicatorView.frame.size.height)
        replicatorLayer.position = CGPoint(x: activityIndicatorView.frame.size.width/2, y: activityIndicatorView.frame.size.height/2)
        replicatorLayer.backgroundColor = UIColor.lightGrayColor().CGColor
        activityIndicatorView.layer.addSublayer(replicatorLayer)
        
        let circle = CALayer()
        circle.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        circle.position = CGPoint(x: activityIndicatorView.frame.size.width/2, y: activityIndicatorView.frame.size.height/2 - 55)
        circle.cornerRadius = 7.5
        circle.backgroundColor = UIColor.whiteColor().CGColor
        replicatorLayer.addSublayer(circle)
        
        replicatorLayer.instanceCount = 15
        let angle = CGFloat(2*M_PI) / CGFloat(15)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 0.1
        scale.duration = 1
        scale.repeatCount = HUGE
        circle.addAnimation(scale, forKey: nil)
        replicatorLayer.instanceDelay = 1/15
        circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    }


}
        