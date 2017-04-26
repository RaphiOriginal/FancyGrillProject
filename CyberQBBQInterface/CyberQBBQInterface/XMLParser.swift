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
    
    func parseStatus(statusXML:String, status: inout StatusRepresentation?) -> StatusRepresentation {
        if status == nil {
            status = StatusRepresentation()
        }
        xmlhash = SWXMLHash.parse(statusXML)
        status?.updateOutput(new: Output(value: getValue(value: "OUTPUT_PERCENT")))
        status?.updateTimer(new: BBQTimer(curr: getValue(value: "TIMER_CURR")!, status: getValue(value: "TIMER_STATUS")))
        status?.updateCook(new: StatusValues(temp: getValue(value: "COOK_TEMP"), status: getValue(value: "COOK_STATUS")))
        status?.updateFood(new: StatusValues(temp: getValue(value: "FOOD1_TEMP"), status: getValue(value: "FOOD1_STATUS")), index: 0)
        status?.updateFood(new: StatusValues(temp: getValue(value: "FOOD2_TEMP"), status: getValue(value: "FOOD2_STATUS")), index: 1)
        status?.updateFood(new: StatusValues(temp: getValue(value: "FOOD3_TEMP"), status: getValue(value: "FOOD3_STATUS")), index: 2)
        status?.updateSystem(new: System(degUnits: getValue(value: "DEG_UNITS")))
        status?.updateControl(new: Control(cookRamp: getValue(value: "COOK_RAMP"), cyctime: getValue(value: "COOK_CYCTIME"), proband: getValue(value: "COOK_PROPBAND")))
        status?.updateFan(new: Fan(fan: getValue(value: "FAN_SHORTED")!))
        
        return status!
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
