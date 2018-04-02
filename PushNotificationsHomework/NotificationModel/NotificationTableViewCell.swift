//
//  NotificationTableViewCell.swift
//  PushNotificationsHomework
//
//  Created by Азат Алекбаев on 01.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationName: UILabel!
    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(with model: Notification) {
        notificationName.text = model.name
        notificationText.text = model.text
        notificationImage.image = #imageLiteral(resourceName: "hello")
    }
    
    
    
}
