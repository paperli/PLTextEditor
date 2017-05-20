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
    var boldButton:UIButton!
    var italicButton:UIButton!
    var slider:UISlider!
    let SLIDER_BACKGROUND_HEIGHT:CGFloat = 8.0
    let SLIDER_BACKGROUND_BORDER:CGFloat = 2.0
    let SLIDER_PADDING:CGFloat = 2.0
    
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
        self.contentInset = UIEdgeInsets(top: top, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right)
        
        // Append keyboard toolbar
        let inputToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        let buttonsGroupView:UIView = UIView(frame: CGRect(x:0,y:0,width:88+150,height:44))
        boldButton = UIButton(type: .system)
        boldButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        boldButton.addTarget(self, action: #selector(PLRichTextView.makeBold), for: .touchUpInside)
        boldButton.setImage(UIImage(named:"icon_bold"), for: .normal)
        
        italicButton = UIButton(type: .system)
        italicButton.frame = CGRect(x: 44, y: 0, width: 44, height: 44)
        italicButton.addTarget(self, action: #selector(PLRichTextView.makeItalic), for: .touchUpInside)
        italicButton.setImage(UIImage(named:"icon_italic"), for: .normal)
        
        slider = UISlider(frame: CGRect(x: 88, y: 7, width: 150, height: 30))
        slider.setValue(1, animated: false)
        slider.setMaximumTrackImage(UIImage.imageWithTransparentLayer(frame: slider.bounds), for: .normal)
        slider.setMinimumTrackImage(UIImage.imageWithTransparentLayer(frame: slider.bounds), for: .normal)
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: SLIDER_BACKGROUND_BORDER+SLIDER_PADDING, y: (slider.bounds.height-SLIDER_BACKGROUND_HEIGHT)/2, width: slider.bounds.width-SLIDER_BACKGROUND_BORDER*2-SLIDER_PADDING*2, height: SLIDER_BACKGROUND_HEIGHT )
        var colors:[CGColor] = []
        colors.append(UIColor.white.cgColor)
        for i in 0...10 {
            let a = 0.1 * Double(i)
            let color = UIColor(hue: CGFloat(a), saturation: 1, brightness: 1, alpha: 1).cgColor
            colors.append(color)
        }
        colors.append(UIColor.black.cgColor)
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y:0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.cornerRadius = SLIDER_BACKGROUND_HEIGHT/2
        slider.layer.insertSublayer(layer, at: 0)
        
        let outerLayer = CAShapeLayer()
        outerLayer.frame = CGRect(x: SLIDER_PADDING, y: (slider.bounds.height-SLIDER_BACKGROUND_HEIGHT)/2-SLIDER_BACKGROUND_BORDER, width: slider.bounds.width-SLIDER_PADDING*2, height: SLIDER_BACKGROUND_HEIGHT+SLIDER_BACKGROUND_BORDER*2)
        let path = CGPath(roundedRect: outerLayer.bounds, cornerWidth: outerLayer.frame.height/2, cornerHeight: outerLayer.frame.height/2, transform: nil)
        outerLayer.path = path
        outerLayer.fillColor = UIColor.white.cgColor
        slider.layer.insertSublayer(outerLayer, at: 0)
        
        buttonsGroupView.addSubview(boldButton)
        buttonsGroupView.addSubview(italicButton)
        buttonsGroupView.addSubview(slider)
        slider.isHidden = true
        
        inputToolbar.items = [UIBarButtonItem(customView:buttonsGroupView)]
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
        tv.contentInset = UIEdgeInsets(top: top, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right)
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
        boldButton.isSelected = isBold
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
        italicButton.isSelected = isItalic
        self.attributedText = attributedString
    }


}
