//
//  DeclinedEventsViewController.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/30/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import UIKit
import CoreData

class DeclinedEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventTableView: UITableView!
    var filteredEvents = [Event]()
    var searching = false
    var myEvents = [Event]() //Array of Event which matches our core data entity.
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        populateEvents()
        navigationItem.largeTitleDisplayMode = .never
        
        self.title = "Declined Events"
        self.eventTableView.isHidden = true
        self.animateTable()
        
        
        self.searchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        populateEvents()
        self.eventTableView.reloadData()
    }
    
    func populateEvents(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let attendingStatus = "declined"
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "acceptedStatus == %@", attendingStatus) //Queries our core data for only events that the user has declined.
        do {
            myEvents = try managedContext.fetch(fetchRequest)
            eventTableView.reloadData() //After fetching the events, it will reload the data.
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
            return myEvents.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellEvent: Event
        if let cell = cell as? EventTableViewCell {
            if searching {
                cellEvent = filteredEvents[indexPath.row]
            }
            else{
                cellEvent = myEvents[indexPath.row]
            }
            
            
            let color2 = UIColor(rgb: 0xFFDD00)
            let color3 = UIColor(rgb: 0x3286a5)
            cell.title.text = cellEvent.title
            cell.title.textColor = color2
            cell.time.text = ""
            cell.location.text = cellEvent.location
            cell.picture.image = UIImage(named: "e2")
            cell.eventDate.text = dateFormatter.string(from: cellEvent.eventStartDate!)
            cell.bgColor2.backgroundColor = color3
            
            
            cell.layer.cornerRadius = 12
            cell.layer.masksToBounds = true
            
            
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DeclinedEventDetailViewController,
            let row = eventTableView.indexPathForSelectedRow?.row {
            destination.dummyEvents = myEvents[row]
        }
    }
    func animateTable(){
        self.eventTableView.reloadData()
        
        let cells = eventTableView.visibleCells
        let tableHeight: CGFloat = eventTableView.bounds.size.height
        
        for i in cells{
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        let index = 0
        
        for a in cells {
            self.eventTableView.isHidden = false
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 0.8, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {cell.transform = CGAffineTransform(translationX: 0, y: 0)}, completion: nil)
        }
    }
    
}
// search function
extension DeclinedEventsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredEvents1 = [Event]() //results for search by title search
        var filteredEvents2 = [Event]() // results for search by location search
        filteredEvents1 = myEvents.filter({$0.title!.prefix(searchText.count)==searchText})
        filteredEvents2 = myEvents.filter({$0.location!.prefix(searchText.count)==searchText})
        
        filteredEvents = filteredEvents1 + filteredEvents2
        searching = true
        eventTableView.reloadData()
        
    }
}


