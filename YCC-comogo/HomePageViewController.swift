//
//  HomePageViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController{

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var myEventsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButton()
       
        let nav = self.navigationController?.navigationBar
        self.title = "ComoGo"
        let color2 = UIColor(rgb: 0xFFDD00)
        let color1 = UIColor(rgb: 0x00688F)
        let color3 = UIColor(rgb: 0x99c2d2)
        
        eventTitle.textColor = color1
        myEventsBtn.backgroundColor = color3
        myEventsBtn.setTitleColor(color1, for: .normal)
        
        let lightGrey = UIColor(rgb: 0x7A7A7A)
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color2]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color2]
        nav?.tintColor = color1
        nav?.barTintColor = lightGrey
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
