//
//  unitVC.swift
//  Hvor mange øl
//
//  Created by Alfred Løvgren on 16/09/2019.
//  Copyright © 2019 øl. All rights reserved.
//
import UIKit
import GoogleMobileAds
import Foundation
class unitVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var selectedRowIndex = -1000
    var cellO = Drikke2TableViewCell()
    var cells:[Drikke2TableViewCell]!
    
    var vc = ViewController()
    var cellO1 = Drikke3TableViewCell()
    var cells1:[Drikke3TableViewCell]!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bArray.count + 1
    }
    func registerTableViewCells(){
        let drikkeCell = UINib(nibName: "Drikke3TableViewCell", bundle: nil)
        self.listTableView.register(drikkeCell, forCellReuseIdentifier: "Drikke3TableViewCell")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {if indexPath.row < (bArray.count){
            // your cell coding
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
            var a1 = bArray[indexPath.row] as Array
            cell.lbl1.text = a1[0] as? String
            cell.lbl2.text = (a1[2] as? String)! + " · " + (a1[6] as? String)!
            cell.imageV.image = UIImage(named: a1[5] as! String)
            //cell!.selectionStyle = .none
            
            /*cell.callback = { value in
                print(indexPath, value)
                var text = String(value)
                text = String(text.dropLast().dropLast())
                a1[7] = text
                self.bArray[indexPath.row] = a1
                cell.lblC.text = text
                print(text)
                // do something with the new value for example update the model
            }
            */
            return cell
            
        } else {
            // your cell coding
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_info", for: indexPath) as! CustomTableViewCell
            cell.isUserInteractionEnabled = false
            return cell
        }
//          UNCOMMENT FOR PROMILLE KALK SLETT OVER
//        if indexPath.row < (bArray.count - 1){
//            // your cell coding
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//            var a1 = bArray[indexPath.row] as Array
//            cell.lbl1.text = a1[0] as? String
//            cell.lbl2.text = (a1[2] as? String)! + " · " + (a1[6] as? String)!
//            cell.imageV.image = UIImage(named: a1[5] as! String)
//            //cell!.selectionStyle = .none
//
//            /*cell.callback = { value in
//                print(indexPath, value)
//                var text = String(value)
//                text = String(text.dropLast().dropLast())
//                a1[7] = text
//                self.bArray[indexPath.row] = a1
//                cell.lblC.text = text
//                print(text)
//                // do something with the new value for example update the model
//            }
//            */
//            return cell
//
//        } else if indexPath.row == (bArray.count - 1){
//                let cell = tableView.dequeueReusableCell(withIdentifier: "Drikke3TableViewCell") as! Drikke3TableViewCell;
//
//              let a1 = bArray[indexPath.row] as Array
//
//              if selectedRowIndex == indexPath.row as Int {
//                  cell.downimg.isHidden = true
//                  cell.upimg.isHidden = false
//              }else{
//                  cell.downimg.isHidden = false
//                  cell.upimg.isHidden = true
//              }
//              cell.idLbl.text = a1[0] as? String
//              cell.idLbl.frame = CGRect(x:cell.idLbl.frame.origin.x,y:cell.idLbl.frame.origin.y,width:cell.idLbl.intrinsicContentSize.width,height:cell.idLbl.intrinsicContentSize.height)
//            var arr = bArray[bArray.count - 1]
//            let defaults = UserDefaults.standard
//            if let stringOne = defaults.string(forKey: "timer") {
//                cell.hSldr.value = Float((stringOne as NSString).integerValue)
//                cell.hLbl.text = String(stringOne) + " t"
//                arr[3] = stringOne
//            }
//            if let stringTwo = defaults.string(forKey: "vekt") {
//                cell.vSldr.value = Float((stringTwo as NSString).integerValue)
//                cell.vLbl.text = String(stringTwo) + " kg"
//
//                arr[6] = stringTwo
//            }
//            if let stringThree = defaults.string(forKey: "kjonn") {
//                cell.kjonn.selectedSegmentIndex = (stringThree as NSString).integerValue
//
//
//                arr[4] = stringThree
//            }
//
//            bArray[bArray.count - 1] = arr
//              cell.hSldr.minimumValue = Float(1)
//              cell.hSldr.maximumValue = Float(24)
//
//              cell.vSldr.minimumValue = Float(0)
//              cell.vSldr.maximumValue = Float(200)
//
//              cell.downimg.image = UIImage(named: "down image.png")
//
//              cell.upimg.image = UIImage(named: "up.png")
//           cell.bekreftBtnO.layer.cornerRadius = 5
//
//              return cell
//        } else {
//            // your cell coding
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_info", for: indexPath) as! CustomTableViewCell
//            cell.isUserInteractionEnabled = false
//            return cell
//        }
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           var cellHeight:CGFloat = CGFloat()
           
           cellHeight = 75
           if indexPath.row == selectedRowIndex {
               cellHeight = 255
                cellO1.indexP = indexPath.row

            
           }
           
           return cellHeight
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row < (bArray.count){
                var arr = bArray[indexPath.row] as Array
                let wordToValue = Dictionary(uniqueKeysWithValues: zip( 0...arr.count, arr))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateUnit"), object: nil, userInfo: wordToValue)
                self.presentingViewController?.dismiss(animated: true, completion:nil)
            }
//        UNCOMMENT FOR PROMILLEKALK
//        if indexPath.row < (bArray.count - 1){
//            var arr = bArray[indexPath.row] as Array
//            let wordToValue = Dictionary(uniqueKeysWithValues: zip( 0...arr.count, arr))
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateUnit"), object: nil, userInfo: wordToValue)
//            self.presentingViewController?.dismiss(animated: true, completion:nil)
//        } else if indexPath.row == (bArray.count - 1){
//            //cellO1.indexP = indexPath.row
//            if selectedRowIndex == indexPath.row {
//                selectedRowIndex = -1000
//            } else {
//                selectedRowIndex = indexPath.row
//            }
//        }
        
        
        tableView.reloadData()
//        UNCOMMENT FOR PROMILLEKALK
//        if indexPath.row == (bArray.count - 1){
//            let indexPath = NSIndexPath(row: indexPath.row, section: 0)
//            self.listTableView.scrollToRow(at: indexPath as IndexPath,
//            at: UITableView.ScrollPosition.middle, animated: true)
//        }
    }
    @objc func bekreftHandler(notification:NSNotification) {
        var arr = bArray[cellO1.indexP] as Array
        let bla = arr[3] as! String
        let bla2 = arr[6] as! String
        if bla != "t" && bla2 != "v" && bla2 != "0" {
            let refreshAlert = UIAlertController(title: "OBS", message: "BEREGNINGEN FORUTSETTER ET JEVNT INNTAK OVER TIDSROMMET DU VALGTE. EN PROMILLEKALKULATOR VIL KUN GI ET ESTIMERT PROMILLENIVÅ OG KAN IKKE BRUKES TIL VURDERING AV F.EKS. BILKJØRING.", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                let wordToValue = Dictionary(uniqueKeysWithValues: zip( 0...arr.count, arr))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateUnit"), object: nil, userInfo: wordToValue)
                self.presentingViewController?.dismiss(animated: true, completion:nil)
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        } else{
            let alert = UIAlertController(title: "Obs!", message: "Oppgi timer drukket og vekt.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")

                  case .cancel:
                        print("cancel")

                  case .destructive:
                        print("destructive")


            }}))
            self.present(alert, animated: true, completion: nil)
        }

    }
    @objc func kalkAdj(notification:NSNotification) {
        if notification.userInfo != nil{
        if let userInfo = notification.userInfo
        {
            var arr = bArray[cellO1.indexP]
            arr[3] = userInfo[1]!
            arr[6] = userInfo[2]!
            arr[4] = userInfo[3]!
            bArray[cellO1.indexP] = arr
            print(bArray[cellO1.indexP])
        }
        }
    }
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var listTableView: UITableView!
    var bArray = [Array<Any>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = "ca-app-pub-7458114320525800/6211282494"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        let tArray2 = ["Øl", "15 %", "500 ml", "500 ml", "0 %", "olikon_min.png", "4.7 %", "0"]
        //let tArray3 = ["Sterkøl", "15 %", "500 ml", "500 ml", "4.7 %", "olikon_min.png", "15 %", "0"]
        let tArray3 = ["Vin", "15 %", "250 ml", "120 ml", "8 %", "vinglass.png", "12 %", "0"]
        let tArray4 = ["Vinflaske", "15 %", "750 ml", "750 ml", "8 %", "vinflaske.png", "12 %", "0"]
        let tArray7 = ["Shot", "80 %", "40 ml", "40 ml", "22 %", "shot.png", "40 %", "0"]
        
        //let tArray8 = ["Promillekalkulator", "0", "0", "t", "k", "0", "v", "0"]
        bArray.append(tArray2 as Array)
        bArray.append(tArray3 as Array)
        bArray.append(tArray4 as Array)
        bArray.append(tArray7 as Array)
        //bArray.append(tArray8 as Array)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.tableFooterView = UIView() // Removes empty cell separators
        listTableView.reloadData()
        self.registerTableViewCells()
        NotificationCenter.default.addObserver(self, selector: #selector(self.bekreftHandler), name: NSNotification.Name(rawValue: "bekreftPressed"),
        object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.kalkAdj), name: NSNotification.Name(rawValue: "slider3"),
               object: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
