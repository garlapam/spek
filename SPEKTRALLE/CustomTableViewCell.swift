//
//  CustomTableViewCell.swift
//  SPEKTRALLE
//
//  Created by MounikaGarlapati on 10/8/17.
//  Copyright © 2017 MounikaGarlapati. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var bond_label: UILabel!
    @IBOutlet weak var func_label: UILabel!
    @IBOutlet weak var peak_wave_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
