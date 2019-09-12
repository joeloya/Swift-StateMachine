//
//  ViewController.swift
//  State Machine ChildViewControllers
//
//  Created by selfiestation on 9/12/19.
//  Copyright © 2019 selfiestation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var childAViewController: UIViewController!
    var childBViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        childAViewController = ChildAViewController()
        childBViewController = ChildBViewController()
        
        // Child B
        
        self.addChild(childBViewController)
        self.view.addSubview(childBViewController.view)
        childBViewController.didMove(toParent: self)
        
        childBViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childBViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        childBViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        childBViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        childBViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Child A
        
        self.addChild(childAViewController)
        self.view.addSubview(childAViewController.view)
        childAViewController.didMove(toParent: self)
        
        childAViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childAViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        childAViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        childAViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        childAViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        

    }


}


class ChildAViewController : UIViewController {
    var label: UILabel!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .clear
        
        label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
    
        view.addSubview(label)
        self.view = view
    }
    
    override func viewDidLoad() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

    }
}

class ChildBViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .green
        
        self.view = view
    }
}

class ChildCViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .blue
        
        self.view = view
    }
}

