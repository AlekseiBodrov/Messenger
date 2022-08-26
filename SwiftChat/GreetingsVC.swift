
import UIKit

final class GreetingsVC: UIViewController {

    let screenSize = UIScreen.main.bounds

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.frame
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()

    private lazy var containerView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: screenSize.height - 360, width: screenSize.width, height: 360)
        view.backgroundColor = .white
        view.layer.cornerRadius = 55
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 47, y: 200, width: screenSize.width - 47 - 47, height: 67)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.addTarget(self, action: #selector(showAuth), for: .touchUpInside)

        button.setBackgroundColor(.purple, for: .normal)
        button.setBackgroundColor(.darkPurple, for: .highlighted)

        button.layer.shadowColor = UIColor.red.withAlphaComponent(0.9).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 20
        button.layer.cornerRadius = 33
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0 , y: screenSize.height / 3 , width: 150, height: 150)
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: screenSize.width / 2, y: screenSize.height / 3 , width: 150, height: 150)
        imageView.backgroundColor = .orange
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: screenSize.height * 2 / 3 , width: 150, height: 150)
        imageView.backgroundColor = .yellow
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: screenSize.width / 2, y: screenSize.height * 2 / 3 , width: 150, height: 150)
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // backgroundView +
        // 4x UIImageView
        // UIView - containeer
        // titleLable numberOfLines = 2
        // subtitleLable
        // getStartedButton
        // UIImageView

        [backgroundImageView,
         containerView,
         imageView1,
         imageView2,
         imageView3,
         imageView4].forEach {
            view.addSubview($0)
        }

        [getStartedButton].forEach {
                containerView.addSubview($0)
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
