//
//  Utilities.swift
//  Coolors
//
//  Created by Вадим Лавор on 11.08.22.
//

import Foundation
import UIKit

struct SpacingConstants {
    static let verticalObjectPadding: CGFloat = 8.0
    static let horizontalPadding: CGFloat = 24.0
    static let verticalPadding: CGFloat = 16.0
    static let oneLineObjectHeight: CGFloat = 24.0
    static let twoLineObjectHeight: CGFloat = 32
}

extension UIColor {
    convenience init(_ imaggaColor: ImageColor){
        let red = CGFloat(imaggaColor.red) / 255
        let green = CGFloat(imaggaColor.green) / 255
        let blue = CGFloat(imaggaColor.blue) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UIView {
    
    func anchor (top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, width: CGFloat? = nil, height: CGFloat? = nil){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}

