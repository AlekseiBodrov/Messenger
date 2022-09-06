
import UIKit
import SwiftPhoneNumberFormatter
import M13Checkbox
import NVActivityIndicatorView

final class AuthorizationVC: UIViewController, UITextFieldDelegate {

    let screenSize = UIScreen.main.bounds

    var activityIndicator: NVActivityIndicatorView!

    private lazy var escapeButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 18, y: 80, width: 15, height: 15)
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

    private lazy var phoneTextField: PaddedPhoneTextField = {
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
        button.frame = CGRect(x: screenSize.width * 0.025, y: screenSize.height - ( screenSize.height / 6 ), width: screenSize.width - screenSize.width * 0.05, height: screenSize.height / 13)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0) , for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.addTarget(self, action: #selector(login) , for: .touchDown)

        button.setBackgroundColor(.yellow, for: .normal)
        button.setBackgroundColor(.darkGray, for: .highlighted)

        button.layer.shadowColor = UIColor.red.withAlphaComponent(0.9).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = screenSize.height / 15 / 2
        button.layer.cornerRadius = screenSize.height / 15 / 3
        button.layer.masksToBounds = true

        return button
    }()

    
    private lazy var repeatSmsButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: screenSize.width * 0.025, y: screenSize.height - ( screenSize.height / 6 ), width: screenSize.width - screenSize.width * 0.05, height: screenSize.height / 13)
        button.setTitle("Repeat SMS", for: .normal)
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0) , for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.addTarget(self, action: #selector(login) , for: .touchDown)

        button.setBackgroundColor(.yellow, for: .normal)
        button.setBackgroundColor(.darkGray, for: .highlighted)

        button.layer.shadowColor = UIColor.red.withAlphaComponent(0.9).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = screenSize.height / 15 / 2
        button.layer.cornerRadius = screenSize.height / 15 / 3
        button.layer.masksToBounds = true

        return button
    }()


    lazy var checkbox: M13Checkbox = {
        
        let checkbox = M13Checkbox(frame: CGRect(x: 47, y: Int(screenSize.height - 204), width: 24, height: Int(24)))
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




    lazy var smsConfirmationView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: screenSize.height / 11 * 2, width: screenSize.width, height: screenSize.height / 11 * 9)
        view.backgroundColor = .darkGray
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        view.isUserInteractionEnabled = false
        return view
    }()

    lazy var descriptionLable: UILabel = {
            let lbl = UILabel()
            lbl.backgroundColor = .clear
            lbl.textAlignment = .left
            lbl.textColor = .white
            lbl.numberOfLines = 2
            lbl.frame = CGRect(x: screenSize.width * 0.05, y: screenSize.height * 0.05, width: screenSize.width - screenSize.width * 0.05, height: 60)
            lbl.font = .systemFont(ofSize: 20)
            lbl.attributedText = descriptionString(color: .white)
//            lbl.alpha = 0.75
            return lbl
        }()

    lazy var codeTextFiald: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: screenSize.width * 0.05, y: 100, width: screenSize.width, height: 100)
//        textField.backgroundColor = .white.withAlphaComponent(0.1)
        textField.font = .systemFont(ofSize: 72, weight: .bold)
