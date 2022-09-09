//
//  AppDelegate.swift
//  Bankey
//
//  Created by Val V on 12/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onBoardingVc = OnboardingContainerViewController()
    let dummyVc = DummyViewController()
    let localState = LocalState()
    let tabVc = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        loginViewController.delegate = self
        onBoardingVc.delegate = self
        dummyVc.logoutDelegate = self
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        //window?.rootViewController = OnboardingContainerViewController()
            

        displayLogin()
        

        return true

    }
    
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(tabVc)
        } else {
            setRootViewController(onBoardingVc)
        }
    }
    
    private func prepMainView() {
        tabVc.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
    



}

extension AppDelegate:LoginViewControllerDelegate{
    func didlogin(_ sender: LoginViewController) {
        displayNextScreen()
    }
}

extension AppDelegate:OnboardingContainerViewControllerDelegate{
    func didfinishOnboarding(_ sender: OnboardingContainerViewController) {
        print("Finished Onboarding")
        prepMainView()
        setRootViewController(tabVc)

    }
}

extension AppDelegate:LogoutDelegate{
    func didlogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate{
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

class VCC:UIViewController{
    override func viewDidLoad() {
        view.backgroundColor = .yellow
    }
}
