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
        let output = Output(value: getValue(value: "OUTPUT_PERCENT"))
        let timer = BBQTimer(curr: getValue(value: "TIMER_CURR")!, status: getValue(value: "TIMER_STATUS"))
        let cook = CookShort(temp: getValue(value: "COOK_TEMP"), status: getValue(value: "COOK_STATUS"))
        let food1 = FoodShort(temp: getValue(value: "FOOD1_TEMP"), status: getValue(value: "FOOD1_STATUS"))
        let food2 = FoodShort(temp: getValue(value: "FOOD2_TEMP"), status: getValue(value: "FOOD2_STATUS"))
        let food3 = FoodShort(temp: getValue(value: "FOOD3_TEMP"), status: getValue(value: "FOOD3_STATUS"))
        let food = [food1, food2, food3]
        let system = SystemShort(degUnits: getValue(value: "DEG_UNITS"))
        let control = ControlShort(cookRamp: getValue(value: "COOK_RAMP"), cyctime: getValue(value: "COOK_CYCTIME"), proband: getValue(value: "COOK_PROPBAND"))
        let fan = Fan(fan: getValue(value: "FAN_SHORTED")!)
        
        return StatusRepresentation(output: output, timer: timer, cook: cook, food: food, system: system, control: control, fan: fan)
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
