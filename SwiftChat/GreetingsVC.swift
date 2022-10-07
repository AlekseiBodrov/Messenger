
import UIKit

final class GreetingsVC: UIViewController {

    let screenSize = UIScreen.main.bounds
    let circleGrayRadius = UIScreen.main.bounds.width * 1.4
    let circleYellowRadius = UIScreen.main.bounds.width * 0.075

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.frame
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var circleGray1 : UIView = {
        let view = UIView()
        view.frame = CGRect(x: -circleGrayRadius / 2.5, y: -circleGrayRadius / 6, width: circleGrayRadius, height: circleGrayRadius)
        view.backgroundColor = .gray
        view.layer.cornerRadius = circleGrayRadius / 2
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var circleGray2 : UIView = {
        let view = UIView()
        view.frame = CGRect(x: circleGrayRadius * 0.1, y: circleGrayRadius * 0.9, width: circleGrayRadius, height: circleGrayRadius)
        view.backgroundColor = .gray
        view.layer.cornerRadius = circleGrayRadius / 2
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var containerLemon : UIView = {
        let view = UIView()
        view.frame = CGRect(x: screenSize.width * 0.05, y: screenSize.height / 8, width: circleYellowRadius * 2, height: circleYellowRadius)
        return view
    }()

    private lazy var circleYellow : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: circleYellowRadius, height: circleYellowRadius)
        view.backgroundColor = .yellow
        view.layer.cornerRadius = circleYellowRadius / 2
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var leafImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: circleYellowRadius - (circleYellowRadius * 0.2), y: -circleYellowRadius * 0.2 , width: circleYellowRadius / 3, height: circleYellowRadius / 3)
        imageView.image = UIImage(named: "leaffill")?.withTintColor(.green)
        imageView.systemLayoutSizeFitting(CGSize(width: circleYellowRadius / 3, height: circleYellowRadius / 3), withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .defaultHigh)
        return imageView
    }()

    private lazy var leaf: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: screenSize.width / 2, y: screenSize.height / 5 * 2 , width: circleYellowRadius, height: circleYellowRadius)
        imageView.image = UIImage(named: "leaffill")?.withTintColor(.green)
        return imageView
    }()

    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: screenSize.width * 0.05, y: screenSize.height / 5, width: screenSize.width, height: screenSize.height * 0.15)
        lable.font = .systemFont(ofSize: screenSize.height * 0.05, weight: .semibold)
        lable.text = "Welcome\nto Lemonade"
        lable.textColor = .white
        lable.textAlignment = .left
        lable.numberOfLines = 2
        return lable
    }()

    private lazy var subtitleLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: screenSize.width * 0.05, y: (screenSize.height / 5) + (screenSize.height * 0.15), width: screenSize.width, height: screenSize.height * 0.15)
        lable.font = .systemFont(ofSize: screenSize.height * 0.03, weight: .thin)
        lable.text = "Lead the way\nin our new\ncommunity."
        lable.textColor = .white.withAlphaComponent(0.8)
        lable.textAlignment = .left
        lable.numberOfLines = 3
        return lable
    }()

    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: screenSize.width * 0.025, y: screenSize.height - ( screenSize.height / 6 ), width: screenSize.width - screenSize.width * 0.05, height: screenSize.height / 13)
        button.setTitle("Get started!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0) , for: .normal)
        button.addTarget(self, action: #selector(touchDown) , for: .touchDown)
        button.addTarget(self, action: #selector(showAuth), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)

//        self.setBackgroundImage(imageWithColor(color: .gray), for: .default)
        button.setBackgroundColor(.yellow, for: .normal)
        button.setBackgroundColor(.darkYellow, for: .highlighted)

        button.layer.shadowColor = UIColor.red.withAlphaComponent(1).cgColor
        button.layer.shadowOpacity = -10
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = screenSize.height / 15 / 2
        button.layer.cornerRadius = screenSize.height / 15 / 3
        button.layer.masksToBounds = true

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 0.5) {
            self.circleGray1.transform = CGAffineTransform(translationX: 0, y: 4)
        }
        UIView.animate(withDuration: 0.5) {
            self.circleGray2.transform = CGAffineTransform(translationX: 0, y: 4)
        }

        [circleYellow,
         leafImage].forEach {
            containerLemon.addSubview($0)
        }

        // backgroundView +
        // 4x UIImageView +
        // UIView - containeer +
        // titleLable numberOfLines = 2 +
        // subtitleLable +
        // getStartedButton +
        // UIImageView

        // анимация выскакивает containerView
        // анимация перед переходом на новый экран

        [backgroundImageView,
         circleGray1,
         circleGray2,
         getStartedButton,
          titleLable,
          subtitleLable,
         containerLemon,
         leaf].forEach {
            view.addSubview($0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.circleGray1.transform = .identity
        }
        UIView.animate(withDuration: 0.3) {
            self.circleGray2.transform = .identity
        }
    }

    @objc func touchDown() {
        UIView.animate(withDuration: 0.2) {
            self.getStartedButton.transform = CGAffineTransform.init(scaleX: 0.98, y: 0.97)
        } completion: { _ in
        }
        UIView.animate(withDuration: 1) {
            self.circleGray1.transform = CGAffineTransform(translationX: -500, y: 0)
        }
        UIView.animate(withDuration: 1) {
            self.circleGray2.transform = CGAffineTransform(translationX: 500, y: 0)
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

    @objc private func touchUp() {

        UIView.animate(withDuration: 0.1) {
            self.getStartedButton.transform = .identity
        } completion: { _ in
        }
        UIView.animate(withDuration: 0.3) {
            self.circleGray1.transform = .identity
        }
        UIView.animate(withDuration: 0.3) {
            self.circleGray2.transform = .identity
        }
    }
}
