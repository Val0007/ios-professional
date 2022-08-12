//
//  ViewController.swift
//  Bankey
//
//  Created by Val V on 12/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
            

    }

 
}

extension LoginViewController{
    private func style(){
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
    }
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(signInButton)
        
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //8pts->1
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1 ),
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1 )

            
            
        ])
    }
}

extension LoginViewController{
    @objc func signInTapped(){
        print("tap")
    }
}
