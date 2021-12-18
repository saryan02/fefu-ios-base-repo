//
//  CollectionViewCell.swift
//  fefuactivity
//
//  Created by wsr3 on 25.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var label: UILabel!

    override var isSelected: Bool{
        didSet{
       
            layer.borderWidth = isSelected ? 2 : 1
            layer.borderColor = isSelected ? UIColor.purple.cgColor : UIColor.lightGray.cgColor
            
        }
    }
    
}



class SelectedItemCell: UICollectionViewCell {
    class var identifier: String{
        return String(describing: self)
    }
    class var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    @IBOutlet weak var deleteButton: UIButton!

    var callback : (()->Void)?

    @IBAction func deleteAction(_ sender: Any) {
        callback?()
    }
}
