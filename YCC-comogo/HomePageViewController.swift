//
//  HomePageViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit
import CoreData

//Basic workflow as I see it:
//App loads, makes request to API, API results are saved into core data.
    // We should only be saving events who do not have an event with the same existent ID stored
    // -> Then, we query core data to get the results that have a status of "undecided", place them into the
    // myEvents array, and display them.
//The table displays all events that have an accepted status of "undecided"
//When the user clicks decline or accept, the event at that indexes accepted status is modified to the appropriate option
//The view is reloaded, meaning we query for core data events that have a status of "undecided".
//
class HomePageViewController: BaseViewController{
    
    var myEvents = [Event]()

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
    
    //IMPORTANT: Remember to sever this outlet as code testing continues
    
    //The purpose of the function below is to provide a mechanism to save an event in core data storage.
    //This is an accepted event which should show up when we print from our "MyEventsViewController".
//    @IBAction func demoSaveAcceptedEvent(_ sender: UIButton) {
//
//        let newEvent = YccEvent(title: "test", description: "test desc", start: Date(timeIntervalSinceNow: 0), end: Date(timeIntervalSinceNow: 0), category: "test category", posted: Date(timeIntervalSinceNow: 0), location: "test location", id: "test id")
//
//        if let event = Event(title: newEvent.title, eventDescription: newEvent.description, eventStartDate: newEvent.start, eventEndDate: newEvent.end, category: newEvent.category, location: newEvent.location, postedDate: newEvent.posted, acceptedStatus: "accepted", id: newEvent.id) {
//            do {
//                let managedContext = event.managedObjectContext
//                try managedContext?.save()
//                print("Saved?")
//            } catch {
//                print("Error saving context")
//            }
//        }
//    }
    //function to save an event in core data
    func saveEvent(newEvent: YccEvent){
        if let event = Event(title: newEvent.title, eventDescription: newEvent.description, eventStartDate: newEvent.start, eventEndDate: newEvent.end, category: newEvent.category, location: newEvent.location, postedDate: newEvent.posted, acceptedStatus: "undecided", id: newEvent.id) {
            do {
                let managedContext = event.managedObjectContext
                try managedContext?.save()
            } catch {
                print("Error saving context")
            }
        }
    }
    
    //Edit event data so that it is favorited.
    func acceptEvent(index: Int){
        let eventToBeModified = myEvents[index]
        let ident = eventToBeModified.id!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", ident)
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
        
        //fetch request for the event we want to change:
    }
    
    //Edit event data so that it is declined
    func declineEvent(index: Int){
        let eventToBeModified = myEvents[index]
        let ident = eventToBeModified.id!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", ident)
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
