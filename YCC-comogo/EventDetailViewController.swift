//
//  EventDetailViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit
import CoreData

class EventDetailViewController: UIViewController {

    @IBOutlet weak var removeBtn: UIButton!
    var dummyEvents: Event?

    @IBOutlet weak var eventDes: UITextView!
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
        let color2 = UIColor(rgb: 0xFFDD00)
       // let color3 = UIColor(rgb: 0x3286a5)

        eventTitle.textColor = color1
        
        removeBtn.backgroundColor = color2
        removeBtn.layer.cornerRadius = 25
        removeBtn.clipsToBounds = true
        
        picture.image=UIImage(named: "e2")
        eventTitle.text = actualEvent?.title

   
        location.text = actualEvent?.location
        eventDes.text = actualEvent?.eventDescription
        endTime.text = "AHHH"
        date.text = "November 28th 2018"
        // Do any additional setup after loading the view.
        
        self.title = "Event Details"
    }
    

    
    @IBAction func removeBtn(_ sender: Any) {
        
        removeEvent()
        navigationController?.popViewController(animated: true)
    }
    
    func removeEvent(){
        let ident = actualEvent?.id!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", ident!)
        do {
            let grabbedEvent = try managedContext.fetch(fetchRequest)
            if grabbedEvent.count != 0 {
                let managedObject = grabbedEvent[0]
                managedObject.setValue("declined", forKey: "acceptedStatus")
                do {
                    try managedContext.save()
                } catch {
                    print("could not save managed context")
                }
            }
        } catch {
            print("event could not be modified")
        }
        
    }
}

