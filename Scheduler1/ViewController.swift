//
//  ViewController.swift
//  Scheduler1
//
//  Created by Kevin J Nguyen on 9/26/15.
//  Copyright © 2015 Kevin J Nguyen. All rights reserved.
//

import UIKit



class ViewController: UIViewController,TodoSavedDelegate, EventSavedDelegate, UITableViewDelegate {
//    let todoTextfield = UITextField(frame: CGRectMake(0,0,100,50))
//    let eventTextfield = UITextField(frame: CGRectMake(0,30,100,50))
//    let button = UIButton(frame: CGRectMake(0, 70, 200, 50))
    var typeOfEvent: Int = 0    // '0' is todo
    
    @IBOutlet weak var timeView: UITableView!
    @IBOutlet weak var calendarView: UITableView!
    let todoButton = UIButton(frame: CGRectMake(10,0,160,45))
    let eventButton = UIButton(frame: CGRectMake(10, 50, 160, 45))
    let popover = Popover()
    
    
    var allEvents : [Any] = []
    var todos : Array = [Todo]()
    var eventos : Array = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func eventSaved(name:String,startDate:NSDate,endDate:NSDate){
        print("name:\(name) start date: \(startDate) end date: \(endDate)")
        let event = Event(title: name, startTime: startDate, endTime: endDate)
        allEvents.append(event)
        eventos.sortInPlace({ $0.startTime.compare($1.startTime) == NSComparisonResult.OrderedAscending })
        typeOfEvent = 1
        NSUserDefaults.standardUserDefaults().setObject(eventos, forKey: "eventArray")
        self.calendarView.reloadData()

    }
    
    func todoSaved(name:String,duration:Int,dueDate:NSDate){
        print("Name of To-Do:\(name) Duration event: \(duration) Date: \(dueDate)")
        let todo = Todo(title: name, duration: duration, dueDate: dueDate)
        allEvents.append(todo)
        todos.sortInPlace({ $0.dueDate.compare($1.dueDate) == NSComparisonResult.OrderedAscending })
        typeOfEvent = 0
        NSUserDefaults.standardUserDefaults().setObject(todos, forKey: "todoArray")
        self.calendarView.reloadData()
        
    }

    
    @IBAction func plusButtonPress(sender: AnyObject) {
        let startPoint = CGPoint(x: self.view.frame.width - 20, y: 55)
        //let addEventView = AddEventView.instanceFromNib()
        //addEventView.backgroundColor = UIColor.redColor()
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 100))
        
//        todoTextfield.placeholder = "Todo event: "
//        eventTextfield.placeholder = "Event name: "
        
        todoButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        todoButton.setTitle("To-Do ", forState: UIControlState.Normal)
        todoButton.layer.cornerRadius = 10
        todoButton.layer.borderWidth = 3
        todoButton.layer.borderColor = UIColor(red: 141.0/255.0, green: 211.0/255.0, blue: 204.0/255.0, alpha: 1.0).CGColor
        todoButton.addTarget(self, action: "addButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        eventButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        eventButton.setTitle("Event ", forState: UIControlState.Normal)
        eventButton.layer.cornerRadius = 10
        eventButton.layer.borderWidth = 3
        eventButton.layer.borderColor = UIColor(red: 141.0/255.0, green: 211.0/255.0, blue: 204.0/255.0, alpha: 1.0).CGColor
        eventButton.addTarget(self, action: "addButtonPressedEvent", forControlEvents: UIControlEvents.TouchUpInside)

        aView.addSubview(todoButton)
        aView.addSubview(eventButton)
        popover.show(aView, point: startPoint)
    }
    
    func addButtonPressed(){
        performSegueWithIdentifier("todoSegue", sender: self)
    }
    
    func addButtonPressedEvent(){
        performSegueWithIdentifier("eventSegue", sender: self)
    }
    
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "todoSegue"{
            popover.dismiss()
            let vc = segue.destinationViewController as! TodoViewController
            vc.delegate = self
        }
        if segue.identifier == "eventSegue"{
            popover.dismiss()
            let vc = segue.destinationViewController as! EventViewController
            vc.delegate = self
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("The total length of the cal should be \(allEvents.count)")
        return allEvents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "eventCell")
            let todoCell = allEvents[indexPath.row]
            if let todo = todoCell as? Todo{
                cell.textLabel!.text = todo.title + "     " + String(todo.duration) + " min"
                cell.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0);
                return cell
            }
            else if let event = todoCell as? Event{
                let formatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.MediumStyle
                formatter.timeZone = NSTimeZone.localTimeZone()
                formatter.timeStyle = .ShortStyle
                let eventString = formatter.stringFromDate(event.startTime)
                cell.textLabel!.text = event.title + "     " + String(eventString)
                cell.backgroundColor = UIColor(red: 141.0/255.0, green: 211.0/255.0, blue: 204.0/255.0, alpha: 1.0)
                return cell
            }
        return cell
    }
}

