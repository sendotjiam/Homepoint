//
//  FilterRatingViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 26/06/22.
//

import UIKit

final class FilterRatingViewCell: UITableViewCell {

    static let identifier = "FilterRatingViewCell"

    // MARK: - Outlets
    @IBOutlet weak var checkbox4Star: Checkbox!
    @IBOutlet weak var checkbox3Star: Checkbox!
    @IBOutlet weak var checkbox2Star: Checkbox!
    @IBOutlet weak var checkbox1Star: Checkbox!

    // MARK: - Variables
    var checkboxStates : [String: Bool] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkboxStates = [
            "4_star" : checkbox4Star.isChecked,
            "3_star" : checkbox3Star.isChecked,
            "2_star" : checkbox2Star.isChecked,
            "1_star" : checkbox1Star.isChecked,
        ]
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func check4StarTapped(_ sender: Any) {
        checkbox4Star.isChecked.toggle()
        checkboxStates["4_star"] = checkbox4Star.isChecked
    }
    
    @IBAction func check3StarTapped(_ sender: Any) {
        checkbox3Star.isChecked.toggle()
        checkboxStates["3_star"] = checkbox3Star.isChecked
    }
    
    @IBAction func check2StarTapped(_ sender: Any) {
        checkbox2Star.isChecked.toggle()
        checkboxStates["2_star"] = checkbox2Star.isChecked
    }
    
    @IBAction func check1StarTapped(_ sender: Any) {
        checkbox1Star.isChecked.toggle()
        checkboxStates["1_star"] = checkbox1Star.isChecked
    }
}

extension FilterRatingViewCell {
    private func setupUI() {
        selectionStyle = .none
    }
    
    class func nib() -> UINib {
        UINib(nibName: "FilterRatingViewCell", bundle: nil)
    }
}
