//
//  Button.swift
//  PaySmart
//
//  Created by Andrey Petrovskiy on 3/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class Button: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
