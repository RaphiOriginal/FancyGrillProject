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
    
    var status:StatusRepresentation?
    
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
        status = test.parseStatus(statusXML: cqInterface.getStatusXml()!, status: &status)
        
        output.stringValue = String((status?.output?.value)!) + "%"
        timer.stringValue = (status?.timer?.curr)!
        cookTemp.stringValue = String(strategy.getValue(rawValue: (status?.cook?.temp)!))
        food1.stringValue = String(strategy.getValue(rawValue: (status?.food[0].temp)!))
        food2.stringValue = String(strategy.getValue(rawValue: (status?.food[1].temp)!))
        food3.stringValue = String(strategy.getValue(rawValue: (status?.food[2].temp)!))
        cookStatus.stringValue = (status?.cook?.printStatus())!
        food1Status.stringValue = (status?.food[0].printStatus())!
        food2Status.stringValue = (status?.food[1].printStatus())!
        food3Status.stringValue = (status?.food[2].printStatus())!
        timerStatus.stringValue = (status?.timer?.printStatus())!
        degUnits.stringValue = String((status?.system?.degUnits)!)
        cookCycTime.stringValue = String((status?.control?.cyctime)!)
        cookProband.stringValue = String((status?.control?.proband)!)
        cookRamp.stringValue = String((status?.control?.cookRamp)!)
        fan.stringValue = (status?.fan?.fan)!
        
        
    }

    
}

