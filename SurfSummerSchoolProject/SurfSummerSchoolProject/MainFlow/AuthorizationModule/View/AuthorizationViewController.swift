//
//  AuthorizationViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 20.08.2022.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    // MARK: - Constants
    
    private let showHidePasswordButton = UIButton(type: .custom)
    
    // MARK: - IBOutlets

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var loginLine: UIView!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordLine: UIView!
    @IBOutlet private weak var loginButton: UIButton!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        enablePasswordToggle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

}

// MARK: - Private Methods

private extension AuthorizationViewController {
    
    func configureApperance() {
        self.loginTextField.placeholder = "Логин"
        self.loginTextField.backgroundColor = ColorsExtension.lightGrayForLog
        self.loginTextField.clipsToBounds = true
        self.loginTextField.layer.cornerRadius = 10
        self.loginTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.loginTextField.delegate = self
        self.loginTextField.keyboardType = .numberPad
        self.loginTextField.setLeftPaddingPoints(18)
        
        self.passwordTextField.placeholder = "Пароль"
        self.passwordTextField.backgroundColor = ColorsExtension.lightGrayForLog
        self.passwordTextField.clipsToBounds = true
        self.passwordTextField.layer.cornerRadius = 10
        self.passwordTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.passwordTextField.delegate = self
        self.passwordTextField.setLeftPaddingPoints(18)
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "Вход"
    }

    func enablePasswordToggle(){
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = ColorsExtension.clear
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: -16,
            bottom: 0,
            trailing: 0
        )
        
        showHidePasswordButton.configuration = buttonConfiguration
        showHidePasswordButton.setImage(
            ImagesExtension.passwordIsHidden,
            for: .normal
        )
        showHidePasswordButton.setImage(
            ImagesExtension.passwordIsShown,
            for: .selected
        )
        showHidePasswordButton.addTarget(
            self,
            action: #selector(togglePasswordView),
            for: .touchUpInside
        )
        passwordTextField.rightView = showHidePasswordButton
        passwordTextField.rightViewMode = .always
        showHidePasswordButton.alpha = 0.4
    }

}

// MARK: - Internal Methods

extension AuthorizationViewController {
    
    func showEmptyLoginNotification() {
        loginLine.backgroundColor = ColorsExtension.red
        let loginEmptyNotification = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: loginTextField.frame.width,
                height: 16
            )
        )
        loginEmptyNotification.textAlignment = .left
        loginEmptyNotification.text = "Поле не может быть пустым"
        loginEmptyNotification.font = .systemFont(ofSize: 12)
        loginEmptyNotification.textColor = ColorsExtension.red
        loginEmptyNotification.tag = 100
        self.view.addSubview(loginEmptyNotification)
        loginEmptyNotification.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginEmptyNotification.rightAnchor.constraint(
                equalTo: loginTextField.rightAnchor)
        ])
        NSLayoutConstraint(
            item: loginEmptyNotification,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.view,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1.0,
            constant: 32.0
        ).isActive = true
        
        NSLayoutConstraint(
            item: loginEmptyNotification,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: loginTextField,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1.0,
            constant: 8.0
        ).isActive = true
        self.view.layoutIfNeeded()
    }
    
    func showEmptyPasswordNotification() {
        passwordLine.backgroundColor = ColorsExtension.red
        let passwordEmptyNotification = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: loginTextField.frame.width,
                height: 16
            )
        )
        passwordEmptyNotification.textAlignment = .left
        passwordEmptyNotification.text = "Поле не может быть пустым"
        passwordEmptyNotification.font = .systemFont(ofSize: 12)
        passwordEmptyNotification.textColor = ColorsExtension.red
        passwordEmptyNotification.tag = 150
        self.view.addSubview(passwordEmptyNotification)
        passwordEmptyNotification.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordEmptyNotification.rightAnchor.constraint(
                equalTo: loginTextField.rightAnchor)
        ])
        NSLayoutConstraint(
            item: passwordEmptyNotification,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.view,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1.0,
            constant: 32.0
        ).isActive = true
        NSLayoutConstraint(
            item: passwordEmptyNotification,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: passwordTextField,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1.0,
            constant: 8.0
        ).isActive = true
        self.view.layoutIfNeeded()
    }
    
    func dismissEmptyFieldsNotidication() {
        loginLine.backgroundColor = ColorsExtension.lightGrayForLine
        passwordLine.backgroundColor = ColorsExtension.lightGrayForLine
        if let emptyLoginNotificationLabel = self.view.viewWithTag(100) {
            emptyLoginNotificationLabel.removeFromSuperview()
        }
        if let emptyPasswordNotificationLabel = self.view.viewWithTag(150) {
            emptyPasswordNotificationLabel.removeFromSuperview()
        }
        self.view.layoutIfNeeded()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissEmptyFieldsNotidication()
    }

}

// MARK: - Private Methods UITextField

private extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: amount,
                height: self.frame.size.height
            )
        )
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: amount,
                height: self.frame.size.height
            )
        )
        self.rightView = paddingView
        self.rightViewMode = .always
    }

}

// MARK: - UITableViewDelegate

extension AuthorizationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        if textField == loginTextField {
            textField.text = phoneMask(
                phoneNumber: fullString,
                shouldRemoveLastDigit: range.length == 1
            )
            return false
        }
        return true
    }

}

// MARK: - Actions

private extension AuthorizationViewController {
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if loginTextField.text == "" {
            showEmptyLoginNotification()
        }
        if passwordTextField.text == "" {
            showEmptyPasswordNotification()
        }
        if !(loginTextField.text == "" || passwordTextField.text == "") {
            
            guard let phoneNumber = loginTextField.text else { return }
            let phoneNumberClearedFromMask = clearPhoneNumberFromMask(
                phoneNumber: phoneNumber
            )
            guard let password = passwordTextField.text else { return }
            let credentials = AuthRequestModel(
                phone: phoneNumberClearedFromMask,
                password: password
            )
            AuthService()
                .performLoginRequestAndSaveToken(credentials: credentials) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                                let mainViewController = TabBarConfigurator().configure()
                                delegate.window?.rootViewController = mainViewController
                            }
                        }
                    case .failure (let error):
                        DispatchQueue.main.async {
                            var snackbarText = "Что-то пошло не так"
                            if let currentError = error as? SomeErrors {
                                switch currentError {
                                case .badRequest(let response):
                                    if response["message"] == "Неверный логин/пароль" {
                                        snackbarText = "Логин или пароль введен неправильно"
                                    }
                                case .notNetworkConnection:
                                    snackbarText = "Отсутствует интернет соединение"
                                default:
                                    snackbarText = "Что-то пошло не так"
                                }
                            }
                            let model = SnackbarModel(text: snackbarText)
                            let snackbar = SnackbarView(model: model)
                            guard let `self` = self else { return }
                            snackbar.showSnackBar(on: self, with: model)
                        }
                    }
                }
        }
    }

    @IBAction func ButtonActionWithoutLog(_ sender: Any) {
        loginTextField.text = "+7 (987) 654 32 19"
        passwordTextField.text = "qwerty"
    }

    @objc func togglePasswordView(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        showHidePasswordButton.isSelected.toggle()
    }

}
