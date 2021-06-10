//
//  TransitionManager.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

final class TransitionManager: NSObject {
    
    // MARK: - Properties
    private var presentationTypeProp: PresentationType = .sheet(height: 0.0)
    
    var presentationType: PresentationType {
        get { presentationTypeProp }
        set { presentationTypeProp = newValue }
    }
    
    enum PresentationType {
        case sheet(height: CGFloat)
        case alert
        
        var value: CGFloat {
            switch self {
            case .sheet(let height):
                return height + UIApplication.shared.windows[0].safeAreaInsets.bottom
            case .alert:
                return 0.0
            }
        }
    }

}

// MARK: - UIViewControllerTransitioningDelegate
extension TransitionManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting, presentationType: presentationTypeProp)
    }
    
}
