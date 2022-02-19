//
//  detailsVC.swift
//  Social Media App
//
//  Created by sherif on 10/02/2022.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage


class detailsVC : UIViewController  {

    
   
   //MARK:-Outlets :
    
    @IBOutlet weak var userProfileImage: UIImageView!{
        // Make image circle 
        didSet{
            userProfileImage.layer.borderWidth = 1.0
            userProfileImage.layer.masksToBounds = false
            userProfileImage.layer.borderColor = UIColor.white.cgColor
            userProfileImage.layer.cornerRadius = userProfileImage.frame.size.width / 2
            userProfileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userBirthday: UILabel!
    
    //MARK:- app lifecycle:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
         fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:-function Helper :-
    
    
    // fetching data using graph api from facebook :
    
    func fetchData(){

        let parameters = ["fields":"email,name,picture.type(large),gender,birthday"]
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters:parameters )
        graphRequest.start(completion: {(connection, result, error) -> Void in
            if (error != nil)
            {
                // Process error
                print("\n\n Error: \(String(describing: error))")
            }
            else if let resultDic = result as? [String:AnyObject]
            {
     //                print("\n\n  fetched user: \(String(describing: result))")
               
                    if let email  = resultDic["email"] as? String {
                        
                        self.userEmail?.text = email
                    }
                    if let name  = resultDic["name"] as? String {
                        
                        self.userFullName?.text = name
                    }
                    if let picture = resultDic["picture"] as?NSDictionary ,let data = picture["data"] as? NSDictionary , let url = data["url"] as? String {
                        
                        self.userProfileImage?.sd_setImage(with: URL(string: url), completed: nil)
                    }
                 
                if let gender = resultDic["gender"] as? String{
                    self.userGender?.text = gender
                    
                }
             
                if let birthDay = resultDic["birthday"] as? String {
                    self.userBirthday?.text = birthDay
                }
            }

        })

    }

}

