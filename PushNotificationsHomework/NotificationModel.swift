import Foundation
import UIKit


struct NotificationModel {
    var name: String
    var text: String
    var image: UIImage
    
    init(name: String, text: String, image: UIImage) {
        self.image = image
        self.name = name
        self.text = text
    }
}
