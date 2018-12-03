//
//  VerificationCode.swift
//  VerificationCode
//
//  Created by Sun on 2018/11/9.
//  Copyright © 2018 Umbrella. All rights reserved.
//

import UIKit

@IBDesignable open class VerificationCode: UIControl {
    public weak var delegate: VerificationCodeProtocol?
    
    @IBInspectable public var itemWidth: CGFloat                = 40
    @IBInspectable public var itemHorizontalSpacing: CGFloat    = 10
    @IBInspectable public var underlineVerticalSpacing: CGFloat = 6
    @IBInspectable public var numel: Int                        = 4
    @IBInspectable public var underlineHeight: CGFloat          = 3
    @IBInspectable public var placeholderText: String?
    @IBInspectable public var text: String? {
        didSet {
            setup()
        }
    }
    
    @IBInspectable public var fontSize: CGFloat = 20 {
        didSet {
            font = font.withSize(fontSize)
        }
    }
    
    @IBInspectable public var textColor: UIColor                  = .black
    @IBInspectable public var placeholderColor: UIColor           = .lightGray
    @IBInspectable public var underlineColor: UIColor             = .black
    @IBInspectable public var updatedUnderlineColor: UIColor      = .lightGray
    @IBInspectable public var secureEntry: Bool                   = false
    @IBInspectable public var needToUpdateUnderlines: Bool        = true
    @IBInspectable public var codeBackgroundColor: UIColor        = .clear
    @IBInspectable public var codeBackgroundCornerRadius: CGFloat = 0
    
    public var keyboardType: UIKeyboardType                 = .numberPad
    public var keyboardAppearance: UIKeyboardAppearance     = .default
    public var autocorrectionType: UITextAutocorrectionType = .no
    public var font: UIFont                                 = .systemFont(ofSize: 20, weight: .medium)
    public var allowedCharacterSet: CharacterSet            = .alphanumerics

    private var _inputView: UIView?
    open override var inputView: UIView? {
        get {
            return _inputView
        }
        set {
            _inputView = newValue
        }
    }
    
    private var _inputAccessoryView: UIView?
    open override var inputAccessoryView: UIView? {
        get {
            return _inputAccessoryView
        }
        set {
            _inputAccessoryView = newValue
        }
    }
    
    
    public var isSecureTextEntry: Bool {
        get {
            return secureEntry
        }
        set {
            secureEntry = newValue
        }
    }
    
    private var labels: [UILabel] = []
    private var underlines: [UIView] = []
    private var backgrounds: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override open func layoutSubviews() {
        setupItems()
        super.layoutSubviews()
    }
    
    override open var canBecomeFirstResponder: Bool {
        return true
    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        delegate?.textFieldDidBeginEditing(self)
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        delegate?.textFieldDidEndEditing(self)
        return super.resignFirstResponder()
    }
    
    private func setup() {
        updateUI()
    }

    private func updateUI() {
        if needToRecreateBackgrounds() {
            recreateBackgrounds()
        }
        if needToRecreateUnderlines() {
            recreateUnderlines()
        }
        if needToRecreateLabels() {
            recreateLabels()
        }
        updateLabels()
        
        if needToUpdateUnderlines {
            updateUnderlines()
        }
        updateBackgrounds()
        setNeedsLayout()
    }
    
    private func needToRecreateUnderlines() -> Bool {
        return numel != underlines.count
    }
    
    private func needToRecreateLabels() -> Bool {
        return numel != labels.count
    }
    
    private func needToRecreateBackgrounds() -> Bool {
        return numel != backgrounds.count
    }
    
    private func recreateUnderlines() {
        underlines.forEach{ $0.removeFromSuperview() }
        underlines.removeAll()
        numel.times {
            let underline = createUnderline()
            underlines.append(underline)
            addSubview(underline)
        }
    }
    
    private func recreateLabels() {
        labels.forEach{ $0.removeFromSuperview() }
        labels.removeAll()
        numel.times {
            let label = createLabel()
            labels.append(label)
            addSubview(label)
        }
    }
    
    private func recreateBackgrounds() {
        backgrounds.forEach{ $0.removeFromSuperview() }
        backgrounds.removeAll()
        numel.times {
            let background = createBackground()
            backgrounds.append(background)
            addSubview(background)
        }
    }
    
    private func updateLabels() {
        let item = VerificationCodeItem(text: text, placeholder: placeholderText, isSecure: isSecureTextEntry)
        for label in labels {
            let index         = labels.index(of: label) ?? 0
            let currentItem   = item.character(atIndex: index)
            label.text        = currentItem.map { String($0) }
            label.font        = font
            let isplaceholder = isPlaceholder(index)
            label.textColor   = labelColor(isPlaceholder: isplaceholder)
        }
    }
    
