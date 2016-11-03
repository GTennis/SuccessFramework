//
//  BaseTextField.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 30/10/16.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

import UIKit
import QuartzCore
import JVFloatLabeledTextField

class BaseTextField: JVFloatLabeledTextField, DataInputFormTextFieldProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit_()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit_()
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.commonInit_()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        
        self.commonInit_()
        return super.awakeAfter(using: aDecoder)
    }
    
    // MARK: DataInputFormTextFieldProtocol

    var isRequired: Bool = false
    var position: TextFieldPosition {
    
        get {
            
            return _position
        }
        set {
            
            _position = newValue
            
            switch (_position) {
                
            case TextFieldPosition.isSingle:
                
                self.hasTopSeparatorLine = true
                self.hasBottomSeparatorLine = true
                
                break
                
            case TextFieldPosition.isFirst:
                
                self.hasTopSeparatorLine = true
                
                break
                
            case TextFieldPosition.isMiddle:
                
                self.hasMiddleSeparatorLine = true
                
                break
                
            case TextFieldPosition.isLast:
                
                self.hasMiddleSeparatorLine = true
                self.hasBottomSeparatorLine = true
                
                break
            }
        }
    }
    
    var fieldState: TextFieldStateType {
        
        get {
            
            return _fieldState
        }
        set {
            
            _fieldState = newValue
            
            switch (_fieldState) {
                
            case TextFieldStateType.normal:
                
                self.setStyleNormal()
                break;
                
            case TextFieldStateType.missing:
                
                self.setStyleValueMissing()
                break;
            }
        }
    }
    
    func validateValue() {
        
        if (self.isRequired) {
            
            if (self.text == nil) {
                
                self.fieldState = TextFieldStateType.missing
            }
        }
    }
    
    func resetValidatedValues() {
        
        self.fieldState = TextFieldStateType.normal
    }
    
    
    // inside background color full rectangle
    var insidePadding: UIEdgeInsets {
        
        get {
            
            let extraSizeToCompensateTooSmallHeight: CGFloat = 2.0
            
            return UIEdgeInsetsMake(6 + extraSizeToCompensateTooSmallHeight, 0, 6 + extraSizeToCompensateTooSmallHeight, 0);
        }
    }
    
    // outside background color full rectangle
    var outsidePadding: UIEdgeInsets {
        
        get {
            return UIEdgeInsetsMake(5, 0, 5, 0);
        }
    }
    
    // Separators
    
    var separatorsAlreadyAdded: Bool = false
    var hasTopSeparatorLine: Bool  = false
    var hasMiddleSeparatorLine: Bool = false
    var hasBottomSeparatorLine: Bool = false
    
    // MARK: Border
    
    var borderCornerRadius: CGFloat {
        
        get {
            
            return 0.0
        }
    }
    
    var borderWidth: CGFloat {
        
        get {
            
            return 0.0
        }
    }
    
    var borderColor: UIColor {
        
        get {
            
            return kColorGrayLight1
        }
    }
    
    // MARK: Text
    
    var textBackgroundColor: UIColor {
        
        get {
            
            return UIColor.clear
        }
    }
    
    var textColor_: UIColor {
        
        get {
            
            return kColorGrayDark
        }
    }
    
    var textFont: String {
        
        get {
            
            return kFontNormal
        }
    }
    
    var textSize: CGFloat {
        
        get {
            
            return 15.0
        }
    }
    
    var textCursorColor: UIColor {
        
        get {
            
            return kColorGrayDark
        }
    }
    
    // MARK: Text offsets
    
    var textOffset: CGPoint {
        
        get {
            
            return CGPoint(x: 12.0, y: 5.0)
        }
    }
    
    var textOffsetWhileEditing: CGPoint {
        
        get {
            
            return CGPoint(x: 12.0, y: 5.0)
        }
    }
    
    var textClearButtonSizeWhileEditing: CGSize {
        
        get {
            
            return CGSize(width: 20.0, height: self.frame.size.height)
        }
    }
    
    // MARK: Placeholder
    
    var placeholderBackgroundColor: UIColor {
        
        get {
            
            return UIColor.clear
        }
    }
    
    var placeholderTextColor: UIColor {
        
        get {
            
            return kColorGrayLight1
        }
    }
    
    var placeholderTextColorWhileEditing: UIColor {
        
        get {
            
            return kColorGreen
        }
    }
    
    var placeholderTextFont: String {
        
        get {
            
            return kFontNormal
        }
    }
    
    var placeholderTextSize: CGFloat {
        
        get {
            
            return 12.0
        }
    }
    
    var placeholderTextOffsetY: CGFloat {
        
        get {
            
            return 5.0
        }
    }
    
    // Separator line
    var separatorLineOffsetY: CGFloat {
        
        get {
            
            return 12.0
        }
    }
    
    // MARK:
    // MARK: Protected
    // MARK:
    
    func commonInit_() {
        
        self.setCommonStyle()
        self.customizeFloatingLabel()
        self.setStyleNormal()
        
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        
        // Add corner radius if defined
        if (borderCornerRadius > 0) {
            
            self.layer.cornerRadius = self.borderCornerRadius
            self.layer.masksToBounds = true
        }
        
        // Add border if defined
        if (self.borderWidth > 0) {
            
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = self.borderWidth
        }
        
        self.observeStateChanges()
    }
    
    override var intrinsicContentSize: CGSize {
        
        // Height doesnt' matter because TextField is single line control
        
        let originalString: String = "Text"
        let myString: NSString = originalString as NSString
        let size: CGSize = myString.size(attributes: [NSFontAttributeName: self.font])
        
        let resultSize: CGSize = CGSize(width: size.width + self.insidePadding.left + self.insidePadding.right + self.outsidePadding.left + self.outsidePadding.right, height: size.height + self.insidePadding.top + self.insidePadding.bottom + self.outsidePadding.top + self.outsidePadding.bottom)
        
        return resultSize
    }
    
    // - (void)setPlaceholder:(NSString *)placeholder
    override var placeholder: String? {
        
        didSet {
            
            // Re'apply placeholder style
            self.setCommonStyle()
        }
    }

    override var isEnabled: Bool {
        
        didSet {
            
            self.textColor = self.isEnabled ? UIColor.darkGray : UIColor.lightGray
        }
    }
    
    override var text: String? {
        
        didSet {
            
            if text != nil {
                
                if (self.fieldState == TextFieldStateType.missing) {
                    self.fieldState = TextFieldStateType.normal
                }
            }
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        var editedBounds: CGRect = bounds
        editedBounds.origin.x += self.textOffsetWhileEditing.x
        editedBounds.origin.y += self.textOffsetWhileEditing.y
        
        // Reduce width of text field editable area if clear button is shown, in order to overlap text with clear button
        if (self.clearButtonMode != UITextFieldViewMode.never) {
            
            editedBounds.size.width -= (self.textOffsetWhileEditing.x + self.textClearButtonSizeWhileEditing.width)
        }
        
        return editedBounds;
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        var editedBounds: CGRect = bounds
        editedBounds.origin.x += self.textOffset.x
        editedBounds.origin.y += self.textOffset.y
        
        return editedBounds
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        // You can control how much to move placeholder down and right if it's too high/left
        let placeholderOriginXFix: CGFloat = self.textOffset.x
        let placeholderOriginYFix: CGFloat = self.textOffset.y
        
        var placeholderBounds: CGRect = bounds
        placeholderBounds.origin.y = self.frame.size.height / 2 - placeholderBounds.size.height / 2 + placeholderOriginYFix
        placeholderBounds.origin.x += placeholderOriginXFix
        
        return placeholderBounds
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        
        var clearButtonRect: CGRect = super.clearButtonRect(forBounds: bounds)
        clearButtonRect.origin.y = self.frame.size.height / 2 - clearButtonRect.size.height / 2
        
        return clearButtonRect
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if (!self.separatorsAlreadyAdded) {
            
            if (self.hasTopSeparatorLine) {
                
                self.addTopSeparatorLine()
            }
            
            if (self.hasMiddleSeparatorLine) {
                
                self.addMiddleSeparatorLine()
            }
            
            if (self.hasBottomSeparatorLine) {
                
                self.addBottomSeparatorLine()
            }
        }
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal var _position: TextFieldPosition = TextFieldPosition.isSingle
    internal var _fieldState: TextFieldStateType = TextFieldStateType.normal
    
    func setCommonStyle() {
        
        self.backgroundColor = self.textBackgroundColor;
        
        // Check if empty
        if (self.placeholder == nil) {
            
            // Placeholder might not be set yet, but we need some not nil value in order to apply color
            self.placeholder = " "
        }
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName:self.placeholderTextColor])
        
        self.textColor = self.textColor_
    }
    
    func customizeFloatingLabel() {
        
        self.floatingLabel.backgroundColor = self.placeholderBackgroundColor
        self.floatingLabelActiveTextColor = self.placeholderTextColorWhileEditing
        self.floatingLabelTextColor = self.placeholderTextColor;
        self.floatingLabelFont = UIFont(name: self.placeholderTextFont, size: self.textSize)
        self.floatingLabelYPadding = self.placeholderTextOffsetY
    }
    
    func addTopSeparatorLine() {
        
        // Add separator line
        let lineView: SeparatorHorizontalLineView = SeparatorHorizontalLineView.autolayoutView() as! SeparatorHorizontalLineView
        
        lineView.fitInto(containerView: self, color: nil, alignTop: true, leftOffset: 0, rightOffset: 0)
        
        self.addSubview(lineView)
    }
    
    func addMiddleSeparatorLine() {
        
        // Add separator line
        let lineView: SeparatorHorizontalLineView = SeparatorHorizontalLineView.autolayoutView() as! SeparatorHorizontalLineView
        lineView.fitInto(containerView: self, color: nil, alignTop: true, leftOffset: self.separatorLineOffsetY , rightOffset: 0)
        
        self.addSubview(lineView)
    }
    
    func addBottomSeparatorLine() {
        
        // Add separator line
        let lineView: SeparatorHorizontalLineView = SeparatorHorizontalLineView.autolayoutView() as! SeparatorHorizontalLineView
        
        lineView.fitInto(containerView: self, color: nil, alignTop: false, leftOffset: 0, rightOffset: 0)
        
        self.addSubview(lineView)
    }
    
    func observeStateChanges() {
        
        self.addTarget(self, action: #selector(BaseTextField.textChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    // MARK: Style change handling
    
    func setStyleNormal() {
        
        if (self.isEnabled) {
            
            self.textColor = self.textColor_
            
            let font: UIFont = UIFont(name: self.textFont, size: self.textSize)!
            self.font = font
            
            // Apply color for placeholder if its not nil
            
            if (self.placeholder != nil) {
                
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName:self.placeholderTextColor, NSFontAttributeName:font])
            }
        }
    }
    
    func setStyleValueMissing() {
        
        if (self.isEnabled) {
            
            self.textColor = kColorRed
            // Apply color for placeholder if its not nil
            
            if (self.placeholder != nil) {
                
                let font: UIFont = UIFont(name: self.textFont, size: self.textSize)!
                
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName:kColorRed, NSFontAttributeName:font])
            }
        }
    }

    // MARK: Change observation
    
    func textChanged(textField: UITextField) {
    
        if (self.fieldState == TextFieldStateType.missing && (textField.text != nil)) {
            
            self.fieldState = TextFieldStateType.normal
        }
    }
}
