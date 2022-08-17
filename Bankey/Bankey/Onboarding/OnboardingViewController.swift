//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Val V on 17/08/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    let stack = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    
    init(image:UIImage,text:String) {
        imageView.image = image
        label.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    


}

extension OnboardingViewController{
        
    private func style(){
        view.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //stack
        stack.spacing = 20
        stack.axis = .vertical
        
        //image
        imageView.contentMode = .scaleAspectFit
        
        //label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        
    }
    private func layout(){
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
