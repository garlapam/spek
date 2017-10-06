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
    //var result = [String]()
    //let result = "0, 0, 0"
    
    /*
    * 1 - C
    * 2 - H
    * 3 - IR
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "splash.png")!)
        print(symbol_select)
        //result.append("0, 0, 0")
        //result = mhz_peaks.components(separatedBy: ",")
        var result = mhz_peaks.components(separatedBy: ",")
        if (result.count > 0) {
            for i in 0..<result.count {
                print("Result is ", result[i])
            }
            
            //var mhz:Double? = Double(result[0])
            //print("MHZ int ", mhz as Any)
            

            
            //mhz = Int((result[0]))
            //peak1 = result[1].toInt()!
            //peak2 = result[2].toInt()!
        }
        else {
            //ERROR Page (back to home?)
        }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

