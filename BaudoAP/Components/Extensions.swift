//
//  Extensions.swift
//  BaudoAP
//
//  Created by Codez Studio on 20/07/23.
//

import Foundation
import SwiftUI

struct ModalColorView: UIViewRepresentable {
    
    let color: UIColor
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = color
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct ModalColorViewModifier: ViewModifier {
    
    let color: UIColor
    
    func body(content: Content) -> some View {
        content
            .background(ModalColorView(color: color))
    }
}

extension View {
    /// Set transparent or custom color for a modal background (.screen, .fullScreenCover)
    func modalColor(_ color: UIColor = .clear) -> some View {
        self.modifier(ModalColorViewModifier(color: color))
    }
}


// FILTER ARRAY 1 solo 
//ForEach(contentviewmodel.postsAll.prefix(1).filter{$0.type == "image"}){ post in
//    NavigationLink(destination: PostCardImageDetailView(model: post), label: {
//        PostCardImage(model: post) } )
//}
