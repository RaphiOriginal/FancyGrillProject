//
//  ViewController.swift
//  CyberQBBQInterface
//
//  Created by Raphael Brunner on 18.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var output: NSTextField!
    @IBOutlet weak var timer: NSTextField!
    @IBOutlet weak var cookTemp: NSTextField!
    @IBOutlet weak var food1: NSTextField!
    @IBOutlet weak var food2: NSTextField!
    @IBOutlet weak var food3: NSTextField!
    @IBOutlet weak var cookStatus: NSTextField!
    @IBOutlet weak var food1Status: NSTextField!
    @IBOutlet weak var food2Status: NSTextField!
    @IBOutlet weak var food3Status: NSTextField!
    @IBOutlet weak var timerStatus: NSTextField!
    @IBOutlet weak var degUnits: NSTextField!
    @IBOutlet weak var cookCycTime: NSTextField!
    @IBOutlet weak var cookProband: NSTextField!
    @IBOutlet weak var cookRamp: NSTextField!
    @IBOutlet weak var fan: NSTextField!
    
    let strategy:DegreeStrategy = CelsiusStrategy()
    
    let testIP:String = "192.168.254.123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateView()
        }
        
        CyberQInterface(host: testIP).testAlamofire()
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }
    
    func updateView() {
        let cqInterface = CyberQInterface(host: testIP)
        
        let test = XMLParser()
        let status = test.parseStatus(statusXML: cqInterface.getStatusXml()!)
        
        output.stringValue = String(status.output) + "%"
        timer.stringValue = status.timer
        cookTemp.stringValue = String(strategy.getValue(rawValue: status.cookTemp))
        food1.stringValue = String(strategy.getValue(rawValue: status.food1Temp))
        food2.stringValue = String(strategy.getValue(rawValue: status.food2Temp))
        food3.stringValue = String(strategy.getValue(rawValue: status.food3Temp))
        cookStatus.stringValue = alarmValues[status.cookStatus]
        food1Status.stringValue = alarmValues[status.food1Status]
        food2Status.stringValue = alarmValues[status.food2Status]
        food3Status.stringValue = alarmValues[status.food3Status]
        timerStatus.stringValue = alarmValues[status.timerStatus]
        degUnits.stringValue = String(status.degreeUnits)
        cookCycTime.stringValue = String(status.cookCycTime)
        cookProband.stringValue = String(status.cookProband)
        cookRamp.stringValue = String(status.cookRamp)
        fan.stringValue = String(status.fan)
        
        
    }

    
}

