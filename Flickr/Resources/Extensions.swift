//
//  Extensions.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import Foundation

extension String {
    func extractDimensions() -> (width: Int, height: Int)? {
        let pattern = #"width=\"(\d+)\" height=\"(\d+)\""#
        let regex = try? NSRegularExpression(pattern: pattern)
        
        if let match = regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            if let widthRange = Range(match.range(at: 1), in: self),
               let heightRange = Range(match.range(at: 2), in: self) {
                let width = Int(self[widthRange])
                let height = Int(self[heightRange])
                if let width = width, let height = height {
                    return (width: width, height: height)
                }
            }
        }
        return nil
}

var htmlToAttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
        return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
        print("Error converting HTML to NSAttributedString: \(error)")
        return nil
    }
}

var htmlToString: String {
    return htmlToAttributedString?.string ?? ""
}

var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    guard let date = formatter.date(from: self) else { return self }
    
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}
}

