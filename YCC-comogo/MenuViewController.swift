//
//  MenuViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/30/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_index: Int32)
}

class MenuViewController: UIViewController {

    @IBOutlet weak var viewDeclinedEvents: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
        var btnMenu : UIButton!
        var delegate: SlideMenuDelegate?
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            let color2 = UIColor(rgb: 0xFFDD00)
            let color1 = UIColor(rgb: 0x00688F)
            viewDeclinedEvents.setTitleColor(color2, for: .normal)
            settings.setTitleColor(color2, for: .normal)
            refresh.setTitleColor(color2, for: .normal)
            logOut.setTitleColor(color2, for: .normal)
            menuView.backgroundColor = color1
        // Do any additional setup after loading the view.
    }
    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
