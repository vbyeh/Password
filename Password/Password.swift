//
//  Password.swift
//  Password
//
//  Created by Vincent Yeh on 12/23/15.
//  Copyright © 2015 Vincent Bob Yeh. All rights reserved.
//

import Foundation
import UIKit

class Password: UIViewController{    //when it doesn't conform to protocol it is because some functions need to be implemented
    @IBOutlet weak var numberButton1: UIButton!
    @IBOutlet weak var numberButton2: UIButton!
    @IBOutlet weak var numberButton3: UIButton!
    @IBOutlet weak var numberButton4: UIButton!
    @IBOutlet weak var numberButton5: UIButton!
    @IBOutlet weak var numberButton6: UIButton!
    @IBOutlet weak var numberButton7: UIButton!
    @IBOutlet weak var numberButton8: UIButton!
    @IBOutlet weak var numberButton9: UIButton!
    @IBOutlet weak var numberButton0: UIButton!
    let firstNum = UILabel()
    let secondNum = UILabel()
    let thirdNum = UILabel()
    let fourthNum = UILabel()
    let fifthNum = UILabel()
    let sixthNum = UILabel()
    var allLabels:[UILabel]=[]
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var level: UILabel!
    let firstImg = UIImageView()
    let secondImg = UIImageView()
    let thirdImg = UIImageView()
    let fourthImg = UIImageView()
    let fifthImg = UIImageView()
    let sixthImg = UIImageView()
    var currentTime = 0
    var completeLevel = false
    var labelCounter = 0
    var generatedNum = [Int?]()
    var guessArray = [Int?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var labelCount = 0
        allLabels.append(firstNum)
        allLabels.append(secondNum)
        allLabels.append(thirdNum)
        allLabels.append(fourthNum)
        allLabels.append(fifthNum)
        allLabels.append(sixthNum)
        let center = self.view.center.x
        level.text = currentLevel + " Passwords"
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        numberButton1.layer.cornerRadius = 0.5 * numberButton1.bounds.size.width
        numberButton2.layer.cornerRadius = 0.5 * numberButton2.bounds.size.width
        numberButton3.layer.cornerRadius = 0.5 * numberButton3.bounds.size.width
        numberButton4.layer.cornerRadius = 0.5 * numberButton4.bounds.size.width
        numberButton5.layer.cornerRadius = 0.5 * numberButton5.bounds.size.width
        numberButton6.layer.cornerRadius = 0.5 * numberButton6.bounds.size.width
        numberButton7.layer.cornerRadius = 0.5 * numberButton7.bounds.size.width
        numberButton8.layer.cornerRadius = 0.5 * numberButton8.bounds.size.width
        numberButton9.layer.cornerRadius = 0.5 * numberButton9.bounds.size.width
        numberButton0.layer.cornerRadius = 0.5 * numberButton0.bounds.size.width
        let totalCells = Int(currentLevel)!
        currentTime = totalCells * 100
        for _ in 1...totalCells{
            generatedNum.append(Int(arc4random_uniform(9)))
        }
        print(generatedNum)
        print(currentLevel)
        let startingCell = Int(-(totalCells-1)*25)
        print(startingCell)
        for label in allLabels{
            if (labelCount <  totalCells){
                label.frame = CGRect(x: 0, y:150, width:40, height:40)
                label.center.x = center + CGFloat(startingCell + labelCount*50)
                label.backgroundColor = UIColor.whiteColor()
                self.view.addSubview(label)
            }else{
                label.hidden = true
            }
            labelCount++
        }
    }
    
