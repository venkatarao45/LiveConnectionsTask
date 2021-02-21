//
//  FavoriteTableViewCell.swift
//  ConnectionsTask
//
//  Created by Venkatarao Ponnapalli  on 21/02/21.
//  Copyright © 2021 Venkatarao Ponnapalli . All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var id_lbl: UILabel!
    @IBOutlet weak var titile_lbl: UILabel!
    @IBOutlet weak var body_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
