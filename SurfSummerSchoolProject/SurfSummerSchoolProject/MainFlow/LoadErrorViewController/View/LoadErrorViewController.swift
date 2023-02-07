//
//  LoadErrorViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import UIKit

final class LoadErrorViewController: UIViewController {

    // MARK: - Events

    var reloadButtonAction: () -> Void = {}

    // MARK: - IBOutlets

    @IBOutlet weak var sadSmileImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sadSmileImage)
        errorMessage.text = "Не удалось загрузить ленту. Обновите экран или попробуйте позже"
    }

}

// MARK: - Actions

extension LoadErrorViewController {

    @IBAction func reloadButton(_ sender: Any) {
        reloadButtonAction()
        self.view.alpha = 0.5
    }

}
