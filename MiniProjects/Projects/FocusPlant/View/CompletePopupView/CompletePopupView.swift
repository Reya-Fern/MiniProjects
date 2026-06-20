//
//  CompletePopupView.swift
//  MiniProjects
//
//  Created by Wannipa Reya on 20/6/2569 BE.
//

import UIKit

final class CompletePopupView: UIView {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!

    protocol CompletePopupViewDelegate: AnyObject {
        func completePopupViewDidTapOK(_ popup: CompletePopupView)

    }

    weak var delegate: CompletePopupViewDelegate?

    static func loadFromNib() -> CompletePopupView {
        let nib = UINib(nibName: "CompletePopupView", bundle: nil)
        
        guard let view = nib.instantiate(withOwner: nil).first as? CompletePopupView else {
            fatalError("Unable to load CompletePopupView")
        }
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
}

// MARK: - UI
extension CompletePopupView {
    private func style() {
        cardView.makeRounded(cornerRadius: 24)
        
        titleLabel.text = "Great Job!"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        treeImageView.image = UIImage(named: "tree_stage_4")
        
        messageLabel.text = "You've successfully \ngrown your tree."
        messageLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = .greenButton
        okButton.makeRounded(cornerRadius: 25)
    }
}

// MARK: - Action
extension CompletePopupView {
    @IBAction func okButtonPressed(_ sender: Any) {
        delegate?.completePopupViewDidTapOK(self)
    }

    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.cardView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        }) { _ in
            self.removeFromSuperview()
        }
    }
}
