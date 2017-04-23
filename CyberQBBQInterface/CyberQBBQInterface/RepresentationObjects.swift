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
    
    var output:Int = 0
    var timer:String = ""
    var cookTemp:Double = 0
    var food1Temp:Double = 0
    var food2Temp:Double = 0
    var food3Temp:Double = 0
    var cookStatus:Int = 0
    var food1Status:Int = 0
    var food2Status:Int = 0
    var food3Status:Int = 0
    var timerStatus:Int = 0
    var degreeUnits:String = ""
    var cookCycTime:String = ""
    var cookProband:String = ""
    var cookRamp:String = ""
    var fan:String = ""
    
}

class Cook {
    var name:String = "Cook"
    var temp:Double = 0
    var set:Int = 0
    var status:AlarmValues = .ERROR
}

class Food {
    var name:String = "Food"
    var temp:Double = 0
    var set:Int = 0
    var status:AlarmValues = .ERROR
}

class Output {
    var value:Int = 0
}

class BBQTimer {
    var curr:String = "00:00:00"
    var status:AlarmValues = .ERROR
}

class System {
    var menuScrolling:Int = 0
    var backlight:Int = 50
    var contrast:Int = 10
    var degUnits:Int = 0
    var alarmBeeps:Int = 3
    var keyBeeps:Int = 1
}

class Control {
    var timeout:Int = 0
    var cookhold:Int = 2000
    var alarmDev:Int = 500
    var cookRamp:Int = 0
    var openDetect:Int = 1
    var cyctime:Int = 6
    var proband:Int = 300
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
