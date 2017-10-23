//
//  ViewController.swift
//  SPEKTRALLE
//
//  Created by MounikaGarlapati on 10/10/16.
//  Copyright (c) 2016 MounikaGarlapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var go_button: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var mhz_peaks: UITextField!
    
    @IBOutlet weak var logo: UIImageView!
    var symbol_select:Int = 0;
    var mhz_peaks_text:String = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "splash.png")!)
        logo.image = UIImage(named: "logo.png")

        pickerView.delegate = self
        pickerView.transform = CGAffineTransform(scaleX: 1, y: 1.75);
        
        go_button.addTarget(self, action: #selector(ViewController.pressed(_:)), for: .touchUpInside)
        

        
    }

    // Button
    @objc func pressed(_ sender: UIButton!) {
        mhz_peaks_text = mhz_peaks.text!
        self.performSegue(withIdentifier: "ResultGo", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultGo" {
            if let destination = segue.destination as? ResultView {
                destination.symbol_select = symbol_select
                destination.mhz_peaks = mhz_peaks_text
            }
        }
    }
    
    // MARK: UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    // MARK: UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        var myImageView = UIImageView()
        
        switch row {
        case 0:
            myImageView = UIImageView(image: UIImage(named:"c13"))
        case 1:
            myImageView = UIImageView(image: UIImage(named:"H1"))
        case 2:
            myImageView = UIImageView(image: UIImage(named:"IR"))
        default:
            myImageView.image = nil
            
            return myImageView
        }
        return myImageView
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ///+1 to distiguish between the class default of 0
        symbol_select = row + 1
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

