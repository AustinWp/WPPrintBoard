//
//  WPPrintWithCtx.swift
//  WPPrintBoardDemo
//
//  Created by Wupeng on 8/11/16.
//  Copyright © 2016 Wooop. All rights reserved.
//
//  如何使用当前的上下文进行绘制
//

import UIKit

class WPPrintWithCtx: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, 100, 100)
        CGContextAddLineToPoint(ctx, 100, 19)
        CGContextSetLineWidth(ctx, 20)
        CGContextStrokePath(ctx)
        
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextMoveToPoint(ctx, 80, 25)
        CGContextAddLineToPoint(ctx, 100, 0)
        CGContextAddLineToPoint(ctx, 120, 25)
        CGContextFillPath(ctx)
        
        CGContextMoveToPoint(ctx, 100, 100)
        CGContextAddLineToPoint(ctx, 110, 90)
        CGContextAddLineToPoint(ctx, 110, 100)
        
        CGContextSetBlendMode(ctx, .Clear)
        CGContextFillPath(ctx)
    }
}
