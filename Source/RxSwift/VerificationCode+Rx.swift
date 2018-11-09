//
//  VerificationCode+Rx.swift
//  VerificationCode
//
//  Created by Sun on 2018/11/9.
//  Copyright © 2018 Umbrella. All rights reserved.
//

import UIKit
#if canImport(RxCocoa)
import RxSwift
import RxCocoa

public extension Reactive where Base: VerificationCode {
    
    /// Reactive wrapper for `code` property.
    public var text : ControlProperty<String?> {
        return controlProperty(editingEvents: [.allEditingEvents, .valueChanged],
                               getter: { codeView in
                                codeView.text
        }, setter: { codeView, value in
            codeView.text = value
        })
    }
}
#endif
