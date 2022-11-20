//
//  UserTableViewCell.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 20/11/22.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWithItem(item: Item?) {
        guard let owner = item?.owner else { return }
        self.label.text = owner.displayName
        self.userImageView.kf.indicatorType = .activity
        guard let urlStr = owner.profileImage, let url = URL(string: urlStr) else { return }
        self.userImageView.kf.setImage(with: url)
    }
}
