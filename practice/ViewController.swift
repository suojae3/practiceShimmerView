import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    let gradientLayer = CAGradientLayer()
    var fetchTask: Task<Void, Never>? // 비동기 작업을 관리하기 위한 Task 변수 선언

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        layout()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientLayer.frame = label.bounds
        gradientLayer.cornerRadius = label.bounds.height / 3
    }

    deinit {
        fetchTask?.cancel()
    }
}

extension ViewController {
    
    func setup() {
        label.text = "Shimmer"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        label.layer.addSublayer(gradientLayer)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        gradientLayer.add(titleGroup, forKey: "backgroundColor")
    }
    
    func layout() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            label.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 3),
            label.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    
    func fetchData() {
        fetchTask = Task {
            do {
                
                try await Task.sleep(nanoseconds: 10_000_000_000) // 10초 대기
                await MainActor.run {
                    self.label.text = "Data Loaded" // 메인 스레드에서 UI 업데이트
                    gradientLayer.removeAllAnimations()
                }
            } catch {
                // Task가 취소되면 여기서 catch
                await MainActor.run {
                    gradientLayer.removeAllAnimations()
                }
            }
        }
    }
}

extension UIColor {

    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 101 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
}


extension UIViewController {
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGrey.cgColor
        anim1.toValue = UIColor.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }

}
