//
//  QRScannerView.swift
//  Roomease
//
//  Source: https://www.hackingwithswift.com/books/ios-swiftui/scanning-qr-codes-with-swiftui

// Get Package from: https://github.com/twostraws/CodeScanner
// Leave: Up to Next Major checked :)

import SwiftUI
import CodeScanner



struct QRScannerView: View {
    @State private var showScanner = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        showScanner = false
    }
}

#Preview {
    QRScannerView()
}
