//
//  SnackbarView.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import UIKit

final class SnackbarView: UIView {
    
    // MARK: - Properties
    
    private let model: SnackbarModel
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = ColorsExtension.white
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(model: SnackbarModel) {
        self.model = model
        super.init(frame: .zero)
        addSubview(label)
        backgroundColor = ColorsExtension.red
        clipsToBounds = true
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(
            x: 16,
            y: bounds.height / 2,
            width: bounds.width - 32,
            height: bounds.height / 2
        )
    }
    
    // MARK: - Private methods
    
    private func configure() {
        label.text = model.text
    }
    
    func showSnackBar(on viewController: UIViewController, with model: SnackbarModel) {
        let snackbar = SnackbarView(model: model)
        let width = viewController.view.frame.size.width
        let height: CGFloat = viewController.view.frame.size.width/4
        let initialFrame = CGRect(
            x: 0,
            y: -height,
            width: width,
            height: height
        )
        let movedFrame = CGRect(
            x: 0,
            y: -height/2,
            width: width,
            height: height
        )
        snackbar.frame = initialFrame
        
        viewController.navigationController?.navigationBar.addSubview(snackbar)
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            animations: {
                snackbar.frame = movedFrame
            }, completion: { done in
                if done {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        UIView.animate(
                            withDuration: 0.3,
                            delay: 0,
                            animations: {
                                snackbar.frame = initialFrame
                            }, completion: { done in
                                if done {
                                    snackbar.removeFromSuperview()
                                }
                            }
                        )
                    }
                }
            }
        )
    }

}
