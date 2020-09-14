//
//  ViewController.swift
//  Hvor mange øl
//
//  Created by Alfred Løvgren on 31.10.2018.
//  Copyright © 2018 øl. All rights reserved.
//

import UIKit
import WebKit

class ViewController2: UIViewController{
    
    @IBOutlet var web: WKWebView!
    
    @IBOutlet var back: UIBarButtonItem!
    @IBAction func tilbake(_ sender: Any) {
         self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    @IBAction func ferdig(_ sender: Any) {self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://custerco.com/pils/") {
            let req = URLRequest(url: url)
            web.load(req)
        }
    }
}
extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet
    var tableView: UITableView!
    
    var selectedRowIndex = -1000
    @IBOutlet var olLabel: UILabel!
    var cellO = Drikke2TableViewCell()
    var cells:[Drikke2TableViewCell]!
    var dArray = [Array<Any>]()
    var unit : [String] = []
    @IBOutlet var plussbtn: UIButton!
    
    @IBAction func add(_ sender: Any) {
        NSLog("logg")
    }
    @IBOutlet weak var clearBtn: UIButton!
    @IBAction func clearAll(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Fjern alle", message: "Sveip på enhet for å slette én. \n'Ok' for å slette alle.", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.dArray = []
            self.clearBtn.isHidden = true
            self.tableView.reloadData()
            if self.unit[0] == "Promillekalkulator" {
                self.olLabel.text = "0 " + " ‰"
            }else{
                self.olLabel.text = "0 " + self.unit[0].uppercased() as String
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Avbryt", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @objc func updateLabel(notification:NSNotification){
        var ol = 0.0
        if notification.userInfo != nil{
        if let userInfo = notification.userInfo
        {
            var arr = dArray[cellO.indexP]
            arr[3] = userInfo[1]!
            arr[6] = userInfo[2]!
            dArray[cellO.indexP] = arr
        }
        }
        
        if unit[0] == "Promillekalkulator" {
            
            var ol = 0.0
            var timerS = unit[3] as! String
            let timer = Double(timerS)!
            for arr in dArray {
                var x1 = arr[3] as! String
                x1 = String(x1.dropLast().dropLast().dropLast())
                let x = Double(x1) ?? 0
                NSLog(x1)
                var y1 = arr[6] as! String
                y1 = String(y1.dropLast().dropLast())
                let y = Double(y1)!
                
                
                
                var vektS = unit[6] as! String
                let vekt = Double(vektS)!
                
                var kjonnsvariabelS = unit[4] as! String
                let kjonnsvariabel = Double(kjonnsvariabelS)!
                
                var kj2 = 0.68
                if kjonnsvariabel == 0 {
                    kj2 = 0.68
                } else {
                    kj2 = 0.55
                }
                
                let en = ((x * y/100)*0.785)/((vekt * 1000) * kj2)*1000
                let addOl = en
                //kjonnsvariabel:
                //menn: 0.68
                //kvinner: 0.55
                
                //mengdeveske *
                //750ml * 15%/100
                ol = ol + addOl
                NSLog(String(addOl))
            }
            ol = ol - (timer*0.15)
            var roundV = Double(round(10*ol)/10)
            if roundV < 0 {
                roundV = 0
            }
            olLabel.text = String(Float(roundV).clean) + " ‰"
            
        } else {
            //for i in stride(from: 0, to: userInfo!.count, by: 1){
                //aArray.append(userInfo![i] as! [String])
            //}
            // type = userInfo![0]!
            // prosent = userInfo![6]!
            // str = userInfo![3]!
            print(unit)
            var ol = 0.0
            for arr in dArray {
                var x1 = arr[3] as! String
                x1 = String(x1.dropLast().dropLast().dropLast())
                let x = Double(x1) ?? 0
                NSLog(x1)
                var y1 = arr[6] as! String
                y1 = String(y1.dropLast().dropLast())
                let y = Double(y1)!
                
                var mengdeS = unit[3] as! String
                mengdeS = String(mengdeS.dropLast().dropLast().dropLast())
                let mengde = Double(mengdeS)!
                
                var prosentS = unit[6] as! String
                prosentS = String(prosentS.dropLast().dropLast())
                let prosent = Double(prosentS)!
                
                let addOl = (x * (y/100))/(mengde * (prosent/100))
                
                //mengdeveske *
                //750ml * 15%/100
                ol = ol + addOl
                NSLog(String(addOl))
            }
            
            let roundV = Double(round(10*ol)/10)
            
            olLabel.text = String(Float(roundV).clean) + " " + unit[0].uppercased() as String
        }
    }
    @objc func updateTable(notification:NSNotification){
        
        let userInfo = notification.userInfo
        for i in stride(from: 0, to: userInfo!.count, by: 1){
            dArray.append(userInfo![i] as! Array)
        }
        
        self.tableView.reloadData()
    }
    @objc func updateUnit(notification:NSNotification){
        let userInfo = notification.userInfo
        unit = []
        for i in stride(from: 0, to: userInfo!.count, by: 1){
            unit.append(userInfo![i]! as! String)
        }
        
        if unit[0] == "Promillekalkulator" {

            var ol = 0.0
            var timerS = unit[3] as! String
            let timer = Double(timerS)!
            for arr in dArray {
                var x1 = arr[3] as! String
                x1 = String(x1.dropLast().dropLast().dropLast())
                let x = Double(x1) ?? 0
                NSLog(x1)
                var y1 = arr[6] as! String
                y1 = String(y1.dropLast().dropLast())
                let y = Double(y1)!
                
                
                
                var vektS = unit[6] as! String
                let vekt = Double(vektS)!
                
                var kjonnsvariabelS = unit[4] as! String
                let kjonnsvariabel = Double(kjonnsvariabelS)!
                
                var kj2 = 0.68
                if kjonnsvariabel == 0 {
                    kj2 = 0.68
                } else {
                    kj2 = 0.55
                }
                
                let en = ((x * y/100)*0.785)/((vekt * 1000) * kj2)*1000
                let addOl = en
                //kjonnsvariabel:
                //menn: 0.68
                //kvinner: 0.55
                
                //mengdeveske *
                //750ml * 15%/100
                ol = ol + addOl
                NSLog(String(addOl))
            }
            ol = ol - (timer*0.15)
            var roundV = Double(round(10*ol)/10)
            if roundV < 0 {
                roundV = 0
            }
            olLabel.text = String(Float(roundV).clean) + " ‰"
            
        } else {
            //for i in stride(from: 0, to: userInfo!.count, by: 1){
                //aArray.append(userInfo![i] as! [String])
            //}
            // type = userInfo![0]!
            // prosent = userInfo![6]!
            // str = userInfo![3]!
            print(unit)
            var ol = 0.0
            for arr in dArray {
                var x1 = arr[3] as! String
                x1 = String(x1.dropLast().dropLast().dropLast())
                let x = Double(x1) ?? 0
                NSLog(x1)
                var y1 = arr[6] as! String
                y1 = String(y1.dropLast().dropLast())
                let y = Double(y1)!
                
                var mengdeS = unit[3] as! String
                mengdeS = String(mengdeS.dropLast().dropLast().dropLast())
                let mengde = Double(mengdeS)!
                
                var prosentS = unit[6] as! String
                prosentS = String(prosentS.dropLast().dropLast())
                let prosent = Double(prosentS)!
                
                let addOl = (x * (y/100))/(mengde * (prosent/100))
                
                //mengdeveske *
                //750ml * 15%/100
                ol = ol + addOl
                NSLog(String(addOl))
            }
            
            let roundV = Double(round(10*ol)/10)
            
            olLabel.text = String(Float(roundV).clean) + " " + unit[0].uppercased() as String
        }
    }
    
    func registerTableViewCells(){
        let drikkeCell = UINib(nibName: "Drikke2TableViewCell", bundle: nil)
        self.tableView.register(drikkeCell, forCellReuseIdentifier: "Drikke2TableViewCell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.clearFunc()
        return dArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "Drikke2TableViewCell") as! Drikke2TableViewCell;
        
        let a1 = dArray[indexPath.row] as Array
        
        if selectedRowIndex == indexPath.row as Int {
            cell.downimg.isHidden = true
            cell.upimg.isHidden = false
        }else{
            cell.downimg.isHidden = false
            cell.upimg.isHidden = true
        }
        cell.idLbl.text = a1[0] as? String
        
        cell.prosLbl.text = a1[6] as? String
        
        let aInt = (a1[2] as! NSString).integerValue //get and set max value for mL slider
        cell.lSldr.maximumValue = Float(aInt)
        
         let aInt2 = (a1[3] as! NSString).integerValue //get and set max
        cell.lSldr.value = Float(aInt2)
       
        let apmin = a1[4] as? String //get and set min value for % slider
        let apMinInt = (apmin! as NSString).integerValue
        cell.pSldr.minimumValue = Float(apMinInt)
        
        let apmax = a1[1] as? String //get and set max value for % slider
        let apMaxInt = (apmax! as NSString).integerValue
        cell.pSldr.maximumValue = Float(apMaxInt)
        
        let vll = Double(String(a1[6] as! String).dropLast().dropLast())
        cell.pSldr.value = Float(vll ?? 0) //get and set start value for % slider
        
        cell.lLbl.text = a1[3] as? String
        
        let pros:Float=(cell.lSldr.value/cell.lSldr.maximumValue)
        var y = 185-(110*pros)
        if cell.lSldr.maximumValue == 250{
            y = 115-(30*pros)
        }else if cell.lSldr.maximumValue == 330{
            y = 185-(70*pros)
        }
        var x: CGFloat!
        x = cell.markerLbl.frame.origin.x
        cell.markerLbl.frame.origin = CGPoint(x: Int(x), y: Int(y))
        
      //  if (cell.lLbl.text == ""){
        //    cell.lLbl.text = a1[3] as? String
        //}
        
        cell.drikkeImg.image = UIImage(named: a1[5] as! String) //assign image
        cell.downimg.image = UIImage(named: "down image.png")
        
        cell.upimg.image = UIImage(named: "up.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        
        cellHeight = 75
        if indexPath.row == selectedRowIndex {
            cellHeight = 255
        }
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
        
        cellO.indexP = indexPath.row
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1000
        } else {
        selectedRowIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(selectedRowIndex == indexPath.row){
            return false
        }else{
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Slett") { (action, sourceView, completionHandler) in
            self.dArray.remove(at: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gogo"), object: nil, userInfo: nil)
            tableView.reloadData()
            completionHandler(true)
        }
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
           
        }
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateLabel), name: NSNotification.Name(rawValue: "gogo"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateTable), name: NSNotification.Name(rawValue: "submitVC"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateUnit), name: NSNotification.Name(rawValue: "updateUnit"),
            object: nil)
        plussbtn.layer.cornerRadius = 5
        plussbtn.layer.borderWidth = 1
        plussbtn.layer.borderColor = UIColor.white.cgColor
        super.viewDidLoad()
        
        unit = ["Øl", "15 %", "500 ml", "500 ml", "0 %", "olikon_min.png", "4.7 %", "0"]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView() // Removes empty cell separators
        tableView.estimatedRowHeight = 171.5
        tableView.rowHeight = UITableView.automaticDimension
        self.registerTableViewCells()
        
        self.infoLabel.text = "Trykk på '+' knappen for å legge til drikke";
        
    }
    func clearFunc(){
        NSLog("appeared logg")
        if(dArray.isEmpty){
            clearBtn.isHidden = true
             NSLog("hidden logg")
            self.infoLabel.text = "Trykk på '+' knappen for å legge til drikke \n \n Trykk på tannhjulet for flere måleenheter";
            self.infoLabel.frame = CGRect(x:self.infoLabel.frame.origin.x,y:self.infoLabel.frame.origin.y,width:self.infoLabel.intrinsicContentSize.width,height:self.infoLabel.intrinsicContentSize.height)
        }else{
            clearBtn.isHidden = false
            NSLog("ffaaalse logg")
            self.infoLabel.text = "Trykk på enheten for å endre mengde og alkoholprosent \n \n Sveip for å slette";
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
}


