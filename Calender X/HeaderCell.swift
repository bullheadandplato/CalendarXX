//
//  HeaderCell.swift
//  Calender X
//
//  Created by osama on 8/1/16.
//  Copyright © 2016 osama. All rights reserved.
//

import UIKit

class HeaderCell: CellContent {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.backgroundColor = UIColor(red: 1, green: 0.97, blue: 0.97, alpha: 1)
        label.textColor = UIColor(red: 0.4667, green: 0.533, blue: 0.6, alpha: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override class func defaultFont() -> UIFont {
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        return font
    }

}
