import UIKit

extension UIView {

    public func aspectRatio(multiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier).isActive = true
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    public func anchorCenter(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }

    public func anchorCenterX(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }

    public func anchorCenterY(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }

    public func equalWidthToHeight() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0).isActive = true
    }
    
    public func equalHeightToWidth() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
    }
    
    public func proportionWidthToSuperView(_ multiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.widthAnchor {
            widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        }
    }
    
    public func proportionHeightToSuperView(_ multiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.heightAnchor {
            heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        }
    }
    
    public func proportionWidthAndHeightToSuperView(widthMultiplier: CGFloat, heightMultiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        proportionHeightToSuperView(heightMultiplier)
        proportionWidthToSuperView(widthMultiplier)
    }
    
    public func fillSuperview(with margins: UIEdgeInsets? = nil) {
        anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor, topConstant: margins?.top ?? 0, leftConstant: margins?.left ?? 0, bottomConstant: margins?.bottom ?? 0, rightConstant: margins?.right ?? 0)
    }
    
    public func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0, createdAnchors: (([NSLayoutConstraint]) -> Void)? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        createdAnchors?(anchors)
    }
}
