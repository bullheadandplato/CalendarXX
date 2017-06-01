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

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override class func defaultFont() -> UIFont {
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        return font
    }

}
