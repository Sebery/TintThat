//
//  PCEditorVC.swift
//  TintThat
//
//  Created by Sebastian Cruz on 04/06/21.
//

import UIKit

class PCEditorVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
    }
    
    // MARK: - Custom methods
    private func initialConfiguration() {
        // Change main tab bar titles
        if let items = tabBarController?.tabBar.items {
            items[0].title = "".editor
            items[1].title = "".myPalettes
            items[2].title = "".settings
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
