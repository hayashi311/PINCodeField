//
//  PINField.swift
//  KeyInput
//
//  Created by Ryota Hayashi on 2016/11/28.
//  Copyright © 2016年 bitflyer. All rights reserved.
//

import UIKit

class DebugLabel: UILabel {
    
    override var next: UIResponder? {
        get {
            let n = super.next
            print("label next", n)
            return n
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        print("label hitTest", hitView)
        return hitView
    }
}

@IBDesignable
class PINField: UIControl, UIKeyInput {

    var code: [Decimal] = []

    var codeLayers: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleTap))
        addGestureRecognizer(tap)
        
        (1...4).forEach {
            (i) in
            print("\(#function):\(#line)", "i = \(i)")
            let l = CAShapeLayer()
            l.path = UIBezierPath(ovalIn: CGRect(x:0, y:0, width:20, height:20)).cgPath
            l.lineWidth = 1
            l.strokeColor = UIColor.darkGray.cgColor
            l.fillColor = UIColor.clear.cgColor
            codeLayers.append(l)
            layer.addSublayer(l)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width / CGFloat(codeLayers.count)
        codeLayers.enumerated().forEach { (i, l) in
            let container = CGRect(x: CGFloat(i) * width, y: 0,
                                   width: width, height: bounds.height)
            l.frame = CGRect(x: container.minX + (container.width - 20)/2,
                             y: (container.height - 20)/2,
                             width: 20, height: 20)
        }
    }

    func handleTap() {
        becomeFirstResponder()
    }

    var hasText: Bool {
        get {
            return !code.isEmpty
        }
    }

    func insertText(_ text: String) {
        guard code.count < 4 else {
            return
        }
        guard let decimal = Decimal(string: text), decimal.isFinite else {
            return
        }
        code.append(decimal)

        if code.count == 4 {
            sendActions(for: .editingDidEnd)
            resignFirstResponder()
        } else {
            sendActions(for: .editingChanged)
        }

        update()
    }

    func deleteBackward() {
        code = Array(code.dropLast())
        update()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    var keyboardType: UIKeyboardType {
        get {
            return .decimalPad
        }
    }

    func update() {
        codeLayers.enumerated().forEach { (i, l) in
            if code.indices.contains(i) {
                l.fillColor = UIColor.darkGray.cgColor
            } else {
                l.fillColor = UIColor.clear.cgColor
            }
        }
    }
}



