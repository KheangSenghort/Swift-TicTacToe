//
//  GameViewController.swift
//  Swift-TicTacToe
//
//  Created by Lahiru Lakmal on 2016-12-20.
//  Copyright © 2016 SoundofCode. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let gridItems: [VisibleGridItem] = {
        var items = [VisibleGridItem]()
        for _ in 0..<1 {
            items.append(VisibleGridItem())
        }
        return items
    }()
    
    func setupViews() {
        view.backgroundColor = .white
        
        /*for gridItem in gridItems {
            view.addSubview(gridItem.imageView)
        }*/
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
