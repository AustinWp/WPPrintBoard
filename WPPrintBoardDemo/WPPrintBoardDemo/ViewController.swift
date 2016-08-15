//
//  ViewController.swift
//  WPPrintBoardDemo
//
//  Created by Wupeng on 8/11/16.
//  Copyright © 2016 Wooop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var printBoard : WPPrintBoard?
    var bottomView : UIView?
    var colorToolBoard : UIView?
    var fontToolBoard : UIView?
    var imageView : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImageView = UIImageView(image: UIImage(named: "apple"))
        bgImageView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(bgImageView)
        self.imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight - 44))
        self.view.addSubview(self.imageView!)
        let board = WPPrintBoard(frame: CGRectMake(0, 0, screenWidth, screenHeight - 44))
        self.view.addSubview(board)
        self.printBoard = board
        self.printBoard?.delegate = self
        setUpBottomToolView()
        setUpcolorToolBoard()
        setUpFontToolBoard()
    }
    
    func setUpBottomToolView(){
        
        let buttonWidth = screenWidth / 5
        let bottomView = UIView(frame: CGRectMake(0, screenHeight - 44, screenWidth, 44))
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let buttonTitleArray = Array(arrayLiteral: "颜色","上一步","清空","下一步","宽度")
        
        for index in 0...4 {
            let button = UIButton.init(frame: CGRectMake(CGFloat(index) * buttonWidth, 0, buttonWidth, 44))
            button.setTitle(buttonTitleArray[index], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            if index == 0 {
                button.addTarget(self, action: #selector(colorButtonClick), forControlEvents: .TouchUpInside)
            }
            else if index == 1 {
                button.addTarget(self, action: #selector(revokeButtonClick), forControlEvents: .TouchUpInside)
            }
            else if index == 2 {
                button.addTarget(self, action: #selector(clearButtonClick), forControlEvents: .TouchUpInside)
            }
            else if index == 3 {
                button.addTarget(self, action: #selector(recoverButtonClick), forControlEvents: .TouchUpInside)
            }
            else {
                button.addTarget(self, action: #selector(fontButtonClick), forControlEvents: .TouchUpInside)
            }
            bottomView.addSubview(button)
        }
        self.bottomView = bottomView
        self.view.addSubview(bottomView)
    }
    
    func setUpcolorToolBoard(){
        let buttonWidth = (UIScreen.mainScreen().bounds.width / 3)
        let colorToolView = UIView(frame: CGRectMake(0, screenHeight, screenWidth, 44))
        for index in 0...2 {
            let button = UIButton.init(frame: CGRectMake(CGFloat(index) * buttonWidth, 0, buttonWidth, 44))
            button.tag = index
            button.addTarget(self, action: #selector(colorToolSelect(_:)), forControlEvents: .TouchUpInside)
            
            if index == 0 {
                button.backgroundColor = UIColor.blackColor()
            }
            else if index == 1 {
                button.backgroundColor = UIColor.redColor()
            }
            else {
                button.backgroundColor = UIColor.greenColor()
            }
            
            colorToolView.addSubview(button)
        }
        self.colorToolBoard = colorToolView
        self.view.addSubview(self.colorToolBoard!)
    }
    
    func setUpFontToolBoard(){
        
        let buttonWidth = (UIScreen.mainScreen().bounds.width / 3)
        let fontToolView = UIView(frame: CGRectMake(0, screenHeight, screenWidth, 44))
        fontToolView.backgroundColor = UIColor.lightGrayColor()
        for index in 0...2 {
            let button = UIButton.init(frame: CGRectMake(CGFloat(index) * buttonWidth, 0, buttonWidth, 44))
            button.addTarget(self, action: #selector(fontToolSelect(_:)), forControlEvents: .TouchUpInside)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            if index == 0 {
                button.tag = 3
                button.setTitle("3", forState: .Normal)
            }
            else if index == 1 {
                button.tag = 10
                button.setTitle("10", forState: .Normal)
            }
            else {
                button.tag = 23
                button.setTitle("23", forState: .Normal)
            }
            
            fontToolView.addSubview(button)
        }
        self.fontToolBoard = fontToolView
        self.view.addSubview(self.fontToolBoard!)
    }
    
    
    func colorButtonClick(){
        UIView.animateWithDuration(0.3, animations: { 
            self.bottomView?.frame = CGRectMake(0, self.screenHeight, self.screenWidth, 44)
            }) { (Bool) in
            UIView.animateWithDuration(0.3, animations: { 
                self.colorToolBoard?.frame = CGRectMake(0, self.screenHeight - 44, self.screenWidth, 44)
            })
        }
    }
    
    
    
    func clearButtonClick() {
        self.printBoard!.clearBoard()
    }
    
    func revokeButtonClick() {
        self.printBoard!.revoke()
    }
    
    func recoverButtonClick() {
        self.printBoard?.recover()
    }
    
    func fontButtonClick(){
        UIView.animateWithDuration(0.3, animations: {
            self.bottomView?.frame = CGRectMake(0, self.screenHeight, self.screenWidth, 44)
        }) { (Bool) in
            UIView.animateWithDuration(0.3, animations: {
                self.fontToolBoard?.frame = CGRectMake(0, self.screenHeight - 44, self.screenWidth, 44)
            })
        }
    }
    
    func colorToolSelect(button : UIButton){
        self.printBoard?.setPenColor(button.backgroundColor!.CGColor)
        UIView.animateWithDuration(0.3, animations: {
            self.colorToolBoard?.frame = CGRectMake(0, self.screenHeight, self.screenWidth, 44)
        }) { (Bool) in
            UIView.animateWithDuration(0.3, animations: {
                self.bottomView?.frame = CGRectMake(0, self.screenHeight - 44, self.screenWidth, 44)
            })
        }
    }
    
    func fontToolSelect(button : UIButton) {
        self.printBoard?.setPenWidth(CGFloat(button.tag))
        UIView.animateWithDuration(0.3, animations: {
            self.fontToolBoard?.frame = CGRectMake(0, self.screenHeight, self.screenWidth, 44)
        }) { (Bool) in
            UIView.animateWithDuration(0.3, animations: {
                self.bottomView?.frame = CGRectMake(0, self.screenHeight - 44, self.screenWidth, 44)
            })
        }
    }
    
    func printSixMethod(){
        let sixMethodView = WPPrintSixMethod(frame: UIScreen.mainScreen().bounds)
        sixMethodView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(sixMethodView)
    }
    
    func printImage(){
        let printTool = WPPrintWithUIImge()
        let imageView = UIImageView(image: printTool.printImage())
        self.view.addSubview(imageView)
    }
    
    func printWithCtx(){
        let view = WPPrintWithCtx(frame: UIScreen.mainScreen().bounds)
        self.view.addSubview(view)
        view.backgroundColor = UIColor.whiteColor()
    }
}

extension ViewController : WPPrintBoardDelegate {
    func didNeedToUpdageImage(image: UIImage) {
        self.imageView?.image = image
    }
}

