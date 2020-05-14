//
//  ViewController.swift
//  AccesLevelDemo
//
//  Created by shiga on 12/05/20.
//  Copyright © 2020 shiga. All rights reserved.
//

import UIKit
import AccessLevelsPackage

class ViewController: UIViewController {
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var slideVolumeView: SideVolume!
    @IBOutlet weak var plainHorizontalView: PlainHorizontalProgressBar!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var volumeLeadingConstrints: NSLayoutConstraint!
    
    @IBOutlet weak var sliderVolumeView: UISlider!
    
    
    var volumeCount:Int = 0 {
        didSet {
            
            if volumeCount >= 1 && volumeCount < 3 {
                let image = UIImage(systemName: "speaker.1.fill", withConfiguration: .none)?.withTintColor(.gray)
                speakerImageView.image = image
            } else if volumeCount >= 3 && volumeCount < 6 {
                let image = UIImage(systemName: "speaker.2.fill", withConfiguration: .none)?.withTintColor(.gray)
                speakerImageView.image = image
            } else if volumeCount >= 6  {
                let image = UIImage(systemName: "speaker.3.fill", withConfiguration: .none)?.withTintColor(.gray)
                speakerImageView.image = image
            } else if volumeCount == 0 {
                let image = UIImage(systemName: "speaker.fill", withConfiguration: .none)?.withTintColor(.gray)
                speakerImageView.image = image
            } 
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let printer = SimpleMessagePrinter()
        printer.show(message: "This message is printed from another module")
        
//        topView.isUserInteractionEnabled = true;
//        mainView.isUserInteractionEnabled = true;
//        bottomView.isUserInteractionEnabled = true;
        
    //    print(printer.message)
        plainHorizontalView.backgroundColor = .gray
    }
    
    @IBAction func hide(_ sender: Any) {
        
        let delayTime = DispatchTime.now() + 0.1

               DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {

                   print("hello2")

                   UIView.transition(
                    with: self.slideVolumeView,
                    duration: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
                         //  imageView.isHidden = true
                        
                        self.volumeLeadingConstrints.constant = -60
                        self.view.layoutIfNeeded()
                        
                   }) { (_) in

                   }
               }) 
    }
    
    
    @IBAction func changeValue(_ sender: UISlider) {
        let progress = CGFloat(sender.value)
        plainHorizontalView.progress = progress
    }
    
    @IBAction func showVolume(_ sender: Any) {
           
   /*
        UIView.transition(
            with: slideVolumeView,
            duration: 0.5,
            options: [.curveLinear],
            animations: {
                self.volumeLeadingConstrints.constant = 30
                self.view.layoutIfNeeded()
        }, completion: nil)*/

//       UIView.animate(withDuration: 0.5) {
//           self.view.layoutIfNeeded()
//       }
        
        volumeCount += 1

        
       UIView.animate(withDuration: 0.8,
                      delay: 0.1,
                      usingSpringWithDamping: 0.6,
                      initialSpringVelocity: 1.0,
                      animations: {
                        
                        self.slideVolumeView.progress += 0.1
                               self.volumeLeadingConstrints.constant = 10
                        self.slideVolumeView .addSubview(self.speakerImageView)

                               self.view.layoutIfNeeded()
       }) { (_) in
        
        
        self.slideVolumeView .addSubview(self.speakerImageView)

       }
        
        
        
        
    
    }
    
}



@IBDesignable

class SideVolume: UIView {
    
    let animationMask = CAShapeLayer()
    let progressLayer  = CALayer()
    
    
    var progress:CGFloat = 0.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var color:UIColor? = .gray {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private  func setLayout() {
        layer.addSublayer(progressLayer)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.10)
        animationMask.path = path.cgPath
    
        layer.mask = animationMask
        
        let  volumeRect = CGRect(origin: CGPoint(x: 0, y: rect.height), size: CGSize(width: rect.width , height: rect.height * -progress))
        
        progressLayer.frame = volumeRect
        layer.addSublayer(progressLayer)
        
        progressLayer.backgroundColor = UIColor.systemBackground.cgColor
        
    }
}






@IBDesignable

class PlainHorizontalProgressBar: UIView {
    
    let progressLayer = CALayer()

    
    var progress:CGFloat = 0.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
  @IBInspectable  var color:UIColor = .gray {
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setupLayer()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
setupLayer()

    }
    
    
    func setupLayer()  {
layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {

        
        let animationMask = CAShapeLayer()
        
        let path =    UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        animationMask.path = path
        layer.mask = animationMask
        
        
        let progressrect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        
        progressLayer.frame = progressrect
        
        
        progressLayer.backgroundColor = color.cgColor
    }
    
    
}





















#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct PreviewViewController: UIViewRepresentable {
    
    func makeUIView(context: Context) ->  UIView {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()!.view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
    
}

@available(iOS 13.0, *)
struct Preview_Provider: PreviewProvider {
    
    static var previews: some View{
        PreviewViewController()
    }
}

#endif
