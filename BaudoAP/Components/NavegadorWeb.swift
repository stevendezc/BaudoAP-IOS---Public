//
//  NavegadorWeb.swift
//  BaudoAP
//
//  Created by Codez on 17/06/23.
//

import SwiftUI
import WebKit

struct NavegadorWeb: UIViewRepresentable {
    
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: url)!))
    }
    

}
    
