//
//  WPBezierModel.swift
//  WPPrintBoardDemo
//
//  Created by Wupeng on 8/12/16.
//  Copyright © 2016 Wooop. All rights reserved.
//

import UIKit

struct WPBezierModel {
    
    var startPoint : CGPoint
    var endPoint : CGPoint
    var controlPoint : CGPoint
    var penColor : CGColor
    var penWidth : CGFloat
    
    init (startP : CGPoint, endP : CGPoint, controlP : CGPoint, pColor : CGColor, pWidth : CGFloat) {
        startPoint = startP
        endPoint = endP
        controlPoint = controlP
        penColor = pColor
        penWidth = pWidth
    }
    
}
