//
//  ViewController.swift
//  Sketch
//
//  Created by 김대기 on 2021/01/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    var lastPoint : CGPoint!
    var lineSize:CGFloat = 2.0
    var LineColor = UIColor.red.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnClear(_ sender: UIButton) {
        imgView.image = nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lastPoint = touch.location(in: imgView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(LineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(LineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgView.image = nil
        }
    }
    
}

