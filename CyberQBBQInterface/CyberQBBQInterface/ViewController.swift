//
//  ViewController.swift
//  CyberQBBQInterface
//
//  Created by Raphael Brunner on 18.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var allText: NSTextField!
    @IBOutlet weak var statusText: NSTextField!
    @IBOutlet weak var configText: NSTextField!
    
    let testIP:String = "192.168.254.123"
    override func viewDidLoad() {
        super.viewDidLoad()

        let cqInterface = CyberQInterface(host: testIP)
        allText.stringValue = cqInterface.getAllXml()
        statusText.stringValue = cqInterface.getStatusXml()
        configText.stringValue = cqInterface.getConfigXml()
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }

    
}

