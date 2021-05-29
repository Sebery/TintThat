//
//  PaletteFooterView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 27/05/21.
//

import UIKit

class PaletteFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    private weak var mainContentView: PaletteFooterMainContentView!
    private weak var marginView: UIView!
    var section: Int?
    var deleteSectionAction: ((_: Int) -> Void)?

    // MARK: - Constructors
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    // MARK: - Custom methods
    private func initialize() {
        contentView.backgroundColor = .clear
        
        // Configure main content view
        let mainContentView = PaletteFooterMainContentView(frame: .zero)
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        mainContentView.backgroundColor = .lightGray
        contentView.addSubview(mainContentView)
        
        mainContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true
        mainContentView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        self.mainContentView = mainContentView
        
        // Configure margin view
        let marginView = UIView()
        marginView.translatesAutoresizingMaskIntoConstraints = false
        marginView.backgroundColor = .white
        contentView.addSubview(marginView)
        
        marginView.topAnchor.constraint(equalTo: self.mainContentView.bottomAnchor).isActive = true
        marginView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        marginView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        marginView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        self.marginView = marginView
        
        mainContentView.deleteSectionBtn.addTarget(self, action: #selector(deleteSection), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func deleteSection() {
        if let section = section, let deleteSectionAction = deleteSectionAction  {
            deleteSectionAction(section)
        }
    }

}
