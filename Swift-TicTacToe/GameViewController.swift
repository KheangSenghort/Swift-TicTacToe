//
//  GameViewController.swift
//  Swift-TicTacToe
//
//  Created by Lahiru Lakmal on 2016-12-20.
//  Copyright © 2016 SoundofCode. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var gridItemView_0: GridItemView!
    @IBOutlet weak var gridItemView_1: GridItemView!
    @IBOutlet weak var gridItemView_2: GridItemView!
    @IBOutlet weak var gridItemView_3: GridItemView!
    @IBOutlet weak var gridItemView_4: GridItemView!
    @IBOutlet weak var gridItemView_5: GridItemView!
    @IBOutlet weak var gridItemView_6: GridItemView!
    @IBOutlet weak var gridItemView_7: GridItemView!
    @IBOutlet weak var gridItemView_8: GridItemView!
    
    let gridItemsViews2: [GridItemView] = {
        var items = [GridItemView]()
        for _ in 0..<1 {
            items.append(GridItemView())
        }
        return items
    }()
    
    var gridItemsViews = [GridItemView]()
    
    func setupViews() {
        view.backgroundColor = .white
        
        gridItemsViews = [gridItemView_0, gridItemView_1, gridItemView_2,
                          gridItemView_3, gridItemView_4, gridItemView_5,
                          gridItemView_6, gridItemView_7, gridItemView_8]
        
        gridItemView_0.initializeView()
        
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
