//
//  TextFieldExt.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2020 Jordi Milla Catalan. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func moveCaret(to position: Int){
        if let newPosition = self.position(from: self.beginningOfDocument, offset: position) {
            self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
            self.offset(from: self.beginningOfDocument, to: newPosition)
        }
    }
    
    func setAutocompleteAttributedText(text: String, suggestion: String, suggestionColor: UIColor) {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text + suggestion)
        
        attributedString.addAttribute(.foregroundColor,
                                      value: suggestionColor,
                                      range: NSRange(location: text.count, length: suggestion.count))
        
        self.attributedText = attributedString
    }
}
