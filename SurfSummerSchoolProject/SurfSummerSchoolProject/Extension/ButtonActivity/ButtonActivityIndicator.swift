//
//  ButtonActivityIndicator.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import Foundation
import UIKit

struct ButtonActivityIndicator {
    
    var button: UIButton
    let startButtonText: String
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showDownloadButton() {
        button.setTitle("", for: .normal)
        configureActivityIndicator()
        showSpinning()
    }
    
    func hideDownloadButton() {
        button.setTitle(startButtonText, for: .normal)
        activityIndicator.startAnimating()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = ColorsExtension.lightGray
    }
    
    private func madeActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = ColorsExtension.lightGray
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenter = NSLayoutConstraint(
            item: button,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: activityIndicator,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        button.addConstraint(xCenter)
        
        let yCenter = NSLayoutConstraint(
            item: button,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: activityIndicator,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        button.addConstraint(yCenter)
    }
}
