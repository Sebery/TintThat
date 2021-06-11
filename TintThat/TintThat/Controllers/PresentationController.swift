//
//  PresentationController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

final class PresentationController: UIPresentationController {
    
    // MARK: - Properties
    private var fadeView: UIView!
    private let presentationType: TransitionManager.PresentationType
    
    // MARK: - Constructors
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, presentationType: TransitionManager.PresentationType) {
        self.presentationType = presentationType
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        initialSetup()
    }

    // MARK: - UIPresentationController
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView, let coordinator = presentedViewController.transitionCoordinator else {
            fadeView.backgroundColor = .fade
            return
        }
        
        // Add fadeView
        containerView.insertSubview(fadeView, at: 0)
        
        fadeView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        fadeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        fadeView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        fadeView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        coordinator.animate(alongsideTransition: { _ in
            self.fadeView.backgroundColor = .fade
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            fadeView.backgroundColor = .absence
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.fadeView.backgroundColor = .absence
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch presentationType {
        case .alert:
            return CGSize(width: parentSize.width, height: parentSize.height)
        case .sheet(_):
            return CGSize(width: parentSize.width, height: presentationType.value)
        }
        
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                            withParentContainerSize: containerView!.bounds.size)
        
        switch presentationType {
        case .alert:
            frame.origin.y = .zero
        case .sheet(_):
            frame.origin.y = containerView!.frame.height - presentationType.value
        }
        
        return frame
    }
    
}

// MARK: - Private
private extension PresentationController {
    
    func initialSetup() {
        // Setup fadeView
        let fadeView = UIView()
        fadeView.backgroundColor = .absence
        fadeView.translatesAutoresizingMaskIntoConstraints = false
        self.fadeView = fadeView
        
        if case .sheet(_) = presentationType {
            let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissController))
            fadeView.addGestureRecognizer(dismissTap)
        }
    }
    
    // MARK: - Selectors
    @objc func dismissController() {
        presentingViewController.dismiss(animated: true)
    }
    
}
