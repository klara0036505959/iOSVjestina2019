//
//  QuizTitleTableViewCell.swift
//  QuizGame
//
//  Created by Five Admin on 5/6/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

class QuizTitleTableViewCell:UITableViewCell {

    @IBOutlet weak var quizLevelLabelCell: UILabel!
    @IBOutlet weak var quizDescLabelCell: UILabel!
    @IBOutlet weak var quizTitleLabelCell: UILabel!
    @IBOutlet weak var quizCellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
