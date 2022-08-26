
import UIKit

class GreetingsVC: UIViewController {

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.frame
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Started", for: .normal)
        button.addTarget(self, action: #selector(showAuth), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // backgroundView
        // 4x UIImageView
        // UIView - containeer
        // titleLable numberOfLines = 2
        // subtitleLable
        // getStartedButton
        // UIImageView

        [backgroundImageView,
         getStartedButton].forEach {
            view.addSubview($0)
        }
    }

    @objc private func showAuth() {

        let authorizationVC: AuthorizationVC = {
            let vc = AuthorizationVC()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            return vc
        }()

        present(authorizationVC, animated: true) {
            print("presented AuthorizationVC")
        }
    }

}
