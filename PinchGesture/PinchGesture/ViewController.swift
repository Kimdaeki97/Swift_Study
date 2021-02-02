//
//  ViewController.swift
//  PinchGesture
//
//  Created by 김대기 on 2021/02/02.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgPinch: UIImageView!
    
    var initialFontSize:CGFloat!    // 글자 크기를 저장하기 위한 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UIPinchGestureRecognizer 클래스 상수 pinch 선언
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)    // 핀치 제스처 등록
    }
    
    /*
    // 텍스트 핀치
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // 핀치 제스처 상태 확인
        if (pinch.state == UIGestureRecognizer.State.began) {
            // 시작 상태이면 현재 글자 크기를 저장
            initialFontSize = txtPinch.font.pointSize
        } else {
            // 시작 상태가 아니면 텍스트의 글자 크기를 변경
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale)
        }
    }
    */

    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // 이미지를 스케일에 맞게 변환
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        
        // 다음 변환을 위해 스케일 속성을 1로 설정
        pinch.scale = 1
    }
}

