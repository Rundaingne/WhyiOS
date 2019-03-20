//
//  PostTableViewCell.swift
//  WhyiOS
//
//  Created by Brooke Kumpunen on 3/20/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate: class {
    func addPostButtonTapped(cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    //Landing pad and delegate stuffs.
    weak var delegate: PostTableViewCellDelegate?
    //We also need a place for the data to land so that the cell can update itself.
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    func updateViews() {
        guard let post = post else {return}
        nameLabel.text = post.name
        cohortLabel.text = post.cohort
        reasonLabel.text = post.reason
    }

}
