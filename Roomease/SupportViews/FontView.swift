//
//  FontView.swift
//  Test
//
//  Created by user247737 on 10/18/23.
//

import SwiftUI

extension Font {
    static let headerFont = Font.custom("Sans-Regular", size: Font.TextStyle.largeTitle.size, relativeTo: .caption)
    static let subHeaderFont = Font.custom("Sans-Regular", size: Font.TextStyle.title.size, relativeTo: .caption)
    static let regularFont = Font.custom("Sans-Regular", size: Font.TextStyle.body.size, relativeTo: .caption)
    static let smallFont = Font.custom("Sans-Regular", size: Font.TextStyle.subheadline.size, relativeTo: .caption)
    static let largeFont = Font.custom("Sans-Regular", size: Font.TextStyle.caption2.size, relativeTo: .caption)
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        //Header
        case .largeTitle: return 45

        //Subheader
        case .title: return 29

        case .title2: return 34
        case .title3: return 24

        //Regular
        case .headline, .body: return 19

        //smallfont
        case .subheadline, .callout: return 14
        case .footnote: return 14
        case .caption: return 19

        //Largefont
        case .caption2: return 25
        @unknown default:
            return 20
        }
    }
}


struct FontView: View {
    var body: some View {
        VStack {
            Text("Hello, world!").font(.headerFont)
            Text("Hello, world!").font(.subHeaderFont)
            Text("Hello, world!").font(.regularFont)
            Text("Hello, world!").font(.smallFont)
            Text("Hello, world!").font(.largeFont)
            
            Text(RandomIdGenerator.getBase62(length: 6))
            Text(RandomIdGenerator.getBase62(length: 6))
            Text(RandomIdGenerator.getBase62(length: 6))
            Text(RandomIdGenerator.getBase62(length: 6))
            Text(RandomIdGenerator.getBase62(length: 6))

        }
    }
}


struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView()
    }
}