    private func updateUnderlines() {
        for label in labels {
            let index = labels.index(of: label) ?? 0
            if isPlaceholder(index) {
                underlines[index].backgroundColor = underlineColor
            }
            else{
                underlines[index].backgroundColor = updatedUnderlineColor
            }
        }
    }
    
    private func updateBackgrounds() {
        for background in backgrounds {
            background.backgroundColor    = codeBackgroundColor
            background.layer.cornerRadius = codeBackgroundCornerRadius
        }
    }
    
    private func labelColor(isPlaceholder placeholder: Bool) -> UIColor {
        return placeholder ? placeholderColor : textColor
    }
    
    private func isPlaceholder(_ i: Int) -> Bool {
        let inputTextCount = text?.count ?? 0
        return i >= inputTextCount
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel(frame: CGRect())
        label.font = font
        label.backgroundColor = .clear
        label.textAlignment   = .center
        return label
    }
    
    private func createUnderline() -> UIView {
        let underline             = UIView()
        underline.backgroundColor = underlineColor
        return underline
    }
    
    private func createBackground() -> UIView {
        let background                = UIView()
        background.backgroundColor    = codeBackgroundColor
        background.layer.cornerRadius = codeBackgroundCornerRadius
        background.clipsToBounds      = true
        return background
    }
    
    private func setupItems() {
        let marginsCount         = numel - 1
        let totalMarginsWidth    = itemHorizontalSpacing * CGFloat(marginsCount)
        let totalUnderlinesWidth = itemWidth * CGFloat(numel)
        
        var currentUnderlineX: CGFloat = bounds.width / 2 - (totalUnderlinesWidth + totalMarginsWidth) / 2
        var currentLabelCenterX = currentUnderlineX + itemWidth / 2
        
        let totalLabelHeight = font.ascender + font.descender
        let underlineY = bounds.height / 2 + totalLabelHeight / 2 + underlineVerticalSpacing
        
        for i in 0..<underlines.count {
            let underline = underlines[i]
            let background = backgrounds[i]
            underline.frame = CGRect(x: currentUnderlineX, y: underlineY, width: itemWidth, height: underlineHeight)
            background.frame = CGRect(x: currentUnderlineX, y: 0, width: itemWidth, height: bounds.height)
            currentUnderlineX += itemWidth + itemHorizontalSpacing
        }
        
        labels.forEach {
            $0.sizeToFit()
            let labelWidth = $0.bounds.width
            let labelX = (currentLabelCenterX - labelWidth / 2).rounded(.down)
            $0.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: bounds.height)
            currentLabelCenterX += itemWidth + itemHorizontalSpacing
        }
        
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        if (bounds.contains(location)) {
            if (delegate?.textFieldShouldBeginEditing(self) ?? true) {
                let _ = becomeFirstResponder()
            }
        }
    }
    
    func canInsertCharacter(_ character: String) -> Bool {
        let newText = text.map { $0 + character } ?? character
        let isNewline = character.hasOnlyNewlineSymbols
        let isCharacterMatchingCharacterSet = character.trimmingCharacters(in: allowedCharacterSet).isEmpty
        let isLengthWithinLimit = newText.count <= numel
        return !isNewline && isCharacterMatchingCharacterSet && isLengthWithinLimit
    }
}


extension VerificationCode: UIKeyInput {
    public var hasText: Bool {
        if let text = text {
            return !text.isEmpty
        }
        else {
            return false
        }
    }
    
    public func insertText(_ charToInsert: String) {
        if charToInsert.hasOnlyNewlineSymbols {
            if (delegate?.textFieldShouldReturn(self) ?? true) {
                let _ = resignFirstResponder()
            }
        }
        else if canInsertCharacter(charToInsert) {
            let newText = text.map { $0 + charToInsert } ?? charToInsert
            text = newText
            delegate?.textFieldValueChanged(self)
            if (newText.count == numel) {
                if (delegate?.textFieldShouldEndEditing(self) ?? true) {
                    let _ = resignFirstResponder()
                }
            }
        }
    }
    
    public func deleteBackward() {
        guard hasText else { return }
        text?.removeLast()
        delegate?.textFieldValueChanged(self)
    }
}

extension Int {
    func times(f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
    
    func times( f: @autoclosure () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

extension String {
    var hasOnlyNewlineSymbols: Bool {
        return trimmingCharacters(in: CharacterSet.newlines).isEmpty
    }
}
