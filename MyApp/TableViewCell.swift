//
//  TableViewCell.swift
//  MyApp
//
//  Created by Vladimir Ratskevich on 13.08.21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLable: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var saleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
