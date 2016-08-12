//
//  WPPrintBoard.swift
//  WPPrintBoardDemo
//
//  Created by Wupeng on 8/11/16.
//  Copyright © 2016 Wooop. All rights reserved.
//

import UIKit

class WPPrintBoard: UIView {
    
    let size = UIScreen.mainScreen().bounds
    private var currentPoints = [CGPoint]() //记录当前位置的点集
    private var currentPenWidth : CGFloat = 5;
    private var currentPenColor : CGColor = UIColor.blackColor().CGColor;
    private var currentPath = [WPBezierModel]() //当前路径
    private var pathArray = [[WPBezierModel]]() //所有路径数据和(在当前路径还在绘制的过程中不包含当前路径)
    private var tempPaths = [[WPBezierModel]]() //当做队列维护，用于服务于撤销后恢复的功能
    private var DEBUG : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        printWithPaths(self.pathArray)
        printWithCurrent(self.currentPath)
    }
    
    func printWithPaths(paths : [[WPBezierModel]]){
        
        for path in paths {
            for bezierModel in path {
                self.printBezierLine(bezierModel)
            }
        }
    }
    
    func printWithCurrent(path : [WPBezierModel]){
        for bezierModel in path {
            self.printBezierLine(bezierModel)
        }
    }
    
    func printBezierLine(bezierModel : WPBezierModel){
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, bezierModel.penWidth)
        CGContextSetStrokeColorWithColor(ctx, bezierModel.penColor)
        CGContextSetLineCap(ctx, .Round)
        CGContextSetLineJoin(ctx, .Round)
        CGContextMoveToPoint(ctx, bezierModel.startPoint.x, bezierModel.startPoint.y)
        CGContextAddQuadCurveToPoint(ctx, bezierModel.controlPoint.x, bezierModel.controlPoint.y, bezierModel.endPoint.x, bezierModel.endPoint.y)
        CGContextStrokePath(ctx)
        
        if self.DEBUG {
            CGContextSetLineWidth(ctx, 2)
            CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
            CGContextStrokeRect(ctx, CGRectMake(bezierModel.controlPoint.x, bezierModel.controlPoint.y, 1, 1))
            
            CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextStrokeRect(ctx, CGRectMake(bezierModel.startPoint.x, bezierModel.startPoint.y, 1, 1))
            
            CGContextSetStrokeColorWithColor(ctx, UIColor.greenColor().CGColor)
            CGContextStrokeRect(ctx, CGRectMake(bezierModel.endPoint.x, bezierModel.endPoint.y, 1, 1))
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.locationInView(self)
        if currentPath.count != 0 {
            currentPath.removeAll()
        }
        if tempPaths.count != 0 {
            tempPaths.removeAll()
        }
        self.currentPoints = [point,point,point]
        currentPath.append(WPBezierModel(startP: point, endP: point, controlP: point, pColor: currentPenColor, pWidth: currentPenWidth))
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.locationInView(self)
        self.currentPoints = [currentPoints[1],currentPoints[2],point]
        let bezierStartPoint = CGPointMake((currentPoints[0].x+currentPoints[1].x)/2, (currentPoints[0].y+currentPoints[1].y)/2)
        let bezierEndPoint = CGPointMake((currentPoints[1].x+currentPoints[2].x)/2, (currentPoints[1].y+currentPoints[2].y)/2)
        currentPath.append(WPBezierModel(startP: bezierStartPoint, endP: bezierEndPoint, controlP: currentPoints[1], pColor: currentPenColor, pWidth: currentPenWidth))
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.pathArray.append(currentPath)
        if currentPath.count != 0 {
            currentPath.removeAll()
        }
        self.setNeedsDisplay()
    }
}

extension WPPrintBoard {
    
    func setPenColor(color : CGColor){
        self.currentPenColor = color
    }
    
    func setPenWidth(width : CGFloat){
        self.currentPenWidth = width
    }
    
    func clearBoard() {
        self.currentPath.removeAll()
        self.pathArray.removeAll()
        self.setNeedsDisplay()
    }
    
    func revoke() {
        if pathArray.count != 0 {
            self.tempPaths.append(pathArray.last!)
            self.pathArray.removeLast()
        }
        self.setNeedsDisplay()
    }
    
    func recover() {
        if self.tempPaths.count != 0 {
            self.pathArray.append(tempPaths.last!)
            self.tempPaths.removeLast()
        }
        self.setNeedsDisplay()
    }
}
