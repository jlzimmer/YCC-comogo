//
//  DeclinedEventDetailViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/30/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit

class DeclinedEventDetailViewController: UIViewController {

    
     var dummyEvents: DummyEvent?
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var eventDes: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color1 = UIColor(rgb: 0x00688F)
        let color2 = UIColor(rgb: 0xFFDD00)
        
        addBtn.backgroundColor = color2
        addBtn.layer.cornerRadius = 25
        addBtn.clipsToBounds = true
        
        
        picture.image=UIImage(named: (dummyEvents?.pictureString)!)
        eventTitle.text = dummyEvents?.title
        eventTitle.textColor = color1
        let concatStartTime = (dummyEvents?.startTime)! + "  -"
        startTime.text = concatStartTime
        location.text = dummyEvents?.location
        eventDes.text = "JKFHKSJNDASKdmlkamsdlkasmdlkamdlkewmdkladmla"
        endTime.text = dummyEvents?.endTime
        eventDate.text = "November 28th 2018"
        // Do any additional setup after loading the view.
        
        self.title = "Event Details"
    }
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


