//
//  ViewController.swift
//  Scheduler1
//
//  Created by Kevin J Nguyen on 9/26/15.
//  Copyright © 2015 Kevin J Nguyen. All rights reserved.
//

import UIKit

protocol EventSavedDelegate {
    func eventSaved(name:String,startDate:NSDate,endDate:NSDate)
}

class EventViewController: UIViewController, UITextFieldDelegate {
    var todo = ""
    
    var delegate:EventSavedDelegate?
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func plusButtonPress(sender: AnyObject) {
        delegate?.eventSaved(eventTextField.text!, startDate: startDatePicker.date, endDate: endDatePicker.date)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTextField.delegate = self
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        eventTextField.resignFirstResponder()
        
        return false
    }

}

