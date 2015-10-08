//
//  AddEventView.swift
//  Scheduler1
//
//  Created by Kevin J Nguyen on 9/26/15.
//  Copyright © 2015 Kevin J Nguyen. All rights reserved.
//

import Foundation
import UIKit

class AddEventView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "AddEventView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}