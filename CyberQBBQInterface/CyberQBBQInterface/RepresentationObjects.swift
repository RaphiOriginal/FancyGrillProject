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
    
    var output:Output?
    var timer:BBQTimer?
    var cook:StatusValues?
    var food:[StatusValues]
    var system:System?
    var control:Control?
    var fan:Fan?
    
    init(output:Output, timer:BBQTimer, cook:StatusValues, food:[StatusValues], system:System, control:Control, fan:Fan) {
        self.output = output
        self.timer = timer
        self.cook = cook
        self.food = food
        self.system = system
        self.control = control
        self.fan = fan
    }
    
    init() {
        food = []
    }
        
    func updateOutput(new:Output){
        if output != nil {
            output!.update(new: new)
        } else {
            output = new
        }
    }
    
    func updateTimer(new:BBQTimer){
        if timer != nil {
            timer!.update(new: new)
        } else {
            timer = new
        }
    }
    
    func updateCook(new:StatusValues){
        if cook != nil {
            cook!.update(new: new)
        } else {
            cook = new
        }
    }
    
    func updateFood(new:StatusValues, index:Int){
        if food.count >= 3 {
            food[index].update(new: new)
        } else {
            food.append(new)
        }
    }
    
    func updateSystem(new:System){
        if system != nil {
            system!.update(new: new)
        } else {
            system = new
        }
    }
    
    func updateControl(new:Control){
        if control != nil {
            control!.update(new: new)
        } else {
            control = new
        }
    }
    
    func updateFan(new:Fan){
        if fan != nil {
            fan!.update(new: new)
        } else {
            fan = new
        }
    }
    
    
    
    
    
    
    
}

class ConfigRepresentation {
    var cook:Cook
    var food:[Food]
    var output:Output
    var timer:BBQTimer
    var system:SystemLong
    var control:ControlLong
    var wifi:Wifi
    var stmp:Stmp
    var software:Software
    
    init (cook:Cook, food:[Food], output:Output, timer:BBQTimer, system:SystemLong, control:ControlLong, wifi:Wifi, stmp:Stmp, software:Software) {
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
    
    init(cook:Cook, food:[Food], output:Output, timer:BBQTimer, system:System, control:Control) {
        self.cook = cook
        self.food = food
        self.output = output
        self.timer = timer
        self.system = system
        self.control = control
    }
}

protocol Listener {
    func listen(value:Any?)
}

class Fan {
    var listener:Listener?
    var fan:String? {
        didSet {
            if oldValue != fan {
                listener?.listen(value: fan)
            }
        }
    }
    
    init(fan:String){
        self.fan = fan
    }
    
    func update(new:Fan){
        fan = new.fan
    }
}

protocol Status {
    func printStatus() -> String
}

class StatusValues:Status {
    var listener:Listener?
    
    var temp:Double {
        didSet {
            if oldValue != temp {
                listener?.listen(value: temp)
            }
        }
    }
    var status:AlarmValues {
        didSet {
            if oldValue != status {
                listener?.listen(value: status)
            }
        }
    }
    
    init(temp:Double, status:Int){
        self.temp = temp
        if let stats = AlarmValues(rawValue: status) {
            self.status = stats
        } else {
            self.status = .ERROR
        }
    }
    
    func update(new:StatusValues){
        temp = new.temp
        status = new.status
    }
    
    func printStatus() -> String {
        return alarmValues[status.rawValue]
    }
}

class Cook:StatusValues {
    
    var name:String {
        didSet {
            if oldValue != name {
                listener?.listen(value: name)
            }
        }
    }
    var set:Int {
        didSet {
            if oldValue != set {
                listener?.listen(value: set)
            }
        }
    }
    
    init(name:String, set:Int, status:Int, temp:Double) {
        self.name = name
        self.set = set
        super.init(temp: temp, status: status)
    }
    
    func update(new:Cook){
        name = new.name
        set = new.set
        status = new.status
        temp = new.temp
    }
}

class Food:StatusValues {
    var name:String {
        didSet {
            if oldValue != name {
                listener?.listen(value: name)
            }
        }
    }
    var set:Int {
        didSet {
            if oldValue != set {
                listener?.listen(value: set)
            }
        }
    }
    
    init(name:String, set:Int, status:Int, temp:Double) {
        self.name = name
        self.set = set
        super.init(temp: temp, status: status)
    }
    
    func update(new:Food){
        name = new.name
        set = new.set
        status = new.status
        temp = new.temp
    }
}

class Output {
    var listener:Listener?
    
    var value:Int {
        didSet {
            if oldValue != value {
                listener?.listen(value: value)
            }
        }
    }
    
    init(value:Int) {
        self.value = value
    }
    
    func update(new:Output) {
        value = new.value
    }
}

class BBQTimer:Status {
    var listener:Listener?

    var curr:String {
        didSet {
            if oldValue != curr {
                listener?.listen(value: curr)
            }
        }
    }
    var status:AlarmValues {
        didSet {
            if oldValue != status {
                listener?.listen(value: status)
            }
        }
    }
    
    init(curr:String, status:Int) {
        self.curr = curr
        if let stats = AlarmValues(rawValue: status) {
            self.status = stats
        } else {
            self.status = .ERROR
        }
    }
    
    func update(new:BBQTimer){
        curr = new.curr
        status = new.status
    }
    
    func printStatus() -> String {
        return alarmValues[status.rawValue]
    }
}

class System {
    var degUnits:Int
    
    init(degUnits:Int){
        self.degUnits = degUnits
    }
    
    func update(new:System) {
        degUnits = new.degUnits
    }
}

class SystemLong: System {
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
    
    func update(new:SystemLong) {
        degUnits = new.degUnits
        menuScrolling = new.menuScrolling
        backlight = new.backlight
        contrast = new.contrast
        alarmBeeps = new.alarmBeeps
        keyBeeps = new.keyBeeps
    }
}

class Control {
    var cookRamp:Int
    var cyctime:Int
    var proband:Int
    
    init(cookRamp:Int, cyctime:Int, proband:Int){
        self.cookRamp = cookRamp
        self.cyctime = cyctime
        self.proband = proband
    }
    
    func update(new:Control) {
        cookRamp = new.cookRamp
        cyctime = new.cyctime
        proband = new.proband
    }
}

class ControlLong:Control {
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
    
    func update(new:ControlLong) {
        cookRamp = new.cookRamp
        cyctime = new.cyctime
        proband = new.proband
        timeout = new.timeout
        cookhold = new.cookhold
        alarmDev = new.alarmDev
        openDetect = new.openDetect
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
