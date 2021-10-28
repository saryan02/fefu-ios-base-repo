//
//  TableViewCell.swift
//  fefuactivity
//
//  Created by wsr3 on 28.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellIndexLabel: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
