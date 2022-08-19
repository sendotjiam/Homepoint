//
//  String+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import UIKit

extension String {
    
    func getDateTimeFromTimestamp() -> String {
        let strings = self.split(separator: "T")
        let date = String(strings[0])
        let time = String(strings[1])
        return convertDate(date) + " | " + convertTime(time)
    }
    
    private func convertDate(_ date : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let d = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"
        let resultString = dateFormatter.string(from: d!)
        return resultString
    }
    
    private func convertTime(_ time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSSZ"
        let t = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "HH:mm"
        let resultString = dateFormatter.string(from: t!)
        return resultString + " WIB"
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    
    func strikethroughText(color: UIColor = .gray, range: NSRange) -> NSMutableAttributedString {
        let attributed = NSMutableAttributedString(string: self)
        attributed.addAttributes([
            NSAttributedString.Key.strikethroughStyle: 1,
            NSAttributedString.Key.strikethroughColor: color,
            NSAttributedString.Key.foregroundColor: UIColor.gray,
        ], range: range)
        return attributed
    }
    
    func hexStringToUIColor() -> UIColor {
        var cString:String = self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
