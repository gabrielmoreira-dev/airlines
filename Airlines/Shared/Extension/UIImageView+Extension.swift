import UIKit

extension UIImageView {
    func load(from url: String) {
        guard let url = URL(string: url) else {
            return self.backgroundColor = .gray
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { self.image = image }
                }
            } catch {
                self.backgroundColor = .gray
            }
        }
    }
}
