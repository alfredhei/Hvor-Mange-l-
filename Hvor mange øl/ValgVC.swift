//
//  ValgVC.swift
//  Hvor mange øl
//
//  Created by Alfred Løvgren on 19.11.2018.
//  Copyright © 2018 øl. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CustomTableViewCell: UITableViewCell {
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var imageV: UIImageView!
    @IBOutlet var lblC: UILabel!
    @IBOutlet var stepperO: UIStepper!
    var callback : ((Double)->())?
    

    @IBAction func stepperC(_ sender: Any) {
        callback?(stepperO!.value)
    }
}
class ValgVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var bannerView: GADBannerView!
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    @IBAction func submit(_ sender: Any) {
        var sArray = [Array<Any>]()
        print("check")
        for i in stride(from: 0, to: bArray.count, by: 1){
            print("check1")
            var arr = bArray[i] as Array
            print(arr[7])
            let cI = Int(arr[7] as! String)!
            arr.remove(at: 7)
            if cI > 0 {
                print("check2")
                for z in stride(from: 0, to: cI, by: 1){
                    print("check3")
                    sArray.append(arr)
                    print(sArray)
                }
            }
        }
        let wordToValue = Dictionary(uniqueKeysWithValues: zip( 0...sArray.count, sArray))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "submitVC"), object: nil, userInfo: wordToValue)
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gogo"), object: nil, userInfo: nil)
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    @IBOutlet var ValgVC: UIView!
    
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
    var bArray = [Array<Any>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = "ca-app-pub-7458114320525800/6211282494"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        //let ol3A = ["Øl/Cider", "15 %", "330 ml", "330 ml", "0 %", "olikon33_min.png", "4.7 %", "0"]
        let ol5A = ["Øl/Cider", "15 %", "500 ml", "500 ml", "0 %", "olikon_min.png", "4.7 %", "0"]
        //let tArray3 = ["Sterkøl", "15 %", "500 ml", "500 ml", "4.7 %", "olikon_min.png", "15 %", "0"]
        let vinGA = ["Vin/musserende", "15 %", "250 ml", "120 ml", "8 %", "vinglass.png", "12 %", "0"]
        let vinFA = ["Vin/musserende", "15 %", "750 ml", "750 ml", "8 %", "vinflaske.png", "12 %", "0"]
        let vinKA = ["Vinkartong", "15 %", "3000 ml", "3000 ml", "8 %", "kartong.png", "12 %", "0"]
        let bvinA = ["Brennevin", "22 %", "500 ml", "500 ml", "15 %", "22ikon_min.png", "20.5 %", "0"]
        let shotA = ["Shot", "80 %", "40 ml", "40 ml", "22 %", "shot.png", "40 %", "0"]
        let spritA = ["Sprit", "80 %", "1000 ml", "1000 ml", "22 %", "spritikon2_min.png", "40 %", "0"]
        let himkA = ["Himkok", "96 %", "1000 ml", "1000 ml", "80 %", "himkok.png", "90 %", "0"]
        bArray.append(ol5A as Array)
        //bArray.append(ol3A as Array)
        bArray.append(vinFA as Array)
        bArray.append(spritA as Array)
        bArray.append(bvinA as Array)
        bArray.append(shotA as Array)
        bArray.append(vinGA as Array)
        bArray.append(vinKA as Array)
        bArray.append(himkA as Array)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.tableFooterView = UIView() // Removes empty cell separators
        listTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bArray.count + 1// your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < bArray.count{
        // your cell coding
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        var a1 = bArray[indexPath.row] as Array
        cell.lbl1.text = a1[0] as? String
        cell.lbl2.text = a1[2] as? String
        cell.imageV.image = UIImage(named: a1[5] as! String)
        //cell!.selectionStyle = .none
        
        cell.callback = { value in
            print(indexPath, value)
            var text = String(value)
            text = String(text.dropLast().dropLast())
            a1[7] = text
            self.bArray[indexPath.row] = a1
            cell.lblC.text = text
            print(text)
            // do something with the new value for example update the model
        }
        
        return cell
        
        }else {
            // your cell coding
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_info", for: indexPath) as! CustomTableViewCell
            cell.isUserInteractionEnabled = false
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        
        cellHeight = 75
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}
