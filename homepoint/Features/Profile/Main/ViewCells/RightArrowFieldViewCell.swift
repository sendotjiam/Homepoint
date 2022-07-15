//
//  RightArrowFieldViewCell.swift
//  homepoint
//
//  Created by Kartika on 05/06/22.
//

import UIKit

final class RightArrowFieldViewCell: UITableViewCell {
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var uiView: UIView!
    
    var tapHandler: (() -> Void)?
    var title: String? {
        didSet {
            if let title = title {
                labelView.text = title
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        uiView.addGestureRecognizer(tap)
        
    }
    
    @objc func tapView() {
        tapHandler?()
    }
    
    class func nib() -> UINib { UINib(nibName: "RightArrowFieldViewCell", bundle: nil) }
}
