//
//
//import UIKit
//
//class ViewController1: UIViewController {
//
//    let label = UILabel()
//    let gradientLayer = CAGradientLayer()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        layout()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        gradientLayer.frame = label.bounds
//        gradientLayer.cornerRadius = label.bounds.height / 2
//    }
//}
//
//extension ViewController {
//    
//    func setup() {
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Shimmer"
//        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        label.layer.addSublayer(gradientLayer)
//        
//        let titleGroup = makeAnimationGroup()
//        titleGroup.beginTime = 0.0
//        gradientLayer.add(titleGroup, forKey: "backgroundColor")
//    }
//    
//    func layout() {
//        view.addSubview(label)
//        
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
//            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1),
//            label.heightAnchor.constraint(equalToConstant: 36),
//        ])
//    }
//    
//    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
//        let animDuration: CFTimeInterval = 1.5
//        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
//        anim1.fromValue = UIColor.gradientLightGrey.cgColor
//        anim1.toValue = UIColor.gradientDarkGrey.cgColor
//        anim1.duration = animDuration
//        anim1.beginTime = 0.0
//
//        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
//        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
//        anim2.toValue = UIColor.gradientLightGrey.cgColor
//        anim2.duration = animDuration
//        anim2.beginTime = anim1.beginTime + anim1.duration
//
//        let group = CAAnimationGroup()
//        group.animations = [anim1, anim2]
//        group.repeatCount = .greatestFiniteMagnitude
//        group.duration = anim2.beginTime + anim2.duration
//        group.isRemovedOnCompletion = false
//
//        if let previousGroup = previousGroup {
//            group.beginTime = previousGroup.beginTime + 0.33
//        }
//
//        return group
//    }
//}
//
//extension UIColor {
//
//    static var gradientDarkGrey: UIColor {
//        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
//    }
//
//    static var gradientLightGrey: UIColor {
//        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
//    }
//}
//import UIKit
//
////class ViewController: UIViewController {
//
//    let label = UILabel()
//    let gradientLayer = CAGradientLayer()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setup()
//        layout()
//        fetchData() // 데이터 로딩을 시작합니다.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        // 뷰의 크기가 결정된 후에 gradientLayer의 크기를 조정합니다.
//        gradientLayer.frame = label.bounds
//        gradientLayer.cornerRadius = label.bounds.height / 2
//    }
//    
//    func setup() {
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Loading..."
//        label.textAlignment = .center
//        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        
//        view.addSubview(label)
//        
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        gradientLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor, UIColor.white.cgColor]
//        gradientLayer.locations = [0.0, 0.5, 1.0]
//        label.layer.addSublayer(gradientLayer)
//        
//        // Shimmer 효과를 시작합니다.
//        startShimmerEffect()
//    }
//    
//    func layout() {
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: label.trailingAnchor),
//            label.heightAnchor.constraint(equalToConstant: 100) // 높이를 100으로 설정하여 라벨이 더 크게 보이도록 합니다.
//        ])
//    }
//    
//    // Shimmer 효과를 적용하는 함수입니다.
//    func startShimmerEffect() {
//        let animation = CABasicAnimation(keyPath: "locations")
//        animation.fromValue = [-1.0, -0.5, 0.0]
//        animation.toValue = [1.0, 1.5, 2.0]
//        animation.duration = 1.5
//        animation.repeatCount = .infinity
//        gradientLayer.add(animation, forKey: "shimmer")
//    }
//    
//    // Shimmer 효과를 제거하는 함수입니다.
//    func stopShimmerEffect() {
//        gradientLayer.removeAllAnimations()
//        label.layer.sublayers?.removeAll(where: { $0 == gradientLayer }) // gradientLayer를 레이어에서 제거합니다.
//    }
//    
//}
//
//
//// 네트워크 요청을 시뮬레이션하고 데이터 로딩이 완료되면 Shimmer 효과를 중단하는 함수입니다.
//func fetchData() {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // 3초 후에 데이터가 로드되었다고 가정합니다.
//        self.label.text = "Data Loaded"
//        self.stopShimmerEffect() // 데이터 로딩이 완료되면 Shimmer 효과를 중단합니다.
//    }
//}
//
