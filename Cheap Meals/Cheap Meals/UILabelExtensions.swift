//
//  UILabelExtensions.swift
//  Cheap Meals
//
//  Created by Tony Nikolov on 4/5/17.
//  Copyright © 2017 Tony Nikolov. All rights reserved.
//

import UIKit

class UIUnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
