//
//  PLRichTextView.swift
//  PLTextEditor
//
//  Created by Paper Lee on 19/05/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class PLRichTextView: UITextView, UITextViewDelegate {
    
    var isBold:Bool = false
    var isItalic:Bool = false
    
    required init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        delegate = self
        setup()
    }
    
    required override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        //fatalError("init(coder:) has not been implemented")
        setup()
    }
    
    private func setup() {
        
        // Make text vertical center-aligned
        var top = (bounds.size.height - contentSize.height * zoomScale) / 2.0
        top = top < 0.0 ? 0.0 : top
        self.setContentOffset(CGPoint(x: contentOffset.x, y: -top), animated: false)
        
        // Append keyboard toolbar
        let inputToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        inputToolbar.items = [UIBarButtonItem(title: "Bold", style: .done, target: self, action: #selector(PLRichTextView.makeBold)), UIBarButtonItem(title: "Italic", style: .done, target: self, action: #selector(PLRichTextView.makeItalic))]
        self.inputAccessoryView = inputToolbar
        
        // Add observer to make text verical center-aligned
        addContentSizeObserver()
        
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
    
    func makeBold(){
        let str = self.text
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText)
        let font = attributedString.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as! UIFont
        
        if isBold {
            var symTraits = font.fontDescriptor.symbolicTraits
            symTraits.remove([.traitBold])
            let fontDescriptorVar = UIFontDescriptor().withSymbolicTraits(symTraits)
            attributedString.addAttribute(NSFontAttributeName, value: UIFont(descriptor: fontDescriptorVar!, size: 26) , range: NSRange(location: 0, length: (str?.characters.count)!) )
            
        } else {
            var symTraits = font.fontDescriptor.symbolicTraits
            symTraits.insert([.traitBold])
            let fontDescriptorVar = UIFontDescriptor().withSymbolicTraits(symTraits)
            attributedString.addAttribute(NSFontAttributeName, value: UIFont(descriptor: fontDescriptorVar!, size: 26) , range: NSRange(location: 0, length: (str?.characters.count)!) )
        }
        isBold = !isBold
        self.attributedText = attributedString
    }
    
    func makeItalic(){
        let str = self.text
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText)
        let font = attributedString.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as! UIFont
        
        if isItalic {
            var symTraits = font.fontDescriptor.symbolicTraits
            symTraits.remove([.traitItalic])
            let fontDescriptorVar = UIFontDescriptor().withSymbolicTraits(symTraits)
            attributedString.addAttribute(NSFontAttributeName, value: UIFont(descriptor: fontDescriptorVar!, size: 26) , range: NSRange(location: 0, length: (str?.characters.count)!) )
            
        } else {
            var symTraits = font.fontDescriptor.symbolicTraits
            symTraits.insert([.traitItalic])
            let fontDescriptorVar = UIFontDescriptor().withSymbolicTraits(symTraits)
            attributedString.addAttribute(NSFontAttributeName, value: UIFont(descriptor: fontDescriptorVar!, size: 26) , range: NSRange(location: 0, length: (str?.characters.count)!) )
        }
        
        isItalic = !isItalic
        
        self.attributedText = attributedString
    }


}
