//
//  VerificationCodeItem.swift
//  VerificationCode
//
//  Created by Sun on 2018/11/9.
//  Copyright © 2018 Umbrella. All rights reserved.
//

import Foundation

class VerificationCodeItem {
    let text: String?
    let placeholderText: String?
    let isSecureEntry: Bool
    
    init(text: String?, placeholder: String?, isSecure: Bool = false) {
        self.text = text
        self.placeholderText = placeholder
        self.isSecureEntry = isSecure
    }
    
    func character(atIndex i: Int) -> Character? {
        let inputTextCount = text?.count ?? 0
        let placeholderTextLength = placeholderText?.count ?? 0
        let character: Character?
        if i < inputTextCount {
            let string = text ?? ""
            character = isSecureEntry ? "•" : string[string.index(string.startIndex, offsetBy: i)]
        }
        else if i < placeholderTextLength {
            let string = placeholderText ?? ""
            character = string[string.index(string.startIndex, offsetBy: i)]
        }
        else {
            character = nil
        }
        return character
    }
}
