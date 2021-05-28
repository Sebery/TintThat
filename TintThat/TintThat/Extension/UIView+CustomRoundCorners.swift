//
//  UIView+CustomRoundCorners.swift
//  TintThat
//
//  Created by Sebastian Cruz on 27/05/21.
//

import UIKit

extension UIView {
    func customRoundCorners(withRadius radius: Double, forCorners corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
