//
//  EventDetailViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    var dummyEvents: DummyEvent?
    @IBOutlet weak var eventDes: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
    var actualEvent: Event?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let color1 = UIColor(rgb: 0x00688F)
        //let color2 = UIColor(rgb: 0xFFDD00)
       // let color3 = UIColor(rgb: 0x3286a5)

        eventTitle.textColor = color1
        
        picture.image=UIImage(named: "e2")
        eventTitle.text = actualEvent?.title
//        let concatStartTime = (dummyEvents?.startTime)! + "  -"
        time.text = "ahh"
        location.text = actualEvent?.location
        eventDes.text = "JKFHKSJNDASKdmlkamsdlkasmdlkamdlkewmdkladmla"
        endTime.text = "AHHH"
        date.text = "November 28th 2018"
        // Do any additional setup after loading the view.
        
        self.title = "Event Details"
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
