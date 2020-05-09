
import UIKit

protocol Alertable {
    func showAlert(title: String, message: String, actions: [UIAlertAction]?)
}

extension Alertable where Self: UIViewController {
    func showError(error: Error) {
        let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        showAlert(title: "Error", message: error.localizedDescription, actions: [errorAction])
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        guard let actions = actions else {
            showAlertController(alertController: alert)
            return
        }
        
        for action in actions {
            alert.addAction(action)
        }
        
        showAlertController(alertController: alert)
    }
    
    private func showAlertController(alertController: UIAlertController) {
        DispatchQueue.main.async(execute: {
            self.present(alertController, animated: true)
        })
    }
}
