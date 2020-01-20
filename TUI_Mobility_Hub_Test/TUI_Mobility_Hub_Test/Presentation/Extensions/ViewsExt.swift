import UIKit

extension UIView {
    class func transitionTo(_ uiWindow: UIWindow, _ viewController: UIViewController, _ animation: UIView.AnimationOptions){
        UIView.transition(with: uiWindow, duration: 0.5, options: animation, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            uiWindow.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            
        }
    }
    class func identifier() -> String {
        return String(describing: self)
    }

    class func nib() -> UINib {
        return UINib(nibName: self.identifier(), bundle: nil)
    }
    
    func addModalAnimationToLayer(duration: Double = 0.3) {
        let animation = CATransition()
        animation.type = .reveal
        animation.subtype = .fromBottom
        animation.duration = duration
        self.layer.add(animation, forKey: nil)
    }

    func addFadeAnimationToLayer(duration: Double = 0.3) {
        let animation = CATransition()
        animation.type = CATransitionType.fade
        animation.duration = duration
        self.layer.add(animation, forKey: nil)
    }

    func setAnchorPoint(anchorPoint: CGPoint) {
        var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)

        newPoint = __CGPointApplyAffineTransform(newPoint, self.transform)
        oldPoint = __CGPointApplyAffineTransform(oldPoint, self.transform)

        var position = self.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        self.layer.position = position
        self.layer.anchorPoint = anchorPoint
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addSubviewWithAutolayout(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func insertSubviewWithAutolayout(_ view: UIView, at index: Int) {
        insertSubview(view, at: index)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc var allSubviews: [UIView] {
        get {
            let _subviews = subviews
            var resultArray = [UIView]()
            _subviews.forEach { (view) -> () in
                resultArray.append(view)
                resultArray += view.allSubviews
            }
            return resultArray
        }
    }
    
    func setIsHidden(_ hidden: Bool, animated: Bool = true) {
        let isHidden = self.isHidden
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: { [weak self] in
            if hidden && !isHidden {
                self?.isHidden = true
                self?.alpha = 0.0
            } else if !hidden && isHidden {
                self?.isHidden = false
                self?.alpha = 1.0
            }
        })
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
