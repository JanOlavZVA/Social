//
//  CommentTableViewCell.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 29.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//

import UIKit
import KILabel
import SDWebImage

protocol CommentTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
}

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: KILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var delegate: CommentTableViewCellDelegate?
    var comment: Comment? { didSet { updateView() }
    }
    var user: UserModel? { didSet { setupUserInfo() }
    }
    
    func updateView() {
        commentLabel.text = comment?.commentText
        commentLabel.userHandleLinkTapHandler = {
            label, handle, rang in
            var mention = handle
            mention = String(mention.characters.dropFirst())
            Api.User.observeUserByUsername(username: mention.lowercased(), completion: { (user) in
                self.delegate?.goToProfileUserVC(userId: user.id!)
            })
        }
    }
    func setupUserInfo() {
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImageUrl {
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        commentLabel.text = ""
        let tapGestureForNameLabel = UITapGestureRecognizer(target: self, action: #selector(self.nameLabel_TouchUpInside))
        nameLabel.addGestureRecognizer(tapGestureForNameLabel)
        nameLabel.isUserInteractionEnabled = true
    }
    
    @objc func nameLabel_TouchUpInside() {
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholderImg")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
}
