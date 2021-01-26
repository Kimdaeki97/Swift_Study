//
//  ViewController.swift
//  DrawGraphics
//
//  Created by 김대기 on 2021/01/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 선그리기 함수
    @IBAction func btnDrawLine(_ sender: UIButton) {
        // 그림을 그리기 위한 콘텍스트 생성
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!     // 생성된 콘텍스트 정보 획득
        
        // 선그리기
        context.setLineWidth(2.0)     // 선 굵기를 2.0으로 설정
        // 선 색상을 빨간색으로 설정
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.move(to: CGPoint(x: 70, y: 50))        // 커서의 위치를 (70,50)으로 이동
        // 시작 위치에서 (270,250)까지 선 추가
        context.addLine(to: CGPoint(x: 270, y: 250))
        context.strokePath()    // 추가한 선을 콘텍스트에 그림
        
        // 선으로 삼각형 그리기
        context.setLineWidth(4.0)    // 선 굵기를 4.0으로 설정
        // 선 색상을 파란색으로 설정
        context.setStrokeColor(UIColor.blue.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))     // 커서의 위치를 (170,200)으로 이동
        // 시작 위치에서 (270,350)까지 선 추가
        context.addLine(to: CGPoint(x: 270, y: 350))
        // 이전 위치에서 (70,350)까지 선 추가
        context.addLine(to: CGPoint(x: 70, y: 350))
        // 이전 위치에서 (170,200)까지 선 추가
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.strokePath()      // 추가한 선을 콘텍스트에 그림
        
        // 현재 콘텍스트에서 그려진 이미지를 가지고 와서 이미지 뷰에 할당
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()     // 그림 그리기를 끝냄
    }
    
    // 사각형 그리기 함수
    @IBAction func btnDrawRectangle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // 사각형 그리기
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        // (70,100) 위치에서 가로 200, 세로 200 크기의 사각형 추가
        context.addRect(CGRect(x: 70, y: 100, width: 200, height: 200))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // 원 그리기 함수
    @IBAction func btnDrawCircle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // 타원 그리기
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        // (70,50) 위치에서 가로 200, 세로 100 크기의 타원 추가
        context.addEllipse(in: CGRect(x: 70, y: 50, width: 200, height: 100))
        context.strokePath()
        
        // 원 그리기
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.green.cgColor)
        
        // (70,200) 위치에서 가로 200, 세로 200 크기의 타원 추가. 즉 원을 추가
        context.addEllipse(in: CGRect(x: 70, y: 200, width: 200, height: 200))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // 호 그리기 함수
    @IBAction func btnDrawArc(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // 호 그리기
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.move(to: CGPoint(x: 100, y: 50))
        context.addArc(tangent1End: CGPoint(x: 250, y:50), tangent2End: CGPoint(x: 250, y: 200), radius: CGFloat(50))
        context.addLine(to: CGPoint(x: 250, y: 200))
        
        context.move(to: CGPoint(x: 100, y: 250))
        context.addArc(tangent1End: CGPoint(x: 270, y: 250), tangent2End: CGPoint(x: 100, y: 400), radius: CGFloat(20))
        context.addLine(to: CGPoint(x: 100, y: 400))
        
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // 색상 채우기 함수
    @IBAction func btnDrawFill(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // 사각형 그리기
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        // 채우기 색상 설정
        context.setFillColor(UIColor.red.cgColor)
        
        let rectangle = CGRect(x: 70, y: 50, width: 200, height: 100)
        context.addRect(rectangle)
        context.fill(rectangle)    // 사각형 채우기
        context.strokePath()
        
        // 타원 그리기
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        let circle = CGRect(x: 70, y: 200, width: 200, height: 100)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)   // 타원 채우기
        context.strokePath()
        
        // 삼각형 그리기
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 350))
        context.addLine(to: CGPoint(x: 270, y: 450))
        context.addLine(to: CGPoint(x: 70, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 350))
        context.fillPath()      // 선 채우기
        context.strokePath()     // 선으로 그려진 삼각형의 내부 채우기
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}

