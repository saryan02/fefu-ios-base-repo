//
//  TableViewCell.swift
//  fefuactivity
//
//  Created by wsr3 on 28.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    var model: ActivitiesTableModel?

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var disstanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var cellIndexLabel: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(#function)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func bild (_ model: ActivitiesTableModel){
        dateLabel.text = model.date
        typeLabel.text = model.type
        disstanceLabel.text = String(model.distance)
        durationLabel.text = model.duration
        
        
    }
    
    
    
}
