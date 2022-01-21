//
//  Frame.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/17.
//

import Foundation
import UIKit

extension UIView {
    var x: Double {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    var y: Double {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    var width: Double {
        get {
            return self.frame.width
        }
        set {
            self.frame = CGRect(x: x, y: y, width: newValue, height: height)
        }
    }
    var height: Double {
        get {
            return self.frame.height
        }
        set {
            self.frame = CGRect(x: x, y: y, width: width, height: newValue)
        }
    }
    
    var left: Double {
        get {
            return self.x
        }
        set {
            self.frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    var right: Double {
        get {
            return self.x + self.width
        }
        set {
            self.frame = CGRect(x: newValue - self.width, y: y, width: width, height: height)
        }
    }
    var top: Double {
        get {
            return self.y
        }
        set {
            self.frame = CGRect(x: x, y: newValue, width: newValue, height: height)
        }
    }
    var bottom: Double {
        get {
            return self.y + self.height
        }
        set {
            self.frame = CGRect(x: x, y: newValue - self.height, width: width, height: height)
        }
    }
}
