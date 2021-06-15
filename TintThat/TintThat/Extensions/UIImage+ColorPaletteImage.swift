//
//  UIImage+ColorPaletteImage.swift
//  TintThat
//
//  Created by Sebastian Cruz on 15/06/21.
//

import UIKit

extension UIImage {
    
    convenience init?(colors: [UIColor], width: CGFloat, cellHeight: CGFloat) {
        let mainRect = CGRect(origin: .zero, size: CGSize(width: width, height: cellHeight * CGFloat(colors.count)))
        UIGraphicsBeginImageContextWithOptions(mainRect.size, false, 0.0)
        
        for (i, color) in colors.enumerated() {
            let rect = CGRect(origin: CGPoint(x: 0.0, y: 0.0 + (cellHeight * CGFloat(i))), size: CGSize(width: width, height: cellHeight))
            color.setFill()
            UIRectFill(rect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
    
}
