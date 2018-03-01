//
//  LabelCollectionView.swift
//  DragAndDropExample
//
//  Created by Takashi Sou on 2018/03/01.
//  Copyright © 2018年 sooch. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    var number = 0 {
        
        didSet {
            numberLabel.text = "\(number)"
        }
    }
}

extension LabelCollectionViewCell: ReusableView {}
