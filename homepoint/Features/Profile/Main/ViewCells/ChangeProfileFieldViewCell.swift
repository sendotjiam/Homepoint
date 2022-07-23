//
//  ChangeProfileFieldViewCell.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit

protocol ChangeProfileFieldDelegate : AnyObject{
    func didTap()
}

final class ChangeProfileFieldViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var changeProfileButton: UILabel!
    
    weak var delegate : ChangeProfileFieldDelegate?
    var tapHandler: (() -> Void)?
    var name: String? {
        didSet {
            if let name = name {
                nameLabel.text = name
            }
        }
    }
    
    var number: String? {
        didSet {
            if let number = number {
                numberLabel.text = number
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        changeProfileButton.addGestureRecognizer(tap)
        changeProfileButton.isUserInteractionEnabled = true
        
    }
    
    @objc func tapView() {
        delegate?.didTap()
    }
    
    class func nib() -> UINib { UINib(nibName: "ChangeProfileFieldViewCell", bundle: nil) }
}
