//
//  CustomTextField.swift
//  RoomeaseMessaging
//
//  Created by Anthony Stem on 11/3/23.
//

import SwiftUI

struct CustomMessageField: View {
    var placeholder: Text
    @Binding var inputText: String
    var editing: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if inputText.isEmpty {
                placeholder
                    .opacity(0.8)
            }
            
            TextField("", text: $inputText, onEditingChanged: editing, onCommit: commit)
        }
        .padding()
    }
}
