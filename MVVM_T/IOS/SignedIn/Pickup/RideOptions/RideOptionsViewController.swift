//
//  RideOptionsViewController.swift
//  MVVM_T
//
//  Created by Hossam on 03/04/2021.
//

import UIKit
class RideOptionsViewController : NiblessViewController{
    let viewModel :  RideOptionViewModel
    init(rideOptionsViewControllerFactory : RideOptionsViewControllerFactory) {
        viewModel = rideOptionsViewControllerFactory.makeRideOptionsViewModel()
        super.init()
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
    override func loadView() {
        self.view = RideOptionsRootView(viewModel: viewModel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension RideOptionsViewController : UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
       return  HEPresenetationController(presentedViewController: presented, presenting: presenting)
    }
    
}

class HEPresenetationController : UIPresentationController {
    let blackBackgroundView = UIView()
    var presentedFrame : CGRect {
        guard let superView = self.presentingViewController.view else {return .zero}
        return PresentedViewFrame(fullFrame: superView.bounds, widthPrecetage: 0.95, heightPrecetage: 0.3)
            .addMaxHeight(200)
            .addMinHeight(180)
            .addBottomPadding(40 , safeArea: superView.safeAreaInsets.bottom)
            .getResult()
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return presentedFrame
    }
    
    override func containerViewDidLayoutSubviews() {
        self.presentedView?.frame = presentedFrame
        blackBackgroundView.frame = presentingViewController.view.bounds
    }
    
    override func presentationTransitionWillBegin() {
        blackBackgroundView.frame = presentingViewController.view.bounds
        blackBackgroundView.alpha = 0
        blackBackgroundView.backgroundColor = .black
        presentingViewController.view.addSubview(blackBackgroundView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] _ in
            self?.blackBackgroundView.alpha = 0.5
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _  in
                self?.blackBackgroundView.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] _ in
            self?.blackBackgroundView.alpha = 0
            
        }, completion: nil)
        
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.blackBackgroundView.removeFromSuperview()
        }
    }
}

protocol PresetedViewFrameBuilder {
     func addMaxHeight(_ maxHeight : CGFloat)->Self
     func addMinHeight(_ minHeight : CGFloat)->Self
     func addBottomPadding(_ bottomPadding : CGFloat , safeArea : CGFloat)->Self
    func getResult()-> CGRect
    
}


class PresentedViewFrame : PresetedViewFrameBuilder {
    

    
    private var result: CGRect = .zero
    private let fullFrame : CGRect
    private let widthPrecetage : CGFloat
    private let heightPrecetage : CGFloat
    
    init(fullFrame : CGRect , widthPrecetage : CGFloat , heightPrecetage : CGFloat) {
        self.fullFrame = fullFrame
        self.widthPrecetage = widthPrecetage
        self.heightPrecetage = heightPrecetage
        initalSets()
    }
    
    private  func initalSets(){
        var initialFrame = fullFrame
        initialFrame.size.height *= heightPrecetage
        initialFrame.size.width *= widthPrecetage
        let xOffset = (fullFrame.width * (1 - widthPrecetage)) / 2
        let yOffset = fullFrame.height - initialFrame.height
        initialFrame.origin.x += xOffset
        initialFrame.origin.y += yOffset
        result = initialFrame
    }
    
    private func updateYAxis(){
        let yOffset = fullFrame.height - result.height
        result.origin.y = yOffset
    }
    
    
    func addMaxHeight(_ maxHeight: CGFloat) -> Self {
        result.size.height = min(maxHeight, result.size.height)
        updateYAxis()
        return self
    }
    
    func addMinHeight(_ minHeight: CGFloat) -> Self {
        result.size.height = max(minHeight, result.size.height)
        updateYAxis()
      return self
    }
    
     func addBottomPadding(_ bottomPadding: CGFloat , safeArea : CGFloat = 0) -> Self {
    result.origin.y -= (bottomPadding + safeArea)
    return self
    }
    
    func getResult() -> CGRect {
       result
    }
    
    
}

protocol RideOptionsViewControllerFactory{
    func makeRideOptionsViewModel()->RideOptionViewModel
}
