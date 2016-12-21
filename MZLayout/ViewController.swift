//
//  ViewController.swift
//  MZLayout
//
//  Created by 猎人 on 2016/12/21.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aView = UIView()
        view.addSubview(aView)
        aView.backgroundColor = UIColor.blue
        let _ = aView.mz_setSize(width: 100, height: 100).mz_centreToSuperView()
        
        
        let bView = UIView()
        view.addSubview(bView)
        bView.backgroundColor = UIColor.red
        
        let _ = bView.mz_topToBottom(toView: aView, distance: 30).mz_axisXToSuperView(offsetX: 0).mz_widthToWidth(toView: aView, multiplier: 1).mz_heightToHeight(toView: aView, multiplier: 1);
        
        let cView = UIView()
        bView.addSubview(cView)
        cView.backgroundColor = UIColor.white
        
        let dView = UIView()
        bView.addSubview(dView)
        dView.backgroundColor = UIColor.black
        
        
        let _ = cView.mz_topToSuperView(distance: 20).mz_leftToSuperView(distance: 0).mz_bottomToSuperView(distance: 0)
        
        let _ = dView.mz_topToSuperView(distance: 20).mz_leftToRight(toView: cView, distance: 10).mz_bottomToSuperView(distance: 0).mz_rightToSuperView(distance: 0).mz_widthToWidth(toView: cView, multiplier: 1)

    }
}

