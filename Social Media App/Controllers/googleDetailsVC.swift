//
//  googleDetailsVC.swift
//  Social Media App
//
//  Created by sherif on 10/02/2022.
//

import UIKit
import GoogleSignIn

class googleDetailsVC: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var emaiLBL: UILabel!
    @IBOutlet weak var givenNameLBL: UILabel!
    @IBOutlet weak var familyNameLBL: UILabel!
    @IBOutlet weak var imageView: UIImageView!{
        
        didSet{
            imageView.layer.borderWidth = 1.0
            imageView.layer.masksToBounds = false
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
        }
    }
    
    //MARK:- Vars
    
    var name = ""
    var email = ""
    var givenName = ""
    var FamilyName = ""
    var profilePic = URL(string: "")
  
    //MARK:- app lifeCycles
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        displayData()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:-Ib actions
    
    @IBAction func loOutButtonPressed(_ sender: UIBarButtonItem) {
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK:- Function Helper


    func displayData(){
        
        nameLBL.text = name
        emaiLBL.text = email
        givenNameLBL.text = givenName
        familyNameLBL.text = FamilyName
        imageView.sd_setImage(with: profilePic!, placeholderImage: #imageLiteral(resourceName: "Image Background Pink Minimal Phone Wallpaper.png"))
    }
}

