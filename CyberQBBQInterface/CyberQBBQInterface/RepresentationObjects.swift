//
//  RepresentationObjects.swift
//  CyberQBBQInterface
//
//  Created by Raphael Brunner on 19.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Foundation

let possibleConfigurationParameters:[String] = ["COOK_NAME", "COOK_SET", "FOOD1_NAME",
                                                "FOOD1_SET", "FOOD2_NAME", "FOOD2_SET",
                                                "FOOD3_NAME", "FOOD3_SET", "_COOK_TIMER",
                                                "COOK_TIMER", "COOKHOLD", "TIMEOUT_ACTION",
                                                "ALARMDEV", "COOK_RAMP", "OPENDETECT",
                                                "CYCTIME", "PROPBAND", "MENU_SCROLLING",
                                                "LCD_BACKLIGHT", "LCD_CONTRAST", "DEG_UNITS",
                                                "ALARM_BEEPS", "KEY_BEEPS"]



class StatusRepresentation {
    
    var output:Output
    var timer:BBQTimer
    var cook:Cook
    var food:[Food]
    var system:System
    var control:Control
    var fan:Fan
    
    init(output:Output, timer:BBQTimer, cook:Cook, food:[Food], system:System, control:Control, fan:Fan) {
        self.output = output
        self.timer = timer
        self.cook = cook
        self.food = food
        self.system = system
        self.control = control
        self.fan = fan
    }
    
}

class ConfigRepresentation {
    var cook:CookLong
    var food:[FoodLong]
    var output:Output
    var timer:BBQTimer
    var system:SystemLong
    var control:ControlLong
    var wifi:Wifi
    var stmp:Stmp
    var software:Software
    
    init (cook:CookLong, food:[FoodLong], output:Output, timer:BBQTimer, system:SystemLong, control:ControlLong, wifi:Wifi, stmp:Stmp, software:Software) {
        self.cook = cook
        self.food = food
        self.output = output
        self.timer = timer
        self.system = system
        self.control = control
        self.wifi = wifi
        self.stmp = stmp
        self.software = software
    }
}

class AllRepresentation {
    var cook:Cook
    var food:[Food]
    var output:Output
    var timer:BBQTimer
    var system:System
    var control:Control
    
    init(cook:CookLong, food:[FoodLong], output:Output, timer:BBQTimer, system:SystemShort, control:ControlShort) {
        self.cook = cook
        self.food = food
        self.output = output
        self.timer = timer
        self.system = system
        self.control = control
    }
}

class Fan {
    var fan:String
    
    init(fan:String){
        self.fan = fan
    }
}

protocol Status {
    func printStatus() -> String
}

protocol Cook:Status {
    
}

class CookShort:Cook {
    var temp:Double
    var status:AlarmValues
    
    init(temp:Double, status:Int){
        self.temp = temp
        if let stats = AlarmValues(rawValue: status) {
            self.status = stats
        } else {
            self.status = .ERROR
        }
    }
    
    func printStatus() -> String {
        return alarmValues[status.rawValue]
    }
}
class CookLong:CookShort {
    var name:String
    var set:Int
    
    
    
    init(name:String, set:Int, status:Int, temp:Double) {
        self.name = name
        self.set = set
        super.init(temp: temp, status: status)
    }
}

protocol Food:Status {
    
}

class FoodShort:Food {
    var temp:Double
    var status:AlarmValues
    
    init(temp:Double, status:Int){
        self.temp = temp
        if let stats = AlarmValues(rawValue: status) {
            self.status = stats
        } else {
            self.status = .ERROR
        }
    }
    
    func printStatus() -> String {
        return alarmValues[status.rawValue]
    }
}

class FoodLong:FoodShort {
    var name:String
    var set:Int
    
    init(name:String, set:Int, status:Int, temp:Double) {
        self.name = name
        self.set = set
        super.init(temp: temp, status: status)
    }
}

class Output {
    var value:Int
    
    init(value:Int) {
        self.value = value
    }
}

class BBQTimer:Status {

    var curr:String
    var status:AlarmValues
    
    init(curr:String, status:Int) {
        self.curr = curr
        if let stats = AlarmValues(rawValue: status) {
            self.status = stats
        } else {
            self.status = .ERROR
        }
    }
    
    func printStatus() -> String {
        return alarmValues[status.rawValue]
    }
}

protocol System {
    
}

class SystemShort: System {
    var degUnits:Int
    
    init(degUnits:Int){
        self.degUnits = degUnits
    }
}

class SystemLong: SystemShort {
    var menuScrolling:Int
    var backlight:Int
    var contrast:Int
    var alarmBeeps:Int
    var keyBeeps:Int
    
    init(menuScrolling:Int, backlight:Int, contrast:Int, alarmBeeps:Int, keyBeeps:Int, degUnits:Int){
        self.menuScrolling = menuScrolling
        self.backlight = backlight
        self.contrast = contrast
        self.alarmBeeps = alarmBeeps
        self.keyBeeps = keyBeeps
        super.init(degUnits: degUnits)
    }
}

protocol Control {
    
}

class ControlShort:Control {
    var cookRamp:Int
    var cyctime:Int
    var proband:Int
    
    init(cookRamp:Int, cyctime:Int, proband:Int){
        self.cookRamp = cookRamp
        self.cyctime = cyctime
        self.proband = proband
    }
}

class ControlLong:ControlShort {
    var timeout:Int = 0
    var cookhold:Int = 2000
    var alarmDev:Int = 500
    var openDetect:Int = 1
    
    init(timeout:Int, cookhold:Int, alarmDev:Int, openDetect:Int, cookRamp:Int, cyctime:Int, proband:Int){
        self.timeout = timeout
        self.cookhold = cookhold
        self.alarmDev = alarmDev
        self.openDetect = openDetect
        super.init(cookRamp: cookRamp, cyctime: cyctime, proband: proband)
    }
}

class Wifi {
    var ip:String = ""
    var nm:String = ""
    var gw:String = ""
    var dns:String = ""
    var wifiMode:Int = 0
    var dhcp:Int = 0
    var ssid:String = ""
    var mac:String = ""
    var wifiEnc:String = ""
    var wifiKey:String = ""
    var port:Int = 80
}

class Stmp {
    var host:String = ""
    var port:Int = 0
    var user:String = ""
    var password:String = ""
    var destination:String = ""
    var from:String = ""
    var subject:String = ""
    var alert:Int = 0
}

class Software {
    var version:Double = 0
}

enum AlarmValues: Int {
    case OK = 0
    case HIGH = 1
    case LOW = 2
    case DONE = 3
    case ERROR = 4
    case HOLD = 5
    case ALARM = 6
    case SHUTDOWN = 7
}

let alarmValues:[String] = ["OK", "HIGH", "LOW", "DONE", "ERROR", "HOLD", "ALARM", "SHUTDOWN"]
