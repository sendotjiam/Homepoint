//
//  OrderListViewCell.swift
//  homepoint
//
//  Created by Sendo Tjiam on 05/06/22.
//

import UIKit

final class OrderListViewCell: UITableViewCell {

    static let identifier = "OrderListViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productAmountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Data
    var data : OrderListItemCellModel? {
        didSet { configureCell() }
    }
    
    private typealias GenerateStatus = (
        status: String,
        textColor: UIColor,
        viewColor: UIColor
    )
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension OrderListViewCell {
    private func setupUI() {
        containerView.addBorder(
            width: 1,
            color: ColorCollection.blueLigthColor.value
        )
        containerView.roundedCorner(with: 8)
        containerView.dropShadow(
            with: 0.1,
            radius: 2,
            offset: CGSize(width: 0, height: 1)
        )
        productImageView.clipsToBounds = true
        productImageView.roundedCorner(with: 4)
        statusView.roundedCorner(with: 4)
        selectionStyle = .none
    }
    
    private func configureCell() {
        guard let data = data else { return }
        setupStatusView()
        dateLabel.text = data.date.getDateTimeFromTimestamp()
        productNameLabel.text = data.title
        productAmountLabel.text = "\(data.amount) Produk"
        priceLabel.text = "Rp\(data.price.separateInt(with: "."))"
        let imageUrl = URL(string: data.imageUrl)
        productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "img_placholder.small"))
    }
    
    private func setupStatusView() {
        var status : GenerateStatus = ("", .white, .white)
        switch data?.status {
        case .finished:
            status = generateStatus(
                "Selesai",
                ColorCollection.greenColor.value,
                ColorCollection.lightGreenColor.value
            )
        case .failed:
            status = generateStatus(
                "Gagal",
                ColorCollection.redColor.value,
                ColorCollection.lightRedColor.value
            )
        case .unpaid:
            status = generateStatus(
                "Belum Dibayar",
                ColorCollection.darkYellowColor.value,
                ColorCollection.creamColor.value
            )
        case .packed:
            status = generateStatus(
                "Dikemas",
                ColorCollection.maroonColor.value,
                ColorCollection.pinkColor.value
            )
        case .sent:
            status = generateStatus(
                "Dikirim",
                ColorCollection.darkGreenColor.value,
                ColorCollection.cyanColor.value
            )
        case .arrived:
            status = generateStatus(
                "Barang Sampai",
                ColorCollection.yellowColor.value,
                ColorCollection.lightYellowColor.value
            )
        case .rated:
            status = generateStatus(
                "Beri Penilaian",
                ColorCollection.purpleColor.value,
                ColorCollection.lightPurpleColor.value
            )
        case .unconfirm:
            status = generateStatus(
                "Menunggu Konfirmasi",
                ColorCollection.blueColor.value,
                ColorCollection.ligthTextColor.value
            )
        default: break
        }
        statusLabel.text = status.status
        statusLabel.textColor = status.textColor
        statusView.backgroundColor = status.viewColor
    }
    
    private func generateStatus(
        _ status : String,
        _ textColor : UIColor,
        _ viewColor : UIColor
    ) -> GenerateStatus {
        return (status, textColor, viewColor)
    }
    
    class func nib() -> UINib {
        UINib(nibName: "OrderListViewCell", bundle: nil)
    }
}
