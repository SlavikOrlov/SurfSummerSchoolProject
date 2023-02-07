//
//  AllertMassage.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import UIKit

func addAlertView(
    for viewController: UIViewController,
    text: String,
    completion: @escaping (UIAlertAction) -> Void) {
    
        let alert = UIAlertController(
            title: "Внимание",
            message: text,
            preferredStyle: UIAlertController.Style.alert
        )
        
        let confirmAction = UIAlertAction(
            title: "Да, точно",
            style: UIAlertAction.Style.default,
            handler: completion
        )
        
        let cancelAction = UIAlertAction(
            title: "Нет",
            style: UIAlertAction.Style.cancel,
            handler: nil
        )
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        alert.preferredAction = confirmAction
        
        viewController.present(alert, animated: true, completion: nil)

}
