//
//  SignatureCell.swift
//  the-line
//
//  Created by Salah Khaled on 14/02/2024.
//

import UIKit

class SignatureCell: UITableViewCell {

    @IBOutlet weak var imageSignature: UIImageView!
    @IBOutlet weak var lblError: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSignature.isHidden = false
        lblError.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with signature: UserSignature) {
        
        if let image = signature.signatureData?.convertBase64ToImage() {
            imageSignature.image = image
        } else {
            imageSignature.isHidden = true
            lblError.isHidden = false
        }
        
    }
    
}
