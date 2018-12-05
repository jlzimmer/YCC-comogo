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
    enum DateError: String, Error {
        case invalidDate
    }
    
    var myEvents = [Event]()
    
    //this is the array that should be fulled from for extracting the event information
    var eventsToDisplay = [Event]()
    
    var currentIndex = 0

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var myEventsBtn: UIButton!
    
    @IBOutlet weak var locationLabel: UILabel!
    let jsonDecoder = JSONDecoder()
    
    @IBOutlet weak var eventDate: UILabel!
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStoredEvents()

        getFromAPI()
        
        populateDisplayableEvents()
        
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

        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        //function to display Actual event information
        showEvents()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchStoredEvents() //provides a reference to all of our locally stored eventss
        getFromAPI() //updates local storage with new events.
        populateDisplayableEvents()
        
    }
    
    func showEvents(){
        if (eventsToDisplay.count == 0){
            eventTitle.text = "You have no more events to view!"
            
        } else {
            eventTitle.text = eventsToDisplay[0].title
            let startDateString = dateFormatter.string(from: eventsToDisplay[0].eventStartDate!)
            print(startDateString)
            eventDate.text = startDateString
            locationLabel.text = eventsToDisplay[0].location
            descriptionTextView.text = eventsToDisplay[0].eventDescription
            eventImage.image = UIImage(named: "e2") // need to set this dynamically, but it is what it is.
        }
    }
   
    @IBAction func likeEvent(_ sender: UIButton) {
        acceptEvent(index: 0) //modify the events status in core data
        populateDisplayableEvents() // update what our displayable events table contains
        print(eventsToDisplay.count)
        showEvents() //update the current event shown.
    }
    
    @IBAction func dislikeEvent(_ sender: UIButton) {
        declineEvent(index: 0)
        populateDisplayableEvents()
        print(eventsToDisplay.count)
        showEvents()
    }
    func populateDisplayableEvents(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let attendingStatus = "undecided"
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "acceptedStatus == %@", attendingStatus)
        do {
            eventsToDisplay = try managedContext.fetch(fetchRequest)
            
        } catch {
            print("Error: Fetch could not be performed")
            return
        }
    }
    
    //function to save an event in core data
    func saveEvent(newEvent: YccEvent){
        if (checkIfNewEvent(ident: newEvent.id) == false){
            return
        }
        else {
            if let event = Event(title: newEvent.title, eventDescription: newEvent.description, eventStartDate: newEvent.start, eventEndDate: newEvent.end, category: newEvent.category, location: newEvent.location, postedDate: newEvent.posted, acceptedStatus: "undecided", id: newEvent.id) {
                do {
                    let managedContext = event.managedObjectContext
                    try managedContext?.save()
                } catch {
                    print("Error saving context")
                }
            }
        }
    }
    
    func checkIfNewEvent(ident: String) -> Bool{
        for event in myEvents {
            if (event.id == ident){
                return false
            }
        }
        return true
    }
    
    func fetchStoredEvents(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        do {
            myEvents = try managedContext.fetch(fetchRequest)
            print(myEvents.count)
            
        } catch {
            print("Error: Fetch could not be performed")
            return
        }
    }
    
    //Edit event data so that it is favorited.
    func acceptEvent(index: Int){
        let eventToBeModified = eventsToDisplay[index]
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
        let eventToBeModified = eventsToDisplay[index]
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
    
    func getFromAPI(){
        let jsonUrlString = "https://ycc-api.herokuapp.com/api/event/"
        guard let url = URL(string: jsonUrlString) else {return}
        var request = URLRequest(url: url)
        request.addValue("JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdHRlbmRpbmdFdmVudHMiOltdLCJob3N0aW5nRXZlbnRzIjpbXSwiX2lkIjoiNWMwNmM2MGJmNmU1ZWYwMDE2ODk1OTc4IiwiZW1haWwiOiJuYXRoYW4ub3J0YmFsc0BnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJOYXRoYW4iLCJsYXN0TmFtZSI6Ik9ydGJhbHMiLCJwYXNzd29yZCI6IiQyYiQxMCRCY2YvVjNDR1gucnJLN0ZKd2doaENlRDlJb0tJV3hPQmJaSzJGUVNxeGxsYnJSeGkxa0MwTyIsInBob25lTnVtYmVyIjoiMzMzNDU2MTIzNCIsInJvbGUiOiI1YzA2YzdjNmY2ZTVlZjAwMTY4OTU5N2EiLCJ2YWxpZGF0aW9uS2V5IjoiNWMwNmM2MGJmNmU1ZWYwMDE2ODk1OTc5IiwiX192IjowLCJpYXQiOjE1NDM5NDkyMDl9.arf9m2SkJAhOjdHh8Tq3lqLRDfDgEYoE4frWiPvlh_w",forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){(data,response,err) in
            guard err == nil else{
                print("error gettinge events")
                return
            }
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy =   .custom({ (decoder) -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)
                    
                    let formatter = DateFormatter()
                    formatter.calendar = Calendar(identifier: .iso8601)
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.timeZone = TimeZone(secondsFromGMT: 0)
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                    throw DateError.invalidDate
                })
                let events = try decoder.decode([YccEvent].self, from: data)
                for event in events{
                    self.saveEvent(newEvent: event)
                }
            } catch {
                print("hmm: \(error)")
            }
            
            }.resume()
    }
    
}
