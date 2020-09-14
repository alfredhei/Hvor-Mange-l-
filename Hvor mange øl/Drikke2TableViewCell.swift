//
//  Drikke2TableViewCell.swift
//  Hvor mange øl
//
//  Created by Alfred Løvgren on 01.11.2018.
//  Copyright © 2018 øl. All rights reserved.
//

import UIKit

class Drikke2TableViewCell: UITableViewCell {

    //let tableB = ViewController()
    @IBOutlet var idLbl: UILabel!
    @IBOutlet var prosLbl: UILabel!
    @IBOutlet var lLbl: UILabel!
    
    @IBOutlet var upimg: UIImageView!
    @IBOutlet var downimg: UIImageView!
    @IBOutlet var drikkeImg: UIImageView!
    @IBOutlet var markerLbl: UILabel!
    @IBOutlet var lSldr: slider!
    @IBOutlet var pSldr: slider!
    var liter: String!
    var prosMIN: String!
    var prosMAX: String!
    var indexP: Int!
    var x: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func slider(_ sender: Any) {
        let txt = String(lSldr.value.rounded())
        let pros:Float=(lSldr.value/lSldr.maximumValue)
        
        lLbl.text = String(txt.dropLast().dropLast()) + " ml"
        var y = 185-(110*pros)
        if lSldr.maximumValue == 250{
            y = 115-(30*pros)
        }else if lSldr.maximumValue == 330{
            y = 185-(70*pros)
        }
        x = markerLbl.frame.origin.x
        markerLbl.frame.origin = CGPoint(x: Int(x), y: Int(y))
        
        let digitWords = [lLbl.text! as String, prosLbl.text! as String]
        let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...2, digitWords))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gogo"), object: nil, userInfo: wordToValue)
    }
    @IBAction func slider2(_ sender: Any) {
        //let txt = pSldr.value
        
        let roundedString = String(format: "%.1f", pSldr.value)
        prosLbl.text = String(roundedString) + " %"
        
        let digitWords = [lLbl.text! as String, prosLbl.text! as String]
        let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...2, digitWords))
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gogo"), object: nil, userInfo: wordToValue)
    }
    
}


class Drikke3TableViewCell: UITableViewCell {

    //let tableB = ViewController()
    @IBOutlet var idLbl: UILabel!
    @IBOutlet weak var hLbl: UILabel!
    @IBOutlet weak var vLbl: UILabel!
    @IBOutlet var upimg: UIImageView!
    @IBOutlet var downimg: UIImageView!
    @IBOutlet weak var vSldr: slider!
    @IBOutlet weak var hSldr: slider!
    @IBOutlet weak var bekreftBtnO: UIButton!
    @IBOutlet weak var kjonn: UISegmentedControl!
    @IBAction func bekreftBtn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bekreftPressed"), object: nil, userInfo: nil)
    }
    var liter: String!
    var prosMIN: String!
    var prosMAX: String!
    var indexP: Int!
    var x: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func kjonnC(_ sender: Any) {
        let txt = String(hSldr.value.rounded())
        let txt2 = String(vSldr.value.rounded())
        let txt3 = String(kjonn.selectedSegmentIndex)
        hLbl.text = String(txt.dropLast().dropLast()) + " t"
        
        var digitWords = [String(txt.dropLast().dropLast()), String(txt2.dropLast().dropLast()), txt3]
        if vLbl.text == "Vekt" && hLbl.text == "Timer"{
            digitWords = ["t", "v", txt3]
        }else if vLbl.text == "Vekt"{
            digitWords = [String(txt.dropLast().dropLast()), "v", txt3]
        }else if hLbl.text == "Timer"{
            digitWords = ["t", String(txt.dropLast().dropLast()), txt3]
        }
        
        let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...3, digitWords))

        let defaults = UserDefaults.standard
        defaults.set(txt3, forKey: "kjonn")
            
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "slider3"), object: nil, userInfo: wordToValue)
        
    }
    
    @IBAction func slider(_ sender: Any) {
        let txt = String(hSldr.value.rounded())
        let txt2 = String(vSldr.value.rounded())
        let txt3 = String(kjonn.selectedSegmentIndex)
        hLbl.text = String(txt.dropLast().dropLast()) + " t"
       
        var digitWords = [String(txt.dropLast().dropLast()), String(txt2.dropLast().dropLast()), txt3]
       if vLbl.text == "Vekt"{
           digitWords = [String(txt.dropLast().dropLast()), "v", txt3]
       }
        let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...3, digitWords))

        let defaults = UserDefaults.standard
        defaults.set(String(txt.dropLast().dropLast()), forKey: "timer")
            
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "slider3"), object: nil, userInfo: wordToValue)
        

        //let digitWords = [lLbl.text! as String, prosLbl.text! as String]
        //let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...2, digitWords))
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gogo"), object: nil, userInfo: wordToValue)
    }
    @IBAction func slider2(_ sender: Any) {
        //let txt = pSldr.value
        let txt = String(vSldr.value.rounded())
        let txt2 = String(hSldr.value.rounded())
        let txt3 = String(kjonn.selectedSegmentIndex)
        vLbl.text = String(txt.dropLast().dropLast()) + " kg"

        var digitWords = [String(txt2.dropLast().dropLast()), String(txt.dropLast().dropLast()), txt3]
        if hLbl.text == "Timer"{
            digitWords = ["t", String(txt.dropLast().dropLast()), txt3]
        }
          
        let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...3, digitWords))
        
        let defaults = UserDefaults.standard
        defaults.set(String(txt.dropLast().dropLast()), forKey: "vekt")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "slider3"), object: nil, userInfo: wordToValue)
        //let digitWords = [vLbl.text! as String, vLbl.text! as String]
        //let wordToValue = Dictionary(uniqueKeysWithValues: zip( 1...2, digitWords))
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gogo"), object: nil, userInfo: wordToValue)
    }
    
}
