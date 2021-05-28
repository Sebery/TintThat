//
//  PaletteFooterMainContentView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 27/05/21.
//

import UIKit

class PaletteFooterMainContentView: UIView {

    // MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customRoundCorners(withRadius: 8.0, forCorners: [.bottomLeft, .bottomRight])
    }
    
    // Custom methods
    private func initialize() {
        
    }

}
