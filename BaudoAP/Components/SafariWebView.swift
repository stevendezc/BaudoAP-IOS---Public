//
//  SafariWebView.swift
//  BaudoAP
//
//  Created by Codez Studio on 9/07/23.
//
import SwiftUI
import SafariServices


struct SafariWebView: UIViewControllerRepresentable {
    let url: String
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url:URL(string: url)!)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController,context: Context) {
        
    }
}
