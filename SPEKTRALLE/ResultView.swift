//
//  ResultView.swift
//  SPEKTRALLE
//
//  Created by MounikaGarlapati on 9/23/17.
//  Copyright (c) 2017 MounikaGarlapati. All rights reserved.
//

import Foundation
import UIKit

class ResultView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ResultTable: UITableView!
    
    var symbol_select = 0;
    var mhz_peaks = "";
    var display_result: [Result] = []
    var display_resultir: [ResultIR] = []
    
    /* Range for the lookup of each input and Result to hold a final array of
     * results with values to be displayed. There is a copy of both structs specifically for IR
     * because IR has an extra display String - peak shape.
     *
     * TODO: Change bond/func_group to filenames to display images rather than just text strings
     */
    struct Range {
        var r1: Double
        var r2: Double
        var bond: String
        var func_group: String
    }
    struct RangeIR {
        var r1: Double
        var r2: Double
        var peak_shape: String
        var bond: String
        var func_group: String
    }
    
    struct Result {
        var bond: String
        var func_group: String
    }
    struct ResultIR {
        var peak_shape: String
        var bond: String
        var func_group: String
    }
    
    /*
    * 1 - C
    * 2 - H
    * 3 - IR
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "splash.png")!)

        ResultTable.delegate = self
        ResultTable.dataSource = self
        self.ResultTable.reloadData()
        
        //Set up predefined peak ranges
        //C peaks
        var c_peaks: [Range] = []
        let c_r1 = [0.9, 1.3, 1.5, 4.6, 2, 6, 2.2, 1.7, 4, 3, 2.5, 2, 3.4, 3.3, 3.7, 2, 2, 2, 9, 2, 4, 15, 10.5, 1, 7.26, 4.79, 1.72]
        let c_r2 = [0.9, 1.3, 1.5, 5.9, 3, 8.5, 3, 1.7, 4.5, 4, 4, 4, 4, 4, 4.1, 2.2, 2.6, 2.7, 10, 4, 12, 17, 12, 5, 7.26, 4.79, 1.72]
        let c_bond = ["RCH3", "R2CH2", "R3CH", "C=C-H", "C=-C-H", "Ar-H", "Ar-C-H", "C=C-CH3", "HC-F", "HC-CL", "HC-Br", "HC-l", "HC-OH", "HC-OR", "RCOO-CH", "HC-COOR", "HC-COOH", "HC-C=O", "HRC-O", "ROH", "ArOH", "C=C-OH", "RCOOH", "RNH2", "CDCI3", "D2O", "THF"]
        let c_func = ["1'aliphatic", "2'aliphatic", "3'aliphatic", "vinylic", "acetylenic", "aromatic", "benzylic", "allylic", "fluoride", "cholride", "bromide", "iodide", "alcohol", "ether", "ester", "ester", "acid", "carbonyl", "aldehyde", "hydroxyl", "phenol", "enol", "carboxyl", "amino", "solvent", "solvent", "solvent"]
        for i in 0..<c_r1.count {
            c_peaks.append(Range(r1: c_r1[i], r2: c_r2[i], bond: c_bond[i], func_group: c_func[i]))
        }
        
        //H peaks
        var h_peaks: [Range] = []
        let h_r1 = [205, 190, 170, 125, 115, 67, 50, 40, 37, 25, 20, 16, 10, 67.21, 25.31, 77.16, 137.48]
        let h_r2 = [220, 200, 185, 150, 140, 85, 65, 45, 45, 35, 30, 25, 15, 67.21, 25.31, 77.16, 137.48]
        let h_bond = ["C=O", "C=O", "C=O", "C=C", "C=C", "C=-C", "RCH2OH", "RCH2CL", "RCH2NH2", "R3CH", "CH3CO-", "R2CH2", "RCH3", "THF", "THF", "CDCL3", "toluene"]
        let h_func = ["ketone", "aldehyde", "ester/acid", "aromatic", "alkene", "alkyne", "1'alcohol", "chloroalkane", "aliphatic amine", "3'aliphatic", "acetyl", "2'aliphatic", "1'aliphatic", "solvent", "solvent", "solvent", "solvent"]
        for i in 0..<h_r1.count {
            h_peaks.append(Range(r1: h_r1[i], r2: h_r2[i], bond: h_bond[i], func_group: h_func[i]))
        }

        
        //IR peaks
        var ir_peaks: [RangeIR] = []
        let ir_r1 = [3610, 3200, 3250, 2500, 3270, 3000, 3000, 2850, 2695, 2210, 2100, 1665, 1690, 1735, 1720, 1715, 1715, 1665, 1640, 1580, 1585, 1475, 1400, 1450, 1350, 1290, 1250, 1000, 1150, 1150, 1020, 650, 910, 665, 675, 550, 720, 610.00, 515.00]
        let ir_r2 = [3640, 3500, 3400, 3300, 3330, 3100, 3100, 3000, 2830, 2260, 2260, 1760, 1760, 1750, 1740, 1730, 1715, 1710, 1680, 1650, 1600, 1550, 1500, 1470, 1370, 1360, 1335, 1320, 1300, 1300, 1250, 1000, 950, 910, 900, 850, 725, 700.00, 690.00]
        let ir_peak_shape = ["s/sh", "s/b", "m", "m", "n/s", "s", "m", "m", "m", "m", "w", "s", "s", "s", "s", "s", "s", "s", "m", "m", "m", "s", "m", "m", "m", "m", "s", "s", "m", "m", "m", "s", "m", "s/b", "s", "m", "m", "b/s", "m"]
        let ir_bond = ["O-H stretch, free hydroxyl", " O-H stretch H-bonded", "N-H stretch", "O-H stretch", "-C=-C-H", "C-H stretch", "-C=H stretch", "C-H stretch", "H-C=O: C-H stretch", "C=-N stretch", "-C=-C- stretch", "C=O stretch", "C=O stretch", "C=O stretch", "C=O stretch", "C=O stretch", "C=O stretch", "C=O stretch", "-C=C- stretch", "N-H bend", "C-C stretch (in-ring)", "N-O assymetric stretch", "C-C stretch", "C-H bend", "C-H rock", "N-O symmetric stretch", "C-N stretch", "C-O stretch" , "C-H wag", "C-H wag", "C-N stretch", "C=C-H bend" , "O-H bend", "N-H wag", "C-H oop", "C-Cl stretch", "C-H rock", "-C=-C-H", "C-Br stretch"]
        let ir_func = ["alcohol/phenol", "alcohols/phenols", "1'or2' amines/amides", "carboxylic", "terminal alk", "aromatic", "alkene", "alkane", "aldehyde", "nitrile", "alkyne", "carbonyl", "carboxylic", "saturated", "saturated", "a/b unsat", "saturated", "a/b unsat", "alkene", "1'amine", "aromatic", "nitro", "aromatic", "alkane", "alkane", "nitro", "aromatic", "alochol", "alkyl", "alkyl", "aliphatic", "alkene", "carboxylic", "1'2' amine", "aromatic", "alkyl", "alkane", "alkyne", "alkyl"]
        for i in 0..<ir_r1.count {
            ir_peaks.append(RangeIR(r1: ir_r1[i], r2: ir_r2[i], peak_shape: ir_peak_shape[i], bond: ir_bond[i], func_group: ir_func[i]))
        }
        
        var result = mhz_peaks.components(separatedBy: ",")
        if (result.count > 0) {
            for i in 0..<result.count {
                switch symbol_select {
                    case 1: //C
                        for j in 0..<c_peaks.count {
                            if((result[i] as NSString).doubleValue >= (c_peaks[j]).r1 && (result[i] as NSString).doubleValue <= (c_peaks[j]).r2) {
                                display_result.append(Result(bond: c_peaks[j].bond, func_group: c_peaks[j].func_group))
                            }
                        }
                    case 2: //H
                        for j in 0..<h_peaks.count {
                            if((result[i] as NSString).doubleValue >= (h_peaks[j]).r1 && (result[i] as NSString).doubleValue <= (h_peaks[j]).r2) {
                                display_result.append(Result(bond: h_peaks[j].bond, func_group: h_peaks[j].func_group))
                            }
                        }
                    case 3: //IR
                        for j in 0..<ir_peaks.count {
                            if((result[i] as NSString).doubleValue >= (ir_peaks[j]).r1 && (result[i] as NSString).doubleValue <= (ir_peaks[j]).r2) {
                                display_resultir.append(ResultIR(peak_shape: ir_peaks[j].peak_shape, bond: ir_peaks[j].bond, func_group: ir_peaks[j].func_group))
                            }
                        }
                default: display_result.append(Result(bond: "null", func_group: "null")); //TODO: Error Handling
                }
            }
        }
        else {
            //TODO: Error Handling Page (back to home?)
        }
        
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
        if (symbol_select <= 2) {
            cell.bond_label.text = display_result[indexPath.row].bond
            cell.func_label.text = display_result[indexPath.row].func_group
            cell.peak_wave_label.text = ""
        }
        else {
            cell.bond_label.text = display_resultir[indexPath.row].bond
            cell.func_label.text = display_resultir[indexPath.row].func_group
            cell.peak_wave_label.text = display_resultir[indexPath.row].peak_shape
        }
        
        //For when we use images
        //cell.imageVW.image = UIImage(named:self.arrImageName[indexPath.row])
        //cell.lblName.text = self.tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (symbol_select <= 2){
            return display_result.count
        }
        else {
            return display_resultir.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

