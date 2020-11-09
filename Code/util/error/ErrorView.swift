//
//  ErrorView.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 24.08.2020.
//

import UIKit

enum ErrorState {
    case NETWORK, DATA
}

class ErrorView: UIView {
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var infoNavbar: UINavigationBar! {
           didSet {
               self.infoNavbar.setBackgroundImage(UIImage(), for: .default)
               self.infoNavbar.shadowImage = UIImage()
               self.infoNavbar.isTranslucent = true
               self.infoNavbar.backgroundColor = .clear
           }
       }
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    
    var errorState: ErrorState?
    var onButtonCallback: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let _ = loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromNib()
    }
    
    func loadViewFromNib() -> UIView {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "ErrorView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
    
    func configureUI(_ errorState: ErrorState, isBackButtonActive: Bool) {
        switch errorState {
        case .NETWORK:
            errorImage.image = UIImage(named: "error_network_image")
            errorLabel.text = "Connection timed out. Please, try again later"
        case .DATA:
            errorImage.image = UIImage(named: "error_data_image")
            errorLabel.text = "Something went wrong"
        }
        
        if isBackButtonActive {
            backButtonItem.isEnabled = true
            infoNavbar.isHidden = false
        } else {
            backButtonItem.isEnabled = false
            infoNavbar.isHidden = true
        }
    }
    @IBAction func onBackButton(_ sender: Any) {
        onButtonCallback?()
    }
    
}
