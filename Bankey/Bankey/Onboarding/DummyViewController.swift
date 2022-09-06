//
//  DummyViewController.swift
//  Bankey
//
//  Created by Val V on 06/09/22.
//

import UIKit

class DummyViewController: UIViewController {
    
    let button  = UIButton()
    weak var logoutDelegate:LogoutDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        button.setTitle("logout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
        button.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }

    @objc func logoutTapped(sender:UIButton){
        logoutDelegate?.didlogout()
    }
}