//        textField.attributedText = NSAttributedString(string: "2247",
//                                                      attributes: [NSAttributedString.Key.kern : 48])
        textField.tintColor = .clear
        textField.delegate = self
        textField.textColor = .clear
        textField.keyboardAppearance = .dark
        textField.keyboardType = .numberPad
        return textField
    }()

    lazy var bgView1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: screenSize.width / 5 - (screenSize.width / 25) / 2 , y: screenSize.height / 11 * 2,
                            width: screenSize.width / 25 , height: screenSize.width / 25)
        view.backgroundColor = .white.withAlphaComponent(1)
        view.layer.cornerRadius = screenSize.width / 25 / 2
        return view
    }()

    lazy var bgView2: UIView = {
        let view = UIView()
        view.frame = CGRect(x: screenSize.width / 5 * 2 - (screenSize.width / 25) / 2, y: screenSize.height / 11 * 2,
                            width: screenSize.width / 25 , height: screenSize.width / 25)
        view.backgroundColor = .white.withAlphaComponent(1)
        view.layer.cornerRadius = screenSize.width / 25 / 2
        return view
    }()

    lazy var bgView3: UIView = {
        let view = UIView()
        view.frame = CGRect(x: screenSize.width / 5 * 3 - (screenSize.width / 25) / 2, y: screenSize.height / 11 * 2,
                            width: screenSize.width / 25 , height: screenSize.width / 25)
        view.backgroundColor = .white.withAlphaComponent(1)
        view.layer.cornerRadius = screenSize.width / 25 / 2
        return view
    }()

    lazy var bgView4: UIView = {
        let view = UIView()
        view.frame = CGRect(x: screenSize.width / 5 * 4 - (screenSize.width / 25) / 2, y: screenSize.height / 11 * 2,
                            width: screenSize.width / 25 , height: screenSize.width / 25)
        view.backgroundColor = .white.withAlphaComponent(1)
        view.layer.cornerRadius = screenSize.width / 25 / 2
        return view
    }()

    
    lazy var attributedLable: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: screenSize.width * 0.05, y: screenSize.height / 3, width: screenSize.width, height: 60)
        lbl.font = .systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.text = "Повторная отправка смс\nвозможна через \(countDown)"
        return lbl
    }()

    lazy var countDown = 30 {
        didSet {
            if countDown >= 0 {
                attributedLable.text = "Повторная отправка смс\nвозможна через \(countDown)"
            } else {
                self.loginButton.setTitle("New SMS", for: .normal)
                self.view.addSubview(loginButton)
                countDown = 30
            }
        }
    }

    
    lazy var codeLabel1: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: screenSize.width / 5 - (screenSize.width / 7) / 2 , y: screenSize.height / 11 * 2 - 40,
                           width: screenSize.width / 7, height: 100)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.layer.cornerRadius = 16
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center

        return lbl
    }()

    lazy var codeLabel2: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: screenSize.width / 5 * 2 - (screenSize.width / 7) / 2, y: screenSize.height / 11 * 2 - 40,
                           width: screenSize.width / 7, height: 100)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.layer.cornerRadius = 16
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()

    lazy var codeLabel3: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: screenSize.width / 5 * 3 - (screenSize.width / 7) / 2, y: screenSize.height / 11 * 2 - 40,
                           width: screenSize.width / 7, height: 100)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.layer.cornerRadius = 16
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()

    lazy var codeLabel4: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: screenSize.width / 5 * 4 - (screenSize.width / 7) / 2, y: screenSize.height / 11 * 2 - 40,
                           width: screenSize.width / 7, height: 100)
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        lbl.layer.cornerRadius = 16
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()

    //Mark: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: (view.frame.width - screenSize.width / 15) / 2,
                                                                  y: (view.frame.height - screenSize.width / 15) / 2,
                                                                  width: screenSize.width / 15,
                                                                  height: screenSize.width / 15),
                                                    type: .ballRotateChase, color: .white, padding: 0)

        view.backgroundColor = .darkGray
        [activityIndicator,
         escapeButton,
         titleLable,
         subtitleLable,
         phoneTextField,
         loginButton,
         checkboxButton,
         checkbox,
         userAgreementLabel,
         userAgreementButton,
         smsConfirmationView].forEach {
            view.addSubview($0)
        }

        
        [descriptionLable,
         bgView1,
         bgView2,
         bgView3,
         bgView4,
         codeLabel1,
         codeLabel2,
         codeLabel3,
         codeLabel4,
        codeTextFiald,
        attributedLable,
         codeTextFiald].forEach {
        smsConfirmationView.addSubview($0)
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

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func startLoading() {
//        view.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func finishLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }

    func createTimer() {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
//            while self.countDown >= 0 {
            self.countDown -= 1
//            }
        }
//            if self.countDown == 0 {
//                break
//                // кнопка включится
//                // скроется атрибьютлейбл
//            }
        
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
        print(string)

        if let text = textField.text {
            if let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)

            print(text)
            print(range)
            print(updatedText)

                //                                           виды интерполяторов
                // Анимация
                
                let charMax = 4
                if updatedText.count <= charMax {
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                        switch updatedText.count {
                        case 0:
                            self.bgView1.backgroundColor = .white
                            self.bgView2.backgroundColor = .white
                            self.bgView3.backgroundColor = .white
                            self.bgView4.backgroundColor = .white
                            self.codeLabel1.text = ""
                            self.codeLabel2.text = ""
                            self.codeLabel3.text = ""
                            self.codeLabel4.text = ""
                        case 1:
                            self.bgView1.backgroundColor = .clear
                            self.bgView2.backgroundColor = .white
                            self.bgView3.backgroundColor = .white
                            self.bgView4.backgroundColor = .white
                            self.codeLabel1.text = updatedText[0]
                            self.codeLabel2.text = ""
                            self.codeLabel3.text = ""
                            self.codeLabel4.text = ""
                        case 2:
                            self.bgView1.backgroundColor = .clear
                            self.bgView2.backgroundColor = .clear
                            self.bgView3.backgroundColor = .white
                            self.bgView4.backgroundColor = .white
                            self.codeLabel2.text = updatedText[1]
                            self.codeLabel3.text = ""
                            self.codeLabel4.text = ""
                        case 3:
                            self.bgView1.backgroundColor = .clear
                            self.bgView2.backgroundColor = .clear
                            self.bgView3.backgroundColor = .clear
                            self.bgView4.backgroundColor = .white
                            self.codeLabel3.text = updatedText[2]
                            self.codeLabel4.text = ""
                        case 4:
                            self.bgView1.backgroundColor = .clear
                            self.bgView2.backgroundColor = .clear
                            self.bgView3.backgroundColor = .clear
                            self.bgView4.backgroundColor = .clear
                            self.codeLabel4.text = updatedText[3]
                        default:
                            break
                        }
                    }
                } else {
                    return false
                }
            }
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        textField.endEditing(true)
//        codeTextFiald.endEditing(true)

        view.endEditing(true)
    }

    func getPhoneNumber() -> String {
        if let phoneNumber = phoneTextField.phoneNumber() {
            return phoneNumber
        } else {
        return  "error"
        }
    }

    @objc private func login() {
        if checkbox.checkState == .checked {
            app.sendSMSCode(phone: getPhoneNumber()) {
                self.finishLoading()
                self.activityIndicator.removeFromSuperview()
            }
            self.view.endEditing(true)

            startLoading()

            createTimer()
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                self.smsConfirmationView.transform = .identity
                self.smsConfirmationView.isUserInteractionEnabled = true
            } completion: { _ in
            }

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

        let firstString = NSMutableAttributedString(string: "I have read and accept ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "the conditions of use ", attributes: secondAttributes)
        let secondString2 = NSAttributedString(string: "and\n", attributes: firstAttributes)
        let thirdString = NSAttributedString(string: "I authorize the processing of personal data", attributes: secondAttributes)

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

    func descriptionString(color: UIColor) -> NSAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        let secondAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]

        let firstString = NSMutableAttributedString(string: "СМС с кодом была отправлена на номер телефона ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "\(app.phone) ", attributes: secondAttributes)
        let secondString2 = NSAttributedString(string: " ", attributes: firstAttributes)

        firstString.append(secondString)
        firstString.append(secondString2)

        return firstString
    }

}
