//
//  TutorSecureViewController.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 21.08.2020.
//

import UIKit

protocol TutorView: ViewProtocol {
    
}

class TutorSecureViewController: BaseViewController {
    var presenter: TutorialPresenter!
    @IBOutlet weak var oneStepLabel: UILabel!
    @IBOutlet weak var twoStepLabel: UILabel!
    @IBOutlet weak var twoStepTimeLabel: UILabel!
    @IBOutlet weak var thirdStepLabel: UILabel!
    @IBOutlet weak var successBtn: UIButton!
    
    @IBOutlet weak var notRightNowBtn: UIButton!
    
    @IBOutlet weak var infoNavbar: UINavigationBar! {
        didSet {
            self.infoNavbar.setBackgroundImage(UIImage(), for: .default)
            self.infoNavbar.shadowImage = UIImage()
            self.infoNavbar.isTranslucent = true
            self.infoNavbar.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var constraintStep2: NSLayoutConstraint!
    @IBOutlet weak var constraintStep3: NSLayoutConstraint!
    
    var step: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneStepLabel.layer.cornerRadius = oneStepLabel.frame.width/2
        oneStepLabel.layer.masksToBounds = true
        twoStepLabel.layer.borderWidth = 1
        twoStepLabel.layer.borderColor = UIColor("4D9EF0").cgColor
        twoStepLabel.layer.masksToBounds = true
        twoStepLabel.layer.cornerRadius = oneStepLabel.frame.width/2
        thirdStepLabel.layer.borderWidth = 1
        thirdStepLabel.layer.borderColor = UIColor("4D9EF0").cgColor
        thirdStepLabel.layer.masksToBounds = true
        thirdStepLabel.layer.cornerRadius = oneStepLabel.frame.width/2
        
        switch step {
        case 1:
            twoStepTimeLabel.text = "2 min"
        case 2:
            twoStepLabel.backgroundColor = UIColor("4D9EF0")
            successBtn.setTitle("Verify identity", for: .normal)
            twoStepTimeLabel.text = "Done"
            notRightNowBtn.isHidden = false
        case 3:
            thirdStepLabel.backgroundColor = UIColor("4D9EF0")
        default: break;
        }
        
        if Device.is678 || Device.isPhone5 || Device.is5c {
            constraintStep2.constant = 35
            constraintStep3.constant = 35
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Prefs.shared.notRightNow {
            presenter?.onDone()
        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onEnable2FA(_ sender: Any) {
        if self.step == 2 {
            presenter?.openKYC()
        } else {
            presenter?.on2FASetup()
        }
    }
    
    
    @IBAction func onNotRightNow(_ sender: Any) {
        presenter?.onNotRightNow()
    }
    
}

extension TutorSecureViewController: TutorView {}
