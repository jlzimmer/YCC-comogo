//
//  HomePageViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButton()
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
    @IBAction func demoSaveAcceptedEvent(_ sender: UIButton) {
        
        let newEvent = YccEvent(title: "test", description: "test desc", start: Date(timeIntervalSinceNow: 0), end: Date(timeIntervalSinceNow: 0), category: "test category", posted: Date(timeIntervalSinceNow: 0), location: "test location", id: "test id")
        
        if let event = Event(title: newEvent.title, eventDescription: newEvent.description, eventStartDate: newEvent.start, eventEndDate: newEvent.end, category: newEvent.category, location: newEvent.location, postedDate: newEvent.posted, acceptedStatus: "accepted", id: newEvent.id) {
            do {
                let managedContext = event.managedObjectContext
                try managedContext?.save()
                print("Saved?")
            } catch {
                print("Error saving context")
            }
        }
    }
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
    func acceptEvent(){
        //TBD
    }
    
    //Edit event data so that it is declined
    func declineEvent(){
        //TBD
    }
    
}
