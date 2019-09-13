import Foundation
import UIKit

class RedLightChildVC: UIViewController {
    var countdownTimer: Timer!
    var countdown: Int = 3
    
    let label: UILabel = {
        let v = UILabel.init()
        v.text="Red Light!"
        v.font = UIFont.systemFont(ofSize: 24)
        v.textColor = UIColor.black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        view.addSubview(label)
        self.view = view
    }
    
    override func viewDidLoad() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startCountdown), userInfo: nil, repeats: true)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func startCountdown() -> Void{
        if countdown == 0 {
            countdownTimer.invalidate()
            onFinish()
            return
        }
        
        label.text = "\(countdown)"
        
        if countdown >= 1 {
            countdown = countdown - 1
        }
    }
    
    func onFinish(){
        guard let stateMachineVC = self.parent as? StateMachineVC
        else{
                print("This ViewController is not a childViewController")
                return
        }
        
        stateMachineVC.dispatch(action: .go, from: .red)
    }
}
