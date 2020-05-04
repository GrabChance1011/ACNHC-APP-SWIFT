//
//  File.swift
//  
//
//  Created by Thomas Ricouard on 03/05/2020.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    public func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
    
    func safeOnDrag(data: @escaping () -> NSItemProvider) -> AnyView {
        if #available(iOS 13.4, *) {
            return AnyView(onDrag(data))
        } else {
            return AnyView(self)
        }
    }
    
    func safeOnHover(action: @escaping (Bool) -> Void) -> AnyView {
        if #available(iOS 13.4, *) {
            return AnyView(onHover(perform: action))
        } else {
            return AnyView(self)
        }
    }
    
    func safeHoverEffect(_ type: SafeHoverEffectType = .automatic ) -> AnyView {
        if #available(iOS 13.4, *) {
            var hoverEffectType: HoverEffect
            
            switch(type) {
            case .lift:
                hoverEffectType = .lift
                
            case .highlight:
                hoverEffectType = .highlight
                
            case .automatic:
                fallthrough
                
            default:
                hoverEffectType = .automatic
            }
            
            return AnyView(hoverEffect(hoverEffectType))
        } else {
            return AnyView(self)
        }
    }
}

extension UIView {
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            rendererContext.cgContext.addPath(
            UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath)
            rendererContext.cgContext.clip()
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// These enums can be removed and safeHoverEffect converted to just hoverEffect throughout if we no longer need to support < iPadOS 13.4
enum SafeHoverEffectType {
    case automatic
    case lift
    case highlight
}

// Constant used throughout the app to add padding around text and icon buttons for improved tapability + match Apple's default hoverEffects
let hoverPadding: CGFloat = 10
