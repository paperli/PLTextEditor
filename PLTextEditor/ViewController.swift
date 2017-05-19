//
//  ViewController.swift
//  PLTextEditor
//
//  Created by Paper Lee on 18/05/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var editorView: UIView!
    var isBold = false
    var isItalic = false
    let SLIDER_BACKGROUND_HEIGHT:CGFloat = 8.0
    let SLIDER_BACKGROUND_BORDER:CGFloat = 2.0
    let SLIDER_PADDING:CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // custom slider
        //let gradientBackgroundImage = UIImage.imageWithRainbowGradient(frame: CGRect(x: 0, y: 0, width: slider.bounds.width, height: 4 ))
        slider.setMaximumTrackImage(UIImage.imageWithTransparentLayer(frame: CGRect(x: 0, y: 0, width: slider.bounds.width, height: SLIDER_BACKGROUND_HEIGHT )), for: .normal)
        slider.setMinimumTrackImage(UIImage.imageWithTransparentLayer(frame: CGRect(x: 0, y: 0, width: slider.bounds.width, height: SLIDER_BACKGROUND_HEIGHT )), for: .normal)
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
        
        slider.setValue(1, animated: false)
        self.colorSliderValueChanged(slider)
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slider.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
        slider.transform = CGAffineTransform(rotationAngle: 90*CGFloat.pi/180)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTextAction(_ sender: UIButton) {
        self.editorView.isHidden = false
        self.textView.becomeFirstResponder()
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        if sender.value == 0 {
            textView.textColor = UIColor.white
        } else if sender.value == 1 {
            textView.textColor = UIColor.black
        } else {
            textView.textColor = UIColor(hue: CGFloat(sender.value), saturation: 1, brightness: 1, alpha: 1)
        }
        slider.thumbTintColor = textView.textColor
    }
    
        
}

