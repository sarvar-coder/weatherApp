//
//  NsAttributedString.swift
//  Weathery
//
//  Created by Sarvar Boltaboyev on 10/02/25.
//

import Foundation
import UIKit

func makeTemprature(temp: Double) -> NSAttributedString {
 
    let attributedString = NSMutableAttributedString()
    let atr1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 70)]
    attributedString.append(NSAttributedString(string: "\(String(format: "%.2f", temp)) ° C", attributes: atr1))
    
    return attributedString
}
