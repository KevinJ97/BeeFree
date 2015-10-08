//
//  ViewController.swift
//  Scheduler1
//
//  Created by Kevin J Nguyen on 9/26/15.
//  Copyright © 2015 Kevin J Nguyen. All rights reserved.
//

import UIKit

protocol TodoSavedDelegate {
    func todoSaved(name:String,duration:Int,dueDate:NSDate)
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}

class TodoViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    var todo = ""
    var delegate:TodoSavedDelegate?
    
    @IBOutlet weak var timeSelector: UIPickerView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var eventNameTextField: UITextField!
    
    var pickerData = [["0 hr","1 hr", "2 hr", "3 hr", "4 hr", "5 hr", "6 hr", "7 hr", "8 hr"],["0 min", "5 min", "10 min", "15 min", "20  min", " 25 min", "30 min", "35 min", "40 min", "45 min", "50 min", "55 min"]]
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSelector.delegate = self
        timeSelector.dataSource = self
        eventNameTextField.delegate = self
    }

    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        eventNameTextField.resignFirstResponder()
        
        return false
    }
    
    private func convertDurationPickerToSeconds()->Int{
        let hour = pickerData[0][timeSelector.selectedRowInComponent(0)]
        let minute = pickerData[1][timeSelector.selectedRowInComponent(1)]
        let minuteArray = minute.componentsSeparatedByString(" ")
        let hourString = hour[0...0]
        let hourInt = Int(hourString)!
        let firstMin = Int(minuteArray[0])!
        let durationConverted = hourInt * 60 + firstMin
        
        return durationConverted
    }
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        delegate?.todoSaved(eventNameTextField.text!, duration: convertDurationPickerToSeconds(), dueDate: dueDatePicker.date)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
}

