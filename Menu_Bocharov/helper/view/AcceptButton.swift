import UIKit

class AcceptButton:  UIButton {

  
    override func awakeFromNib() {
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(hexString: "#3D3BFF", alpha: 1)
//                  saveDataAction.layer.cornerRadius = 15
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
