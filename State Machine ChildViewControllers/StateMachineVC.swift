//
//  StateMachineVC.swift
//  State Machine ChildViewControllers
//

import UIKit

struct StateMachine {
    enum State {
        case green
        case yellow
        case red
        case errorState
    }
    
    enum Transition {
        case caution
        case stop
        case go
    }
    
    var currentState: State
    
    init(initialState: State) {
        self.currentState = initialState
    }
    
    func getState(for transition: Transition, onState state: State) -> State{
        if state == .green && transition == .caution {
            return State.yellow
        }
        
        if state == .yellow && transition == .stop {
            return State.red
        }
        
        if state == .red && transition == .go {
            return State.green
        }
        
        // This state will only be returned if a ChildVC dispatches an invalid combination to the StateMachineVC)
        // Like ( .green, .stop ) => .errorState
        // Like ( .green, .go ) => .errorState
        // Like ( .yellow, .caution ) => .errorState
        // Like ( .yellow, .go ) => .errorState
        // etc
        return State.errorState
    }
    
}

class StateMachineVC: UIViewController {
    
    var stateMachine: StateMachine! {
        didSet {
            renderNewChildViewController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateMachine = StateMachine(initialState: .green)
    }
    
    func renderNewChildViewController(){
        switch stateMachine.currentState {
        case .green:
            let child = GreenLightChildVC()
            self.addChildController(child)
        case .yellow:
            let child = YellowLightChildVC()
            self.addChildController(child)
        case .red:
            let child = RedLightChildVC()
            self.addChildController(child)
        case .errorState:
            print("Invalid State from invalid Input")
            // You could probably create a cute error viewcontroller to display here if you wanted.
            break;
        }
    }
    
    func addChildController(_ child: UIViewController){
        // Remove all others first
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        
        self.addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        child.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        child.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        child.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func dispatch(action: StateMachine.Transition, from currentState: StateMachine.State){
        
        let nextState = stateMachine.getState(for: action, onState: currentState)

        print("------------------")
        print("Prev State: \(currentState)")
        print("Action: \(action)")
        print("Next State: \(nextState)")
        print("------------------")
        
        stateMachine.currentState = nextState
    }

}
