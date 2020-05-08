
import UIKit

protocol Spinnable {
    func startSpinner()
    func endSpinner()
}

extension Spinnable where Self: UIViewController {
    internal var wrapperView: UIView {
        guard let app = UIApplication.shared.delegate, let window = app.window else {
            return view
        }
        return window!
    }
    
    func startSpinner() {
        DispatchQueue.main.async(execute: {
            self.wrapperView.startSpinner()
        })
    }
    
    func endSpinner() {
        DispatchQueue.main.async(execute: {
            self.wrapperView.endSpinner()
        })
    }
}
