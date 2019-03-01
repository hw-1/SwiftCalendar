//
//  Extensions.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 9/28/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

extension UIColor {
    /// 颜色
    ///
    /// - Parameters:
    ///   - hex: 16进制颜色
    ///   - alpha: 透明度
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((hex & 0x0000FF) >> 0) / 255.0,
            alpha: alpha
        )
    }
}

extension UIView {
    /// 圆角
    ///
    /// - Parameters:
    ///   - corners: 角
    ///   - radius: 半径
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIResponder {
    /// 事件分发
    ///
    /// - Parameters:
    ///   - eventName: 事件名
    ///   - userInfo: 信息
    @objc public func routerWithEventName(eventName: String, userInfo: NSDictionary) {
        next?.routerWithEventName(eventName: eventName, userInfo: userInfo)
    }
}


extension UIView {
    /// 动画
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        layer.add(rotation, forKey: "rotationAnimation")
    }
}
