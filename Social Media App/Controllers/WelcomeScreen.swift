//
//  ViewController.swift
//  Social Media App
//
//  Created by sherif on 02/02/2022.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class WelcomeScreen: UIViewController{
    
    
    //MARK:-constants
    
    let signInConfig = GIDConfiguration.init(clientID: "349553738440-00v180mj678a4b0mgqgs8jdm3pl1vmd1.apps.googleusercontent.com")
    

    
    //MARK:- app lifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookButtonUI()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:-IBactions
    
    @IBAction func SignINButtonPressed(_ sender: Any) {
        
        googleAuthSignIn()
    }
    

    //MARK:-Function Helper
    
    //creating Button programmatically :-
    
    func facebookButtonUI(){
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        view.addSubview(loginButton)
        
        // set Button constraints programatically  : -
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        
        //activate constraints
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint])
        
    }
    
    
    func googleAuthSignIn(){

        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else {
                print("oooh sorry something went wrong !!!")
                return }
            let emailAddress = user.profile?.email ?? ""
            let fullName = user.profile?.name ?? ""
            let givenName = user.profile?.givenName ?? ""
            let familyName = user.profile?.familyName ?? ""
            guard let profilePicUrl = user.profile?.imageURL(withDimension: 500) else {return}
            
            let googleDetailsVC = UIStoryboard(name: "Main", bundle: nil)
            if let goDetails = googleDetailsVC.instantiateViewController(withIdentifier: "googleDetailsVC")as? googleDetailsVC {
                
                self.navigationController?.pushViewController(goDetails, animated: true)
                
                goDetails.email = emailAddress
                goDetails.name = fullName
                goDetails.givenName = givenName
                goDetails.FamilyName = familyName
                goDetails.profilePic = profilePicUrl
                
            }
        }
        
    }
    
}

//MARK:- Extensions :-


// loginButton Delegate for Fb Button
extension WelcomeScreen : LoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?){
        
        // handle the function if user press cancel
        if error != nil {
            
            print("Facebook login failed. Error \(String(describing: error))")
            
        } else if result?.isCancelled == true {
            print("Facebook login was cancelled.")
        } else {
          
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailsVc = storyboard.instantiateViewController(withIdentifier: "FetchUserProfileController")as? detailsVC {
                self.navigationController?.pushViewController(detailsVc, animated: true)
            }
            
        }
       
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}


