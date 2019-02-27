/** -------------------------------------------------------------
 * Copyright (C) 2017 Redken, Inc. All trade marks registered
 *
 * This file is part of Redken Style Station Mobile Project.
 *
 * Redken Style Station Mobile Project can not be copied and/or
 *
 * distributed without the express permission of Redken, Inc.
 *
 * -------------------------------------------------------------
 **/

import UIKit


protocol TipViewContent: NSObjectProtocol {
    func didOpen()
    
    func didClose()
}

class TipView : UIView
{
    
    
    private(set) var containerView: UIView?
    weak var contentView: TipViewContent?
    
    var container: UIView?
    weak var _contentView: TipViewContent?
    var tint: UIView?
    
    init() {
        super.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(320), height: CGFloat(418)))
        
        isOpaque = false
        alpha = 0
        //		self.clearsContextBeforeDrawing = YES;
        let greyColor = UIColor(white: CGFloat(0.945), alpha: CGFloat(1.0))
        let rightMargin: Float = (UI_USER_INTERFACE_IDIOM() == .pad) ? 9 : 5
        let arrow: UIImageView? = ElementFactory.arrowView(with: greyColor)
        
        container = UIView(frame: bounds)
        super.addSubview(container!)
        PViewUtils.move(container, toTopLeft: CGPoint(x: CGFloat(0), y: CGFloat(15)))
        PViewUtils.anchorView(arrow, top: 0, right: 86 - rightMargin, bottom: kMarginFlexible, left: kMarginFlexible, in: container)
        container?.addSubview(arrow!)
        let bg = UIView(frame: CGRect.zero)
        bg.backgroundColor = greyColor
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            PViewUtils.anchorView(bg, top: 6, right: 10, bottom: 20, left: 20, in: container)
            tint = UIView(frame: bounds)
            PViewUtils.anchorView(tint, top: 0, right: 0, bottom: 0, left: 0, in: self)
            super.addSubview(tint!)
            sendSubview(toBack: tint!)
            tint?.backgroundColor = UIColor.black
            tint?.alpha = 0
        }
        PViewUtils.anchorView(bg, top: 6, right: 0, bottom: 0, left: 0, in: container)
        container?.addSubview(bg)
        
    }
    override func addSubview(_ view: UIView) {
        container?.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if UI_USER_INTERFACE_IDIOM() == .pad {
            container?.frame = CGRect(x: CGFloat(20), y: CGFloat((container?.frame.origin.y)!), width: CGFloat(frame.size.width - 30), height: CGFloat(frame.size.height - 10))
        }
        else {
            container?.frame = CGRect(x: CGFloat(0), y: CGFloat((container?.frame.origin.y)!), width: CGFloat(frame.size.width), height: CGFloat(frame.size.height))
        }
    }
    
    func getContainerView() -> UIView? {
        return container
    }
    
    func show() {
        
        _contentView?.didOpen()
        
        //	self.hidden = NO;
        UIView.animate(withDuration: 0.1, animations: {() -> Void in
            self.alpha = 1.0
            self.tint?.alpha = 0.4
        })
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {() -> Void in
            PViewUtils.move(self.container, toTopLeft: CGPoint(x: CGFloat((self.container?.frame.origin.x)!), y: CGFloat(0)))
        }, completion: { _ in })
    }
    
    func hide() {
        
        _contentView?.didClose()
        
        //	self.hidden = YES;
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.alpha = 0.0
            self.tint?.alpha = 0.0
        })
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn, .beginFromCurrentState], animations: {() -> Void in
            PViewUtils.move(self.container, toTopLeft: CGPoint(x: CGFloat((self.container?.frame.origin.x)!), y: CGFloat(15)))
        }, completion: { _ in })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentView(_ contentView: InfoView) {
        _contentView = contentView as TipViewContent
        PViewUtils.anchorView(_contentView as! UIView!, top: 6, right: 0, bottom: 0, left: 0, in: container)
        container?.addSubview(contentView as UIView)
    }
    
    func getContentView() -> TipViewContent {
        return _contentView!
    }
    
    
    
    
}
