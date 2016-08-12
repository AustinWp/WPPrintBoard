//
//  WPPrintSixMethod.swift
//  WPPrintBoardDemo
//
//  Created by Wupeng on 8/11/16.
//  Copyright © 2016 Wooop. All rights reserved.
//
//  这个类介绍了使用drawRect和CoreGraphics两类共六个基本的绘图方法。
//

import UIKit

class WPPrintSixMethod: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        let imageView = UIImageView(image: methodSix())
//        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func drawRect(rect: CGRect) {
//        //methodTwo()
//    }
    
//    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
//        //methodFour(ctx)
//    }
    
    func methodOne(){
        let bezierPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 100, 100))
        UIColor.redColor().setFill()
        bezierPath.fill()
    }
    
    func methodTwo(){
        let cgCtx = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(cgCtx, CGRectMake(0, 0, 100, 100))
        CGContextSetRGBFillColor(cgCtx, 100/255.0, 100/255.0, 100/255.0, 1)
        CGContextFillPath(cgCtx)
    }
    
    func methodFour(ctx : CGContext) {
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100))
        CGContextSetRGBFillColor(ctx, 100/255.0, 100/255.0, 100/255.0, 1)
        CGContextFillPath(ctx)
    }
    
    func methodFive() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), false, 0)
        let path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 200, 200))
        UIColor.redColor().setFill()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func methodSix() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100))
        CGContextSetRGBFillColor(ctx, 100/255.0, 100/255.0, 100/255.0, 1)
        CGContextFillPath(ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
