//
//  ViewController.swift
//  Bankey
//
//  Created by Val V on 12/08/22.
//

import UIKit

protocol LoginViewControllerDelegate:AnyObject{
    func didlogin(_ sender:LoginViewController)
}

protocol LogoutDelegate:AnyObject{
    func didlogout()
}

class LoginViewController: UIViewController {
    
    //subscriber will have a strong ref
    weak var delegate:LoginViewControllerDelegate?

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    
    var username:String?{
        return loginView.usernameTextField.text
    }
    var password:String?{
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        signInButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
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
        
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .red
        errorMessageLabel.textAlignment  = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = ""
        
    }
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //8pts->1
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1 ),
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1 ),
            
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorMessageLabel.trailingAnchor, multiplier: 1),
                        
        ])
    }
}

extension LoginViewController{
    @objc func signInTapped(){
        
        errorMessageLabel.isHidden = true
        login()

    }
    
    private func login(){
        guard let username = username ,let password  = password else {
            assertionFailure("userneame password nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be empty")
            return
        }
        
        if username == "Kevin" && password == "welcome"{
            signInButton.configuration?.showsActivityIndicator  = true
            delegate?.didlogin(self)
            return
        }
        else{
            configureView(withMessage: "Username/password is wrong")
        }
        
    }
    
    private func configureView(withMessage message:String){
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}
