//
//  DeclinedEventDetailViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/30/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit
import CoreData

class DeclinedEventDetailViewController: UIViewController {

    
    var dummyEvents: Event?
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!

    @IBOutlet weak var eventDes: UITextView!
    @IBOutlet weak var addBtn: UIButton!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        
        let color1 = UIColor(rgb: 0x00688F)
        let color2 = UIColor(rgb: 0xFFDD00)
        
        addBtn.backgroundColor = color2
        addBtn.layer.cornerRadius = 25
        addBtn.clipsToBounds = true
        
        let dateString = dateFormatter.string(from: (dummyEvents?.eventStartDate)!)
        
        //Need to figure out a better way to do this
        let calendar = Calendar.current
        let start = calendar.component(.hour, from: (dummyEvents?.eventStartDate)!)
        let end   = calendar.component(.hour, from: (dummyEvents?.eventEndDate)!)

        
        picture.image=UIImage(named: "e1")
        eventTitle.text = dummyEvents?.title
        eventTitle.textColor = color1
        let concatStartTime = String(start) + "  -"
        startTime.text = concatStartTime
        location.text = dummyEvents?.location
        eventDes.text = dummyEvents?.eventDescription
        endTime.text = String(end)
        eventDate.text = dateString
        // Do any additional setup after loading the view.
        
        self.title = "Event Details"
    }
        // Do any additional setup after loading the view.
    @IBAction func addEvent(_ sender: UIButton) {
        acceptEvent()
        navigationController?.popViewController(animated: true)
    }
    
    func acceptEvent(){
        let ident = dummyEvents?.id!
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
                managedObject.setValue("accepted", forKey: "acceptedStatus")
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


