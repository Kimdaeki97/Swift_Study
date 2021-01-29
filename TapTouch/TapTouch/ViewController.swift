//
//  ViewController.swift
//  TapTouch
//
//  Created by 김대기 on 2021/01/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Ended"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
 }



/*
과연 이건 나중에 어떤 파일이 될까요
그리고 미래의 김대기가 이 파일들을 보았을 때 지금의 게으른 나 자신을 탓할 것일까요 아니면 이렇게라도 시작한 나 자신을 대견스러워 할까요
저도 참 궁금하네요 올해로 25살이 되었는데 아직 취업에 대한 압박은 심하게 크진 않지만 대입을 준비하기 위해 고등학교 2학년에 올라간 상황 같아요
아직 나의 꿈을 단정짓진 않고 여러 경험을 쌓는 중이지만 저의 시간의 농도는 그리 짙진 않은 것 같아요
*/
