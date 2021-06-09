//
//  EditorFooterView.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

class EditorFooterView: UITableViewHeaderFooterView {

    // MARK: - Constructors
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Private
private extension EditorFooterView {
    
    func initialSetup() {
        // Setup main content view
        let mainContentView = EditorFooterMainContentView(frame: .zero)
        mainContentView.backgroundColor = .primaryAltLight
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainContentView)
    
        mainContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true
        mainContentView.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        
        // Setup margin view
        let marginView = UIView()
        marginView.backgroundColor = .absence
        marginView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(marginView)
        
        marginView.topAnchor.constraint(equalTo: mainContentView.bottomAnchor).isActive = true
        marginView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        marginView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        marginView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
