
import UIKit

final class GreetingsVC: UIViewController {

    let screenSize = UIScreen.main.bounds

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.frame
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var backgroundFiltr: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.frame
        imageView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)
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

    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: 60, width: screenSize.width, height: 60)
        lable.font = .systemFont(ofSize: 24, weight: .bold)
        lable.text = "Enjoy the new experience of\nchatting with global friends"
        lable.textAlignment = .center
        lable.numberOfLines = 2
        return lable
    }()

    private lazy var subtitleLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: 130, width: screenSize.width, height: 20)
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.text = "  Connect people arround the world for free"
        lable.textColor = .darkGray
        lable.alpha = 0.7
        lable.textAlignment = .center
        return lable
    }()

    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 47, y: 200, width: screenSize.width - 47 - 47, height: 67)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.addTarget(self, action: #selector(touchDown) , for: .touchDown)
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

    private lazy var containerImageView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 27, y: 117,
                            width: screenSize.width - 27 - 27,
                            height: screenSize.width - 27 - 27)
        return view
    }()

    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 3 ,
                                 y: 3 ,
                                 width: containerImageView.bounds.width / 2 - 6,
                                 height: containerImageView.bounds.height / 2 - 6)
        imageView.image = UIImage(named: "imageView1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: containerImageView.bounds.width / 2 + 3,
                                 y: 3 ,
                                 width: containerImageView.bounds.width / 2 - 6,
                                 height: containerImageView.bounds.width / 2 - 6)
        imageView.image = UIImage(named: "imageView2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 3,
                                 y: containerImageView.bounds.width / 2 + 3,
                                 width: containerImageView.bounds.width / 2 - 6,
                                 height: containerImageView.bounds.width / 2 - 6)
        imageView.image = UIImage(named: "imageView3")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: containerImageView.bounds.width / 2 + 3,
                                 y: containerImageView.bounds.width / 2 + 3,
                                 width: containerImageView.bounds.width / 2 - 6,
                                 height: containerImageView.bounds.width / 2 - 6)
        imageView.image = UIImage(named: "imageView4")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // backgroundView +
        // 4x UIImageView +
        // UIView - containeer +
        // titleLable numberOfLines = 2 +
        // subtitleLable +
        // getStartedButton +
        // UIImageView

        // анимация выскакивает containerView
        // анимация перед переходом на новый экран

        [getStartedButton,
         titleLable,
         subtitleLable].forEach {
                containerView.addSubview($0)
        }

        [imageView1,
         imageView2,
         imageView3,
         imageView4].forEach {
            containerImageView.addSubview($0)
        }

        [backgroundImageView,
         backgroundFiltr,
         containerImageView,
         containerView].forEach {
            view.addSubview($0)
        }
    }

    @objc func touchDown() {
        UIView.animate(withDuration: 0.2) {
            self.getStartedButton.transform = CGAffineTransform.init(scaleX: 0.98, y: 0.97)
        } completion: { _ in
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
        UIView.animate(withDuration: 0.1) {
            self.getStartedButton.transform = .identity
        } completion: { _ in
        }
    }

}
