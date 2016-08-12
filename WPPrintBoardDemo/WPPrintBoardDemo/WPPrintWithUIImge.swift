//
//  WPPrintWithUIImge.swift
//  WPPrintBoardDemo
//
//  Created by Wupeng on 8/11/16.
//  Copyright © 2016 Wooop. All rights reserved.
//
//  如何对UIImage进行绘制操作
//

import UIKit

class WPPrintWithUIImge{
    
    func printImage() -> UIImage{
        let image = UIImage(named: "fire");
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), false, 0)
        image?.drawInRect(CGRectMake(0, 0, 200, 200))
        image?.drawInRect(CGRectMake(100, 100, 100, 100))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    
}
