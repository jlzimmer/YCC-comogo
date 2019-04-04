//
//  LoginViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 12/2/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let encoder = JSONEncoder()
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet var blueView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func login(_ sender: Any) {
        
        let request = ApiRequest()
        let user = UserCreds.init(email: "dwlockster@gmail.com", password: "test123")
        let data = try! encoder.encode(user)
        request.execute(http_method: HTTPMethod.post, url_path: "auth/login", payload: data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = UIColor(rgb: 0x00688F)
        let color2 = UIColor(rgb: 0xFFDD00)
        
        email.layer.borderColor = color1.cgColor
        email.layer.borderWidth = 2
        email.layer.cornerRadius = 20
        email.clipsToBounds = true
        
        
        password.layer.borderColor = color1.cgColor
        password.layer.borderWidth = 2
        password.layer.cornerRadius = 20
        password.clipsToBounds = true
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        loginBtn.backgroundColor = color2
        loginBtn.layer.cornerRadius = 25
        loginBtn.clipsToBounds = true
        
        registerBtn.setTitleColor(color1, for: .normal)
        
        blueView.backgroundColor = color1
        
        

    }
}


