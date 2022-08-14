import UIKit

extension UIImageView {
    func load(from url: String) {
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            catch {
            }
        }
    }
}
