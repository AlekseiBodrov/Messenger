
import UIKit

final class AuthorizationVC: UIViewController {
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.setTitle("Go Back", for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        [getStartedButton].forEach {
            view.addSubview($0)
        }
    }

    @objc private func goBack() {

        dismiss(animated: true) {
            print("dissmissed AuthorizationVC")
        }
    }
}
