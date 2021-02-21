//
//  CustomeTableViewCell.swift
//  EnfecTask
//
//  Created by Venkatarao Ponnapalli  on 15/02/21.
//  Copyright © 2021 Venkatarao Ponnapalli . All rights reserved.
//

import UIKit

class CustomeTableViewCell: UITableViewCell {

    @IBOutlet weak var id_lbl: UILabel!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var body_lbl: UILabel!
    
    @IBOutlet weak var favorts_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
