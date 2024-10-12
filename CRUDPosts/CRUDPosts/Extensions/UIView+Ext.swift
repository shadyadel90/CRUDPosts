import UIKit

extension UIView {
    private var loadingIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }

    func showLoadingIndicator() {
        let indicator = loadingIndicator
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        indicator.startAnimating()
    }

    func hideLoadingIndicator() {
        for subview in subviews where subview is UIActivityIndicatorView {
            (subview as? UIActivityIndicatorView)?.stopAnimating()
            subview.removeFromSuperview()
        }
    }
}
