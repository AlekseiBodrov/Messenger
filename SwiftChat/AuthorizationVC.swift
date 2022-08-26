
import UIKit

final class AuthorizationVC: UIViewController, UITextFieldDelegate {

    let screenSize = UIScreen.main.bounds

    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.setTitle("Go Back", for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 24, y: 200, width: screenSize.width - 24 - 24, height: 60)
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        textField.delegate = self
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        [getStartedButton,
         textField].forEach {
            view.addSubview($0)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textField.endEditing(true)
    }

    @objc private func goBack() {

        dismiss(animated: true) {
            print("dissmissed AuthorizationVC")
        }
    }
}
