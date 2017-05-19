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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        // custom slider
        //let gradientBackgroundImage = UIImage.imageWithRainbowGradient(frame: CGRect(x: 0, y: 0, width: slider.bounds.width, height: 4 ))
        slider.setMaximumTrackImage(UIImage.imageWithTransparentLayer(frame: CGRect(x: 0, y: 0, width: slider.bounds.width, height: 4 )), for: .normal)
        slider.setMinimumTrackImage(UIImage.imageWithTransparentLayer(frame: CGRect(x: 0, y: 0, width: slider.bounds.width, height: 4 )), for: .normal)
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: slider.bounds.height/2-2, width: slider.bounds.width, height: 4 )
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
        layer.cornerRadius = 2
        slider.layer.insertSublayer(layer, at: 0)
        
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

