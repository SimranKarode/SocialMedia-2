//
//  SelectFontStyleVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit

class SelectFontStyleVC: UIViewController {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var font_tableview: UITableView!
    @IBOutlet weak var ok_btn: UIButton!
       
    var selectedFontStyle : CreatePostPopUpDelegate?

    
//    var fontNamesArray = ["FontsFree-Net-honeycomb-happiness-1","abhayalibre_bold", "abhayalibe_extrabold", "abhayalibre_medium", "artifika_regular", "archivo_black","ArchivoNarrow", "ABeeZee", "After_Shokf", "AbrilFatface", "Acknowledgement","Acme", "AlfaSlabOne", "AlmendraDisplay", "Almendra", "alpha_echo","Amadeus", "AMERSN", "ANUDI", "AquilineTwo", "Arbutus", "AlexBrush","Alisandra", "Allura", "Amarillo", "BEARPAW", "bigelowrules", "BLACKR","BOYCOTT", "BebasNeue", "BLKCHCRY", "Carousel", "Caslon_Calligraphic","CroissantOne", "Carnevalee-Freakshow", "CAROBTN", "CaviarDreams","Cocogoose", "diplomata", "deftone stylus", "Dosis", "FONTL",
//        "Hugtophia", "ICE_AGE", "Kingthings_Calligraphica", "Love Like This","MADE Canvas", "Merci-Heart-Brush", "Metropolis", "Montserrat","MontserratAlternates",
//        "norwester", "ostrich", "squealer", "Titillium", "Ubuntu"]
//
    var fontNamesArray = ["BLACKR","BOYCOTT", "BebasNeue", "BLKCHCRY", "Carousel", "Caslon_Calligraphic","CroissantOne", "Carnevalee-Freakshow", "CAROBTN", "CaviarDreams","Cocogoose", "diplomata", "deftone stylus", "Dosis", "FONTL","Hugtophia", "ICE_AGE", "Kingthings_Calligraphica", "Love Like This","MADE Canvas", "Merci-Heart-Brush", "Metropolis", "Montserrat","MontserratAlternates",
            "norwester", "ostrich", "squealer", "Titillium", "Ubuntu"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        font_tableview.delegate = self
        font_tableview.dataSource =  self
        
        font_tableview.register( UINib(nibName:  "FontStyleTableViewCell", bundle: nil), forCellReuseIdentifier:  "FontStyleTableViewCell")
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ok_BtnActn(_ sender: UIButton) {
        removeAnimate()
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
extension SelectFontStyleVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fontNamesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontStyleTableViewCell", for: indexPath) as! FontStyleTableViewCell
//        cell.lbl_namestyle.tag = indexPath.item
        cell.lbl_namestyle.text = fontNamesArray[indexPath.row]
        cell.lbl_namestyle.font = UIFont(name: fontNamesArray[indexPath.row], size: 16)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let seectedFontStyle = fontNamesArray[indexPath.row]
        //BOYCOTT
        lbl_title.font = UIFont(name: seectedFontStyle, size: 20)
        
        if let delegate = selectedFontStyle {

            delegate.selectedFontTypeeDelegate(forntSize: seectedFontStyle)
        }
    }

}
