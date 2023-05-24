//
//  ViewController.swift
//  PanAndPinchViewExample
//
//  Created by Türker Alan on 5.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    private var cornerView: CornerView!
    
    private let size: CGFloat = 200
    
    private var purpleViewOrigin: CGPoint!
    
    private var purpleViewCenter: CGPoint!
    
    private var cornerViewCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(purpleView)
        purpleView.frame = CGRect(x: 0, y: 0, width: size, height: size)
//        purpleView.translatesAutoresizingMaskIntoConstraints = false
        purpleView.center = view.center
        purpleViewCenter = purpleView.center
        purpleViewOrigin = purpleView.frame.origin
        setCornerView()
        cornerViewCenter = cornerView.center
        addGesture(cornerView)
        addGesture(purpleView)
    }
    
    private func setCornerView() {
        cornerView = CornerView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        cornerView.lineColor = UIColor.green
        cornerView.lineWidth = 7
        cornerView.center = view.center
        view.addSubview(cornerView)
    }
    
    private func addGesture(_ view: UIView) {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        view.addGestureRecognizer(pinchGesture)
        view.addGestureRecognizer(panGesture)
        view.isUserInteractionEnabled = true
    }
   
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        
        if gesture.state == .changed {
            let scale = gesture.scale
            gesture.view?.frame = CGRect(x: 0, y: 0,
                                      width: size * scale,
                                      height: size * scale)
            if gesture.view == purpleView {
                gesture.view?.center = purpleViewCenter
            } else {
                gesture.view?.center = cornerViewCenter
            }
            
        }

    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer) {
        let genericView = gesture.view!
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
            
        case .began, .changed:
            genericView.center = CGPoint(x: genericView.center.x + translation.x, y: genericView.center.y + translation.y)
            if genericView == purpleView {
                purpleViewCenter = genericView.center
            } else {
                cornerViewCenter = genericView.center
            }
            gesture.setTranslation(CGPoint.zero, in: view)
        case .ended:
            break
        default:
            break
        }
    }

}

