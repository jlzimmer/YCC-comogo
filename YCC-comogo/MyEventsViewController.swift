//
//  MyEventsViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit
import CoreData

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var eventsTableView: UITableView!
    var dummyEvents: [DummyEvent]=[]
    var filteredEvents = [DummyEvent]()
    var searching = false
    
    var myEvents = [Event]() //Array of Event which matches our core data entity.
  

    override func viewDidLoad() {
        super.viewDidLoad()
    
        dummyEvents.append(DummyEvent(title: "Football Game", startTime: "7:00pm", endTime:"10:00pm", location: "Hickman HS", pictureString: "e1"))
        dummyEvents.append(DummyEvent(title: "Art Class", startTime: "4:00pm", endTime:"5:00pm", location: "Rockbridge HS", pictureString: "e2"))
        dummyEvents.append(DummyEvent(title: "Volunteer Event", startTime: "2:00pm", endTime:"4:00pm", location: "Downtown Columbia", pictureString: "e3"))
        dummyEvents.append(DummyEvent(title: "College Prep Corse", startTime: "6:00pm", endTime:"7:30pm", location: "Hickman HS", pictureString: "e4"))
       dummyEvents.append(DummyEvent(title: "Basketball Game", startTime: "6:30pm", endTime:"9:00pm", location: "Rockbridge HS", pictureString: "e5"))
        
        navigationItem.largeTitleDisplayMode = .never
        self.title = "My Events"

        self.eventsTableView.isHidden = true
        self.animateTable()


        self.searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateEvents()
    }
    
    func populateEvents(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let attendingStatus = "accepted"
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "acceptedStatus == %@", attendingStatus) //Queries our core data for only events that the user has accepted.
        do {
            myEvents = try managedContext.fetch(fetchRequest)
            
            eventsTableView.reloadData() //After fetching the events, it will reload the data.
            //To do From a UI standpoint:
            //Set the data cells to be fetched from core data.
            
            //This is successful, so, saving events to an accepted event works in theory.
            print(myEvents.count)
            //To do from a testing standpoint: Have some stored data source of accepted events, then do some other bulllllshit.
        } catch {
            print("Error: Fetch could not be performed")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredEvents.count
        }
        else{
            return dummyEvents.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellEvent: DummyEvent
        if let cell = cell as? EventTableViewCell {
            if searching {
                cellEvent = filteredEvents[indexPath.row]
            }
            else{
                cellEvent = dummyEvents[indexPath.row]
            }
          //  let color1 = UIColor(rgb: 0x00688F)
            let color2 = UIColor(rgb: 0xFFDD00)
            let color3 = UIColor(rgb: 0x3286a5)
            cell.title.text = cellEvent.title
            cell.title.textColor = color2
            cell.time.text = cellEvent.startTime
            cell.location.text = cellEvent.location
            cell.picture.image = UIImage(named: cellEvent.pictureString)
            cell.eventDate.text = "November 10, 2018  @"
            cell.bgColor.backgroundColor = color3
            
            cell.layer.cornerRadius = 12
            cell.layer.masksToBounds = true
            
            
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventDetailViewController,
            let row = eventsTableView.indexPathForSelectedRow?.row {
            destination.dummyEvents = dummyEvents[row]
        }
    }
    func animateTable(){
        self.eventsTableView.reloadData()
        
        let cells = eventsTableView.visibleCells
        let tableHeight: CGFloat = eventsTableView.bounds.size.height
        
        for i in cells{
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        let index = 0
        
        for a in cells {
            self.eventsTableView.isHidden = false
             let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 0.8, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {cell.transform = CGAffineTransform(translationX: 0, y: 0)}, completion: nil)
        }
    }
    
}
// search function
extension MyEventsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredEvents1 = [DummyEvent]() //results for search by title search
        var filteredEvents2 = [DummyEvent]() // results for search by location search 
        filteredEvents1 = dummyEvents.filter({$0.title.prefix(searchText.count)==searchText})
        filteredEvents2 = dummyEvents.filter({$0.location.prefix(searchText.count)==searchText})

        filteredEvents = filteredEvents1 + filteredEvents2
        searching = true
        eventsTableView.reloadData()

    }
}

