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
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    var leadingEdgeOnScreen = 16
    var leadingEdgeOffScreen = -1000
    
    var titleLeadingAnchor:NSLayoutConstraint?
    var subTitleLeadingAnchor:NSLayoutConstraint?


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
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
    }

 
}

extension LoginViewController{
    private func style(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        
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
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  CGFloat(leadingEdgeOffScreen))
        titleLeadingAnchor?.isActive = true
        titleLabel.alpha = 0
        

        subTitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: CGFloat(leadingEdgeOnScreen))
        subTitleLeadingAnchor?.isActive = true
        view.layoutIfNeeded()
        subtitleLabel.alpha = 0
        
        
        NSLayoutConstraint.activate([
            
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //8pts->1
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2 ),
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 2),
            
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorMessageLabel.trailingAnchor, multiplier: 1),
                        
        ])
        
        subTitleLeadingAnchor?.constant = CGFloat(leadingEdgeOffScreen)
        view.layoutIfNeeded()
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

extension LoginViewController{
    func animate(){
        UIView.animate(withDuration: 3) {
            self.titleLeadingAnchor?.constant = CGFloat(self.leadingEdgeOnScreen)
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 2) {
            self.subTitleLeadingAnchor?.constant = CGFloat(self.leadingEdgeOnScreen)
            self.view.layoutIfNeeded()
        }
        
        let animator = UIViewPropertyAnimator(duration: 3, curve: .easeIn) {
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1 
        }
        
        animator.startAnimation(afterDelay: 0.5)
        
        
    }
}
