//
//  GameBoard.swift
//  Swift-TicTacToe
//
//  Created by Lahiru Lakmal on 2016-12-22.
//  Copyright © 2016 SoundofCode. All rights reserved.
//

import UIKit

protocol GridItem {
    
    
}

enum Player: String {
    case Player1 = "playerO"
    case Player2 = "playerX"
    case None = "empty"
}

class VisibleGridItem: UIView {

    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: Player.None.rawValue))
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .yellow
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .white
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
    @objc func imageTapped(gesture: UITapGestureRecognizer)
    {
        print("tapped")
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
