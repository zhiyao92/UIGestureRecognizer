//
//  ViewController.swift
//  Gesture Recognizer
//
//  Created by Kelvin on 9/7/17.
//  Copyright © 2017 Kelvin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//   MARK: UIPanGestureRecognizer - Move chicken around the screen
    @IBAction func panGesture(recognizer: UIPanGestureRecognizer) {
        let trans = recognizer.translation(in: self.view)
        recognizer.view?.center = CGPoint(x:(recognizer.view?.center.x)! + trans.x, y:(recognizer.view?.center.y)! + trans.y)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
//   MARK: UITapGestureRecognizer - Tap on the chicken to cause pop up
    @IBAction func tapGesture(recognizer : UITapGestureRecognizer) {
        if recognizer.state == .ended{
            let alert = UIAlertController(title: "Message", message: "Would you like to eat the chicken?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
//    MARK: UIRotationGestureRecognizer - Rotate the chicken
    @IBAction func rotateGesture(recognizer: UIRotationGestureRecognizer){
        var original = CGFloat()
        var last: CGFloat = 0
        
        if recognizer.state == .began {
            recognizer.rotation = last
            original = recognizer.rotation
        } else if recognizer.state == .changed {
            let new = recognizer.rotation + original
            recognizer.view?.transform = CGAffineTransform(rotationAngle: new)
        } else if recognizer.state == .ended {
            last = recognizer.rotation
        }
    }
    
//    MARK: UIPinchGestureRecognizer - Pinch to zoom in/out
    @IBAction func pinchGesture(recognizer: UIPinchGestureRecognizer){
        recognizer.view?.transform = (recognizer.view?.transform)!.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1.0
    }
    
//    MARK: UILongPressGestureRecognizer - Long Press
    @IBAction func longPressGesture(recognizer: UILongPressGestureRecognizer){
        recognizer.minimumPressDuration = 3
        let alert = UIAlertController(title: "Long Press Gesture Activated", message: "Minimum Press Duration is 3 second", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
//    MARK: UISwipeGestureRecognizer - Swipe between Images
    var index = 0
    @IBAction func swipeGesture(recognizer: UISwipeGestureRecognizer){
        var images = ["chicken","duck","bird"]
        
        if let move = recognizer as? UISwipeGestureRecognizer {
            switch move.direction {
            case UISwipeGestureRecognizerDirection.right:
                index += 1
                if index > images.count - 1 {
                    index = 0
                }
                secondImageView.image = UIImage(named: images[index])
            case UISwipeGestureRecognizerDirection.left:
                index -= 1
                if index < 0 {
                    index = images.count - 1
                }
                secondImageView.image = UIImage(named: images[index])
            default:
                break
            }
        }
    }
        
}
    

