//
//  CyberQInterface.swift
//  CyberQBBQInterface
//
//  Created by Raphael Brunner on 18.04.17.
//  Copyright © 2017 Raphael Brunner. All rights reserved.
//

import Foundation

class CyberQInterface {
    
    let host:String
    let status:URL
    let config:URL
    let all:URL
    
    init(host:String) {
        self.host = "http://" + host
        self.status = URL(string: self.host + "/status.xml")!
        self.config = URL(string: self.host + "/config.xml")!
        self.all = URL(string: self.host + "/all.xml")!
        print(self.host)
        print(self.status.absoluteString)
        print(self.config.absoluteString)
        print(self.all.absoluteString)
    }
    
    func getAllXml () -> String {
        do {
            return try String(contentsOf: all)
        } catch {
            return "Error"
        }
    }
    
    func getStatusXml () -> String {
        do {
            return try String(contentsOf: status)
        } catch {
            return "Error"
        }
    }
    
    func getConfigXml () -> String {
        do {
            return try String(contentsOf: config)
        } catch {
            return "Error"
        }
    }
    
    
    
    
}