    func checkGuess(Array: [Int?]){
        var colorGreen = 0
        var colorYellow = 0
        var colorRed = 0
        var in_skiperino = [Int]()
        var out_skiperino = [Int]()
        let totalCells = Int(currentLevel)!
        for outer_index in 0...totalCells-1{
            for inner_index in 0...totalCells-1{
                if (!(in_skiperino.contains(inner_index)) && !(out_skiperino.contains(outer_index))){
                    if(outer_index == inner_index && Array[outer_index] == generatedNum[inner_index]){
                        in_skiperino.append(inner_index)
                        out_skiperino.append(outer_index)
                        colorGreen++    //correct in position and in value
                    }else if (outer_index != inner_index && Array[outer_index] == generatedNum[inner_index]){
                        if (Array[inner_index] == generatedNum[inner_index]){   //prioritize same position and value first
                            colorGreen++
                        }else{
                        //implement storing mechanism for correct value but wrong position
                        colorYellow++   //stored integer
                        }
                        in_skiperino.append(inner_index)
                        out_skiperino.append(outer_index)
                    }else{
                    colorRed++      //incorrect guess irrelevant to computation
                }
                }
            }
        }
        var allColors:[UIImageView]=[]
        allColors.append(firstImg)
        allColors.append(secondImg)
        allColors.append(thirdImg)
        allColors.append(fourthImg)
        allColors.append(fifthImg)
        allColors.append(sixthImg)
        print(colorGreen)
        print(colorYellow)
        print(colorRed)
        let center = self.view.center.x
        let startingColor = Int(-(totalCells-1)*17)
        var colorCount = 0
        if (colorGreen == totalCells){
            completeLevel = true
            for img in allColors{
                if (colorCount < totalCells){
                    img.image = UIImage(named: "greencircle.jpg")
                    img.frame = CGRect(x: 0, y:112, width:24, height:24)
                    img.center.x = center + CGFloat(startingColor + colorCount*34)
                    self.view.addSubview(img)
                    colorCount++
                }else{
                    break
                }
            }
        let alert = UIAlertController(title: "YEH!", message: "You Guessed Correct!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler:nil))
        self.presentViewController(alert, animated: false, completion: nil)
        }else{
            for img in allColors{
                if (colorCount < totalCells){
                    if (colorGreen > 0){
                        img.image = UIImage(named: "greencircle.jpg")
                        img.frame = CGRect(x: 0, y:112, width:24, height:24)
                        img.center.x = center + CGFloat(startingColor + colorCount*34)
                        self.view.addSubview(img)
                        colorCount++
                        colorGreen--
                    }else if (colorYellow > 0){
                        img.image = UIImage(named: "yellowDiamond.jpg")
                        img.frame = CGRect(x: 0, y:112, width:24, height:24)
                        img.center.x = center + CGFloat(startingColor + colorCount*34)
                        self.view.addSubview(img)
                        colorCount++
                        colorYellow--
                    }else{
                        img.image = UIImage(named: "redX.jpg")
                        img.frame = CGRect(x: 0, y:112, width:24, height:24)
                        img.center.x = center + CGFloat(startingColor + colorCount*34)
                        self.view.addSubview(img)
                        colorCount++
                    }
                }else{
                    break
                }
            }
        }
            for label in allLabels{     //empty all texts, guessed array, and label counter
                label.text = nil
            }
            guessArray = [Int?]()
            labelCounter = 0
    }
    

    @IBAction func guess(sender: UIButton){
        let totalCells = Int(currentLevel)!
        let number = sender.titleForState(.Normal)!
        if (allLabels[labelCounter].text == nil){
                allLabels[labelCounter].text = number
                allLabels[labelCounter].textAlignment = NSTextAlignment.Center
                guessArray.append(Int(allLabels[labelCounter].text!))
                labelCounter++
                if(labelCounter == totalCells){
                    return checkGuess(guessArray)
            }
        }
    }
    
    func update() {
        if(currentTime > -1 && completeLevel == false)
        {
            timer.text = String(currentTime--)
        }else if (currentTime < 0 && completeLevel == false){
            let alert = UIAlertController(title: "Sorry!", message: "You Ran Out of Time!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler:nil))
            self.presentViewController(alert, animated: false, completion: nil)
            let totalCells = Int(currentLevel)!
            currentTime = totalCells * 100
        }
        }
}