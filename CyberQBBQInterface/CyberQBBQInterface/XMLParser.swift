//
//  XMLParser.swift
//  CyberQBBQInterface
//
//  Created by Raphael Brunner on 19.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Foundation

class XMLParser {
    
    var xmlhash:XMLIndexer? = nil
    
    func parseStatus(statusXML:String) -> StatusRepresentation {
        xmlhash = SWXMLHash.parse(statusXML)
        let status = StatusRepresentation()
        status.output = getValue(value: "OUTPUT_PERCENT")
        status.timer = getValue(value: "TIMER_CURR")!
        status.cookTemp = getValue(value: "COOK_TEMP")
        status.food1Temp = getValue(value: "FOOD1_TEMP")
        status.food2Temp = getValue(value: "FOOD2_TEMP")
        status.food3Temp = getValue(value: "FOOD3_TEMP")
        status.cookStatus = getValue(value: "COOK_STATUS")
        status.food1Status = getValue(value: "FOOD1_STATUS")
        status.food2Status = getValue(value: "FOOD2_STATUS")
        status.food3Status = getValue(value: "FOOD3_STATUS")
        status.timerStatus = getValue(value: "TIMER_STATUS")
        status.degreeUnits = getValue(value: "DEG_UNITS")!
        status.cookCycTime = getValue(value: "COOK_CYCTIME")!
        status.cookProband = getValue(value: "COOK_PROPBAND")!
        status.cookRamp = getValue(value: "COOK_RAMP")!
        status.fan = getValue(value: "FAN_SHORTED")!
        
        return status
    }
    
    func getValue(value:String) -> String? {
        if let val = xmlhash?["nutcstatus"][value].element?.text {
            return val
        }
        return nil
    }
    
    func getValue(value:String) -> Double {
        if let val = xmlhash?["nutcstatus"][value].element?.text {
            if let number = Double.init(val) {
                return number
            }
        }
        return 0
    }
    
    func getValue(value:String) -> Int {
        if let val = xmlhash?["nutcstatus"][value].element?.text {
            if let number = Int.init(val) {
                return number
            }
        }
        return 4 //This means Error for Status
    }
}
