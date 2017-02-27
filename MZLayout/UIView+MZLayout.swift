//
//  UIView+MZLayout.swift
//
//  Created by 猎人 on 2016/12/17.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

typealias Constraint = (UIView, NSLayoutAttribute, NSLayoutRelation, UIView?, NSLayoutAttribute, CGFloat, CGFloat) -> UIView
typealias CGFloatClosure = (CGFloat) -> UIView

extension UIView {
    func mz_setConstraint() -> Constraint {
        return {item, attr1, relation, toItem, attr2, multiplier, constant in
            
            self.translatesAutoresizingMaskIntoConstraints = false
            let constraint = NSLayoutConstraint(item: item, attribute: attr1, relatedBy: relation, toItem: toItem, attribute: attr2, multiplier: multiplier, constant: constant)
            NSLayoutConstraint.activate([constraint])
            return self
        }
    }
}

// MARK: - 设置位置
extension UIView {
    private func setMarginAttribute(attr1: NSLayoutAttribute, toAttr: NSLayoutAttribute, toView: UIView) -> CGFloatClosure{
        return {distance in
            let temp = self.mz_setConstraint()
            return temp(self, attr1, .equal, toView, toAttr, 1, distance)
        }
    }
    
    func mz_sameAttributeWithDistance(toView: UIView, attr: NSLayoutAttribute, distance: CGFloat) -> UIView {
        let topAttibute = setMarginAttribute(attr1: attr, toAttr: attr, toView: toView)
        return topAttibute(distance)
    }
    
    /// self.top = toView.top + distance
    func mz_topToTop(toView: UIView, distance: CGFloat) -> UIView {
        return mz_sameAttributeWithDistance(toView: toView, attr: .top, distance: distance)
    }
    
    /// self.left = toView.left + distance
    func mz_leftToLeft(toView: UIView, distance: CGFloat) -> UIView {
        return mz_sameAttributeWithDistance(toView: toView, attr: .left, distance: distance)
    }
    
    /// self.bottom = toView.bottom + distance

    func mz_bottomToBottom(toView: UIView, distance: CGFloat) -> UIView {
        return mz_sameAttributeWithDistance(toView: toView, attr: .bottom, distance: -distance)
    }
    
    /// self.right = toView.right + distance
    func mz_rightToRight(toView: UIView, distance: CGFloat) -> UIView {
        return mz_sameAttributeWithDistance(toView: toView, attr: .right, distance: -distance)
    }
    
    /// self.top 到 toView.bottom 的距离为 distance
    func mz_topToBottom(toView: UIView, distance: CGFloat) -> UIView {
        let attibute = setMarginAttribute(attr1: .top, toAttr: .bottom, toView: toView)
        return attibute(distance)
    }
    
    /// self.left 到 toView.right距离为distance
    func mz_leftToRight(toView: UIView, distance: CGFloat) -> UIView {
        let attribute = setMarginAttribute(attr1: .left, toAttr: .right, toView: toView)
        return attribute(distance)
    }
    
    /// self.bottom 到 toView.top距离为distance
    func mz_bottomToTop(toView: UIView, distance: CGFloat) -> UIView {
        let attibute = setMarginAttribute(attr1: .bottom, toAttr: .top, toView: toView)
        return attibute(-distance)
    }
    
    /// self.right 到 view.left距离为distance
    func mz_rightToLeft(toView: UIView, distance: CGFloat) -> UIView {
        let attibute = setMarginAttribute(attr1: .right, toAttr: .left, toView: toView)
        return attibute(-distance)
    }
    
    /// self.top 到 superView 的距离
    func mz_topToSuperView(distance: CGFloat) -> UIView {
        return mz_topToTop(toView: superview!, distance: distance)
    }
    
    /// self.left 到 superView 的距离
    func mz_leftToSuperView(distance: CGFloat) -> UIView {
        return mz_leftToLeft(toView: superview!, distance: distance)
    }
    
    /// self.bottom 到 superView 的距离
    func mz_bottomToSuperView(distance: CGFloat) -> UIView {
        return mz_bottomToBottom(toView: superview!, distance: distance)
    }
    
    /// self.right 到 superView 的距离
    func mz_rightToSuperView(distance: CGFloat) -> UIView {
        return mz_rightToRight(toView: superview!, distance: distance)
    }
    
