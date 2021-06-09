//
//  ViewController.swift
//  SwiftyRouter
//
//  Created by grandchinamass@gmail.com on 06/01/2021.
//  Copyright (c) 2021 grandchinamass@gmail.com. All rights reserved.
//

import UIKit
import SwiftyRouter


class ViewController: UIViewController {
    
    var data1: Any?
    var data2: Any?
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func request() {
        
        requestService("path/user/info", parameter: "uid") { [weak self] rspData in
            self?.label.text = rspData as? String
        }
    }
    
    @IBAction func boardcast() {
        
        broadcastService("path/user/info", parameter: "uid") { [weak self] rspData in
            self?.label.text = rspData as? String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.label.textColor = UIColor.blue
        
        data1 = DemoSeveice(register: true)
        data2 = DemoSeveice1(register: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


class DemoSeveice: SwiftyService {
    
    required init() {
    }
    
    var routers: [String] {
        return [ "path/user/info"]
    }
    
    func listen(router: String, parameter: Any?, complete: ((Any?) -> Void)?) {
        if router == "path/user/info" {
            complete?("rsp>info")
        }
    }
}

class DemoSeveice1: SwiftyService {
    
    required init() {
    }
    
    var serviceId: String {
        return "1"
    }
    
    var routers: [String] {
        return [ "path/user/info"]
    }
    
    func listen(router: String, parameter: Any?, complete: ((Any?) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if router == "path/user/info" {
                complete?("rsp2>info")
            }
        }
    }
    
}
