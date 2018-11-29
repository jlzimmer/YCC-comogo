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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picture.image=UIImage(named: (dummyEvents?.pictureString)!)
        eventTitle.text = dummyEvents?.title
        let concatStartTime = (dummyEvents?.startTime)! + "  -"
        time.text = concatStartTime
        location.text = dummyEvents?.location
        eventDes.text = "JKFHKSJNDASKdmlkamsdlkasmdlkamdlkewmdkladmla"
        endTime.text = dummyEvents?.endTime
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
