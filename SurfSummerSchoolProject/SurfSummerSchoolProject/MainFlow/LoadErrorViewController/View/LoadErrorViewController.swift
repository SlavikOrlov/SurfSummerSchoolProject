//
//  LoadErrorViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import UIKit

class LoadErrorViewController: UIViewController {

    var reloadButtonAction: ()->Void = {}

    @IBOutlet weak var sadSmileImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBAction func reloadButton(_ sender: Any) {
        reloadButtonAction()
        self.view.alpha = 0.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sadSmileImage)
        errorMessage.text = "Не удалось загрузить ленту. Обновите экран или попробуйте позже"
    }
}
