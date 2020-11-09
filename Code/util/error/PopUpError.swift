//
//  PopUpError.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 31.08.2020.
//

import UIKit

class PopUpError: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let _ = loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromNib()
    }
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 8
        }
    }
    
    func loadViewFromNib() -> UIView {
        Bundle.main.loadNibNamed("PopUpError", owner: self, options: nil)
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "PopUpError", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
}
