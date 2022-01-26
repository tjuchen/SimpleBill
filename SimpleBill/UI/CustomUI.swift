//
//  CustomUI.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/21.
//

import Foundation
import SwiftUI

struct SwitchButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 6, leading: 40, bottom: 6, trailing: 40))
            .font(.body)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(configuration.isPressed ? Color.gray:Color.blue)
            )
            
    }
}

struct MaskView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MaskView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }
    
    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<MaskView>)
    {
    }
}

extension View {
    func maskBackground() -> some View {
        ZStack {
            MaskView()
            self
        }
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct BlurEffectView: UIViewRepresentable {
    
    /// The style of the Blut Effect View
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
