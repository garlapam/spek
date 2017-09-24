//
//  ResultView.swift
//  SPEKTRALLE
//
//  Created by MounikaGarlapati on 9/23/17.
//  Copyright (c) 2017 MounikaGarlapati. All rights reserved.
//

import Foundation
//
//  ViewController.swift
//  SPEKTRALLE
//
//  Created by MounikaGarlapati on 10/10/16.
//  Copyright (c) 2016 MounikaGarlapati. All rights reserved.
//

import UIKit

class ResultView: UIViewController{
    
    var symbol_select = 0;
    var mhz_peaks = "";
    var mhz:Int = 0;
    var peak1:Int = 0;
    var peak2:Int = 0;
    var result = [String]()
    //let result = "0, 0, 0"
    
    /*
    * 1 - C
    * 2 - H
    * 3 - IR
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "splash.png")!)
        println(symbol_select)
        result.append("0, 0, 0")
        result = mhz_peaks.componentsSeparatedByString(",")
        if (result.count == 3) {
            mhz = Int((result[0]))
            //peak1 = result[1].toInt()!
            //peak2 = result[2].toInt()!
        }
        println(mhz)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

