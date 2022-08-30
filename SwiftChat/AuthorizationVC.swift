
import UIKit
import SwiftPhoneNumberFormatter
import M13Checkbox

final class AuthorizationVC: UIViewController, UITextFieldDelegate {

    let screenSize = UIScreen.main.bounds

    private lazy var escapeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 18, y: 80, width: 25, height: 25)
        button.setImage(UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()

    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: 60, width: screenSize.width, height: 60)
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.text = "Enjoy the new experience of\nchatting with global friends"
        lable.textAlignment = .center
        lable.numberOfLines = 2
        lable.textColor = .white
        return lable
    }()

    private lazy var subtitleLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: 130, width: screenSize.width, height: 20)
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.text = "  Connect people arround the world for free"
        lable.textAlignment = .center
        lable.alpha = 0.75
        lable.textColor = .white
        return lable
    }()

    private lazy var textField: PaddedPhoneTextField = {
        let textField = PaddedPhoneTextField()
        textField.frame = CGRect(x: 24, y: 200, width: screenSize.width - 24 - 24, height: 60)
        textField.layer.cornerRadius = 15
        textField.tintColor = .white
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 30, weight: .bold)

        textField.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(###) ###-##-##")
        textField.prefix = "+7 "

        textField.backgroundColor = .gray.withAlphaComponent(0.5)
        textField.keyboardAppearance = .dark
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 47, y: screenSize.height - 140 , width: screenSize.width - 47 - 47, height: 67)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)

        button.setBackgroundColor(.purple, for: .normal)
        button.setBackgroundColor(.darkPurple, for: .highlighted)

        button.layer.shadowColor = UIColor.red.withAlphaComponent(0.0).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 20
        button.layer.cornerRadius = 33
        button.layer.masksToBounds = true

        return button
    }()

    lazy var checkbox: M13Checkbox = {
        
        let checkbox = M13Checkbox(frame: CGRect(x: 47, y: Int(screenSize.height - 210), width: 24, height: Int(24)))
        checkbox.stateChangeAnimation = .bounce(.fill)
        checkbox.checkedValue = 1.0
        checkbox.uncheckedValue = 0.0
        checkbox.backgroundColor = .clear
        checkbox.tintColor = .white
        checkbox.secondaryTintColor = UIColor(red: 180/255, green: 193/255, blue: 200/255, alpha: 1.0)
        checkbox.secondaryCheckmarkTintColor = .black
        checkbox.markType = .checkmark
        checkbox.checkmarkLineWidth = 3.0
        checkbox.boxLineWidth = 1.0
        checkbox.cornerRadius = 2.0
        checkbox.boxType = .square
        return checkbox
    }()

    lazy var checkboxButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundColor(UIColor.white.withAlphaComponent(0.0), for: .normal)
        btn.frame = CGRect(x: 23, y: Int(screenSize.height - 250), width: 94, height: 100)
        btn.addTarget(self, action: #selector(lift), for: .touchUpInside) // move to controller
        return btn
    }()

    lazy var userAgreementLabel: UILabel = {
            let lbl = UILabel()
            lbl.backgroundColor = .clear
            lbl.textAlignment = .left
            lbl.textColor = .white
            lbl.numberOfLines = 2
            lbl.frame = CGRect(x: 80, y: Int(screenSize.height - 210), width: 307, height: 44)
            lbl.font = .systemFont(ofSize: 13)
            lbl.attributedText = agreementString(color: .white)
            lbl.alpha = 0.75
            return lbl
        }()

    lazy var userAgreementButton: UIButton = {
            let btn = UIButton()
            btn.backgroundColor = UIColor.red.withAlphaComponent(0.0)
            btn.layer.cornerRadius = 10
            btn.layer.masksToBounds = true
    //        btn.setBackgroundColor(UIColor.white.withAlphaComponent(0.1), for: .normal)
            btn.frame = CGRect(x: self.screenSize.width / 2 - 80, y: self.screenSize.height / 2 + 230, width: 250, height: 80)
            btn.addTarget(self, action: #selector(animateTouchDown2), for: .touchDown)
            btn.addTarget(self, action: #selector(animateRelease2), for: [.touchDragExit, .touchUpInside, .touchCancel])
            return btn
        }()

//    private lazy var loginButton: UIButton = {
//        let button = UIButton()
//        button.frame = CGRect(x: 47, y: screenSize.height - 200 , width: screenSize.width - 47 - 47, height: 67)
//        button.setTitle("Login", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
//        button.addTarget(self, action: #selector(login) , for: .touchDown)
//        button.addTarget(self, action: #selector(login), for: .touchUpInside)
//
//        button.setBackgroundColor(.purple, for: .normal)
//        button.setBackgroundColor(.darkPurple, for: .highlighted)
//
//        button.layer.shadowColor = UIColor.red.withAlphaComponent(0.9).cgColor
//        button.layer.shadowOpacity = 1
//        button.layer.shadowOffset = .zero
//        button.layer.shadowRadius = 20
//        button.layer.cornerRadius = 33
//        button.layer.masksToBounds = true
//
//        return button
//    }()

    // запросить смс код повторно


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        [escapeButton,
         titleLable,
         subtitleLable,
         textField,
         loginButton,
         checkboxButton,
         checkbox,
         userAgreementLabel,
         userAgreementButton].forEach {
            view.addSubview($0)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func goBack() {

        dismiss(animated: true) {
            print("dissmissed AuthorizationVC")
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text)
        print(range)
        print(string)
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textField.endEditing(true)
    }

    func getPhoneNumber() -> String {
        
        if let phoneNumber = textField.phoneNumber() {
            return phoneNumber
        } else {
        return  "error"
        }
    }

    @objc private func login() {
        if checkbox.checkState == .checked {
            app.sendSMSCode(phone: getPhoneNumber())
        }
    }

//    @objc func showUserAgreement() {
//        let safariViewController = SFSafariViewController(url: URL(string: "https://medium.com/@the.engineer.nowadays/what-you-need-to-be-aware-of-when-using-singleton-in-ios-mvvm-82ba61483604")!)
//        safariViewController.delegate = self
//        safariViewController.modalPresentationStyle = .automatic
//        present(safariViewController, animated: true) {
//            print("didPresentSafari")
//        }
//    }

    @objc func lift() {
//        app.vibrate()
        checkbox.toggleCheckState(true)
        print(checkbox.checkState.rawValue)
        // move to controller
//        if checkbox.checkState == .checked {
//            checkbox.toggleCheckState(true)
//            userAgreementLabel.alpha = 0.75
//            requestButton.isEnabled = false
//        } else {
//            checkbox.toggleCheckState(true)
//            userAgreementLabel.alpha = 1.0

//            if let phone = loginTextField.phoneNumber() {
//                if phone.count == 10 {
//                    requestButton.isEnabled = true
//                }
//            }
//        }
    }

    
    func agreementString(color: UIColor) -> NSAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        let secondAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, .foregroundColor: color]

        let firstString = NSMutableAttributedString(string: "Я принимаю ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "условия соглашения ", attributes: secondAttributes)
        let secondString2 = NSAttributedString(string: "и ", attributes: firstAttributes)
        let thirdString = NSAttributedString(string: "разрешаю обработку персональных данных", attributes: secondAttributes)

        firstString.append(secondString)
        firstString.append(secondString2)
        firstString.append(thirdString)
        
        return firstString
    }
    
    @objc func animateTouchDown2(sender: UIButton) {
        UIView.transition(with: self.userAgreementLabel, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.userAgreementLabel.attributedText = self.agreementString(color: .gray)
        }, completion: nil)
        
    }
    
    @objc func animateRelease2(sender: UIButton) {
        UIView.transition(with: self.userAgreementLabel, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.userAgreementLabel.attributedText = self.agreementString(color: .white)
        }, completion: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3) {
                let transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 10)
                
                self.checkbox.transform = transform
                self.checkboxButton.transform = transform
                self.loginButton.transform = transform
                self.userAgreementLabel.transform = transform
                self.userAgreementButton.transform = transform
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {

            self.checkbox.transform = .identity
            self.checkboxButton.transform = .identity
            self.loginButton.transform = .identity
            self.userAgreementLabel.transform = .identity
            self.userAgreementButton.transform = .identity
        }
    }

}

