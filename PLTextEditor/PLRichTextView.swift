//
//  PLRichTextView.swift
//  PLTextEditor
//
//  Created by Paper Lee on 19/05/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class PLRichTextView: UITextView, UITextViewDelegate {

    required init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        delegate = self
        addContentSizeObserver()
    }
    
    required override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        //fatalError("init(coder:) has not been implemented")
        var top = (bounds.size.height - contentSize.height * zoomScale) / 2.0
        top = top < 0.0 ? 0.0 : top
        self.setContentOffset(CGPoint(x: contentOffset.x, y: -top), animated: false)
    }
    
    private func addContentSizeObserver() {
        self.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    private func removeContentSizeObserver() {
        self.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let tv = object as! UITextView
        var top = (bounds.size.height - contentSize.height * zoomScale) / 2.0
        top = top < 0.0 ? 0.0 : top
        tv.setContentOffset(CGPoint(x: contentOffset.x, y: -top), animated: false)
    }
    
    deinit {
        removeContentSizeObserver()
    }

}
