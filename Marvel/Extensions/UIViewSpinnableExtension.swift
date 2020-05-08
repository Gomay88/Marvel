
import UIKit

extension UIView: Spinnable {
    func startSpinner() {
        DispatchQueue.main.async(execute: {
            self.isUserInteractionEnabled = false
            
            let spinner = UIActivityIndicatorView()
            spinner.startAnimating()
            spinner.style = .large
            spinner.color = .black
            
            spinner.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(spinner)
            self.bringSubviewToFront(spinner)
            
            NSLayoutConstraint.activate([
                spinner.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                spinner.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
                spinner.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
                spinner.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8)
            ])
        })
    }

    func endSpinner() {
        DispatchQueue.main.async(execute: {
            self.isUserInteractionEnabled = true
            
            for view in self.subviews {
                if view is UIActivityIndicatorView{
                    view.removeFromSuperview()
                }
            }
        })
    }
}
