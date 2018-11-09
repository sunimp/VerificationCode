//
//  VerificationCodeProtocol.swift
//  VerificationCode
//
//  Created by Sun on 2018/11/9.
//  Copyright © 2018 Umbrella. All rights reserved.
//

import Foundation

public protocol VerificationCodeProtocol: class {
    func textFieldShouldBeginEditing(_ textField: VerificationCode) -> Bool // return false to disallow editing.
    
    func textFieldDidBeginEditing(_ textField: VerificationCode) // became first responder
    
    func textFieldValueChanged(_ textField: VerificationCode) // text value changed
    
    func textFieldShouldEndEditing(_ textField: VerificationCode) -> Bool // return true to allow editing to stop and to resign first responder status at the last character entered event. NO to disallow the editing session to end
    
    func textFieldDidEndEditing(_ textField: VerificationCode) // called when VerificationCode did end editing
    
    func textFieldShouldReturn(_ textField: VerificationCode) -> Bool // called when 'return' key pressed. return false to ignore.
}

/// default
public extension VerificationCodeProtocol {
    func textFieldShouldBeginEditing(_ textField: VerificationCode) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: VerificationCode) {
        
    }
    
    func textFieldValueChanged(_ textField: VerificationCode) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: VerificationCode) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: VerificationCode) {
        
    }
    
    func textFieldShouldReturn(_ textField: VerificationCode) -> Bool {
        return true
    }
    
}
