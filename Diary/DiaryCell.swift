//
//  DiaryCell.swift
//  Diary
//
//  Created by 이선재 on 2022/07/20.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 20.0
        //self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.backgroundColor = UIColor.gray.cgColor
        //self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
