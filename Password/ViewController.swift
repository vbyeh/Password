//
//  ViewController.swift
//  Password
//
//  Created by Vincent Yeh on 12/23/15.
//  Copyright © 2015 Vincent Bob Yeh. All rights reserved.
//

import UIKit

var currentLevel = ""

class ViewController: UIViewController{    //when it doesn't conform to protocol it is because some functions need to be implemented
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let center = self.view.center.x
        self.tutorialButton.layer.cornerRadius = 5.0
        self.threeButton.layer.cornerRadius = 5.0
        threeButton.addTarget(self, action: "getValue:", forControlEvents: .TouchUpInside)
        self.fourButton.layer.cornerRadius = 5.0
        fourButton.addTarget(self, action: "getValue:", forControlEvents: .TouchUpInside)
        self.fiveButton.layer.cornerRadius = 5.0
        fiveButton.addTarget(self, action: "getValue:", forControlEvents: .TouchUpInside)
        self.sixButton.layer.cornerRadius = 5.0
        sixButton.addTarget(self, action: "getValue:", forControlEvents: .TouchUpInside)
    }
    
    func getValue(sender: UIButton!){
        return currentLevel = sender.titleLabel!.text!
    }
}