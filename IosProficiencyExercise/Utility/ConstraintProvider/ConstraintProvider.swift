//
//  ConstraintProvider.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 01/03/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import Foundation
import UIKit

let kMarginFlexible = .nan

enum ALIGN : Int {
    case _ABOVE
    case _ABOVE_LEFT
    case _ABOVE_RIGHT
    case _BELOW
    case _BELOW_LEFT
    case _BELOW_RIGHT
    case _LEFT //move to the left of the object (before)
    case _LEFT_TOP
    case _LEFT_BOTTOM
    case _RIGHT
    case _RIGHT_TOP
    case _RIGHT_BOTTOM
}

public class ConstraintProvider {
    
    class func move(_ view: UIView?, toCenter center: CGPoint) {
        view?.center = center
        var frame: CGRect? = view?.frame
        frame?.origin = CGPoint(x: CGFloat(roundf(Float(frame?.origin.x ?? 0.0))), y: CGFloat(roundf(Float(frame?.origin.y ?? 0.0))))
        view?.frame = frame ?? CGRect.zero
    }
    
    class func move(_ view: UIView?, toTopLeft origin: CGPoint) {
        var frame: CGRect? = view?.frame
        frame?.origin = origin
        view?.frame = frame ?? CGRect.zero
    }
    
    class func center(_ view: UIView?, within size: CGSize) {
        ConstraintProvider.move(view, toCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0))
    }
    
    class func resize(_ view: UIView?, to size: CGSize) {
        var frame: CGRect? = view?.frame
        frame?.size = size
        view?.frame = frame ?? CGRect.zero
    }
    
    class func getFlexibleMargin() -> Float {
        return kMarginFlexible
    }
    
    class func move(_ view: UIView?, toTopRight point: CGPoint) {
        self.move(view, toTopLeft: CGPoint(x: point.x - (view?.frame.size.width ?? 0.0), y: point.y))
    }
    
    class func alignView(_ view: UIView?, to referenceView: UIView?, alignment: ALIGN, offset: Float) {
        switch alignment {
        case ALIGN_ABOVE:
            ConstraintProvider.move(view, toCenter: CGPoint(x: referenceView?.center.x ?? 0.0, y: (referenceView?.center.y ?? 0.0) - (referenceView?.frame.size.height ?? 0.0) / 2 - CGFloat(offset) - (view?.frame.size.height ?? 0.0) / 2))
            break
            
        case ALIGN_ABOVE_LEFT:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: referenceView?.frame.origin.x ?? 0.0, y: (referenceView?.frame.origin.y ?? 0.0) - (view?.frame.size.height ?? 0.0) - CGFloat(offset)))
            break
            
        case ALIGN_ABOVE_RIGHT:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) + (referenceView?.frame.size.width ?? 0.0) - (view?.frame.size.width ?? 0.0), y: (referenceView?.frame.origin.y ?? 0.0) - (view?.frame.size.height ?? 0.0) - CGFloat(offset)))
            break
            
        case ALIGN_BELOW:
            ConstraintProvider.move(view, toCenter: CGPoint(x: referenceView?.center.x ?? 0.0, y: (referenceView?.center.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) / 2 + (view?.frame.size.height ?? 0.0) / 2 + CGFloat(offset)))
            break
            
        case ALIGN_BELOW_LEFT:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: referenceView?.frame.origin.x ?? 0.0, y: (referenceView?.frame.origin.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) + CGFloat(offset)))
            break
            
        case ALIGN_BELOW_RIGHT:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) + (referenceView?.frame.size.width ?? 0.0) - (view?.frame.size.width ?? 0.0), y: (referenceView?.frame.origin.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) + CGFloat(offset)))
            break
            
        case ALIGN_LEFT:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) - (view?.frame.size.width ?? 0.0) - CGFloat(offset), y: (referenceView?.frame.origin.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) / 2 - (view?.frame.size.height ?? 0.0) / 2))
            break
            
        case ALIGN_LEFT_BOTTOM:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) - (view?.frame.size.width ?? 0.0) - CGFloat(offset), y: (referenceView?.frame.origin.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) - (view?.frame.size.height ?? 0.0)))
            break
            
        case ALIGN_LEFT_TOP:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) - (view?.frame.size.width ?? 0.0) - CGFloat(offset), y: referenceView?.frame.origin.y ?? 0.0))
            break
            
        case ALIGN_RIGHT:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) + (referenceView?.frame.size.width ?? 0.0) + CGFloat(offset), y: (referenceView?.frame.origin.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) / 2 - (view?.frame.size.height ?? 0.0) / 2))
            break
            
        case ALIGN_RIGHT_BOTTOM:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) + (referenceView?.frame.size.width ?? 0.0) + CGFloat(offset), y: (referenceView?.frame.origin.y ?? 0.0) + (referenceView?.frame.size.height ?? 0.0) + (view?.frame.size.height ?? 0.0)))
            break
            
        case ALIGN_RIGHT_TOP:
            ConstraintProvider.move(view, toTopLeft: CGPoint(x: (referenceView?.frame.origin.x ?? 0.0) + (referenceView?.frame.size.width ?? 0.0) + CGFloat(offset), y: referenceView?.frame.origin.y ?? 0.0))
            break
            
        default:
            break
        }
    }
    
    class func anchorView(_ view: UIView?, top topMargin: Float, right rightMargin: Float, bottom bottomMargin: Float, left leftMargin: Float, in parentView: UIView?) {
        
        var autoresizing = UIView.AutoresizingMask(rawValue: 0)
        varvarvar frame: CGRect? = view?.frame
        if topMargin.isNaN {
            autoresizing = .flexibleTopMargin
        } else {
            frame?.origin.y = CGFloat(topMargin)
        }
        
        if bottomMargin.isNaN {
            autoresizing = UIView.AutoresizingMask(rawValue: autoresizing.rawValue | UIView.AutoresizingMask.flexibleBottomMargin.rawValue)
        } else {
            if !topMargin.isNaN {
                //top and bottom set
                autoresizing = UIView.AutoresizingMask(rawValue: autoresizing.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
                frame?.size.height = (parentView?.frame.size.height ?? 0.0) - CGFloat(topMargin) - CGFloat(bottomMargin)
            } else {
                //flexible top
                frame?.origin.y = CGFloat(roundf(Float((parentView?.frame.size.height ?? 0.0) - CGFloat(bottomMargin) - (view?.frame.size.height ?? 0.0))))
            }
        }
        
        if leftMargin.isNaN {
            autoresizing = autoresizing.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue
        } else {
            frame!.origin.x = leftMargin
        }
        
        if rightMargin.isNaN {
            autoresizing = autoresizing.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue
        } else {
            if !leftMargin.isNaN {
                //left and right set
                autoresizing = autoresizing.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue
                frame?.size.width = (parentView?.frame.size.width ?? 0.0) - CGFloat(leftMargin) - CGFloat(rightMargin)
            } else {
                //flexible left
                frame?.origin.x = roundf(Float((parentView?.frame.size.width ?? 0.0) - CGFloat(rightMargin) - (view?.frame.size.width ?? 0.0)))
            }
        }
        
        if leftMargin.isNaN && rightMargin.isNaN {
            frame?.origin.x = roundf(Float(((parentView?.frame.size.width ?? 0.0) - (view?.frame.size.width ?? 0.0)) / 2.0))
        }
        
        if topMargin.isNaN && bottomMargin.isNaN {
            frame?.origin.y = roundf(Float(((parentView?.frame.size.height ?? 0.0) - (view?.frame.size.height ?? 0.0)) / 2.0))
        }
        
        
        view?.frame = frame!
        view?.autoresizingMask = autoresizing
    }
}
