//
//  iCandy.swift
//  kba
//
//  Created by user909680 on 4/25/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

extension UITableViewCell
{
    func MakeFunky()
    {
        self.backgroundColor = UIColor.clear
        self.layer.insertSublayer(gradient(frame: self.bounds), at:0)
    }
    
    private func gradient(frame:CGRect) -> CAGradientLayer {
        var adjustedFrame = frame 
        adjustedFrame.size.width = UIScreen.main.bounds.size.width
        adjustedFrame.size.height = adjustedFrame.size.height + 10
        
        let layer = CAGradientLayer()
        layer.frame = adjustedFrame
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [
            UIColor.white.cgColor,UIColor.flatMint.cgColor]
        return layer
    }
}
