//
//  LoginViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 12/2/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet var blueView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
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
    
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