    /// self.frame = superView.frame
    func mz_edgesStickToSuperView() -> UIView {
        return mz_topToSuperView(distance: 0).mz_leftToSuperView(distance: 0).mz_bottomToSuperView(distance: 0).mz_rightToSuperView(distance: 0)
    }

    
    /// 设置self 到 superView 的边距
    ///
    /// - Parameters:
    ///   - a: 上边距
    ///   - b: 左边距
    ///   - c: 下边距
    ///   - d: 右边距
    /// - Returns: 返回self
    func mz_edgesToSuperView(top a: CGFloat, left b: CGFloat , bottom c: CGFloat, right d: CGFloat) -> UIView {
        return mz_topToSuperView(distance: a).mz_leftToSuperView(distance: b).mz_bottomToSuperView(distance: c).mz_rightToSuperView(distance: d)
    }
}

// MARK: - 设置大小
extension UIView {
    private func setSizeAttribute(attr: NSLayoutAttribute, toItem: UIView?, multiplier: CGFloat) -> CGFloatClosure {
        return { constant in
            let temp = self.mz_setConstraint()
            return temp(self, attr, .equal, toItem, attr, multiplier, constant)
        }
    }

    /// self.width = constant
    ///
    /// - Parameter constant: 宽
    /// - Returns: 返回self
    func mz_setWidth(constant: CGFloat) -> UIView {
        let width = setSizeAttribute(attr: .width, toItem: nil, multiplier: 1)
        return width(constant)
    }
    
    /// self.height = constant
    ///
    /// - Parameter constant: 高
    /// - Returns: 返回self
    func mz_setHeight(constant: CGFloat) -> UIView {
        let height = setSizeAttribute(attr: .height, toItem: nil, multiplier: 1)
        return height(constant)
    }
    
    
    /// self.size = CGSize(width, height)
    ///
    /// - Parameters:
    ///   - width: 宽
    ///   - height: 高
    /// - Returns: 返回self
    func mz_setSize(width: CGFloat, height: CGFloat) -> UIView {
        return mz_setWidth(constant: width).mz_setHeight(constant: height)
    }
    
    
    /// self.width = toView.width * multiplier
    ///
    /// - Parameters:
    ///   - toView: 要依赖的view
    ///   - multiplier: 倍数
    /// - Returns: 返回self
    func mz_widthToWidth(toView: UIView, multiplier: CGFloat) -> UIView {
        let temp = setSizeAttribute(attr: .width, toItem: toView, multiplier: multiplier)
        return temp(0)
    }
    
    /// self.height = toView.height * multiplier
    ///
    /// - Parameters:
    ///   - toView: 要依赖的view
    ///   - multiplier: 倍数
    /// - Returns: 返回self
    func mz_heightToHeight(toView: UIView, multiplier: CGFloat) -> UIView {
        let temp = setSizeAttribute(attr: .height, toItem: toView, multiplier: multiplier)
        return temp(0)
    }
}

// MARK: - 中心对齐
extension UIView {
    
    private func setCenterAttibute(attr: NSLayoutAttribute, toItem item: UIView) ->((CGFloat) -> UIView) {
        return {
            constant in
            let temp = self.mz_setConstraint()
            return temp(self, attr, .equal, item, attr, 1, constant)
        }
    }
    
    /// self.x = view.x + offsetX
    ///
    /// - Parameters:
    ///   - view: 要对齐的view
    ///   - offsetX: 偏移量
    /// - Returns: 返回self
    func mz_axisXToAxisX(toView view: UIView, offsetX: CGFloat) -> UIView {
        let axisX = setCenterAttibute(attr: .centerX, toItem: view)
        return axisX(offsetX)
    }
    
    /// self.y = view.y + offsetY
    ///
    /// - Parameters:
    ///   - view: 要对其的view
    ///   - offsetY: 偏移量
    /// - Returns: 返回self
    func mz_axisYToAxisY(toView view: UIView, offsetY: CGFloat) -> UIView {
        let axisX = setCenterAttibute(attr: .centerY, toItem: view)
        return axisX(offsetY)
    }
    
    /// self.x = self.superView.x + offsetX
    ///
    /// - Parameter offsetX: 偏移量
    /// - Returns: 返回self
    func mz_axisXToSuperView(offsetX: CGFloat) -> UIView {
        let axisX = setCenterAttibute(attr: .centerX, toItem: superview!)
        return axisX(offsetX)
    }
    
    /// self.y = self.superView.y + offsetY
    ///
    /// - Parameter offsetY: 偏移量
    /// - Returns: 返回self
    func mz_axisYToSuperView(offsetY: CGFloat) -> UIView {
        let axisY = setCenterAttibute(attr: .centerY, toItem: superview!)
        return axisY(offsetY)
    }

    /// self.center = super.center
    ///
    /// - Returns: 返回self
    func mz_centreToSuperView() -> UIView {
        return mz_axisXToSuperView(offsetX: 0).mz_axisYToSuperView(offsetY: 0)
    }
}
