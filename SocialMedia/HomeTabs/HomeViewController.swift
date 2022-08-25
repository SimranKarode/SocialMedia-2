//
//  HomeViewController.swift
//  SocialMedia
//
// Created by ABDUL KADIR ANSARI on 06/04/22.
//

import UIKit
import AFNetworking
import ObjectMapper
import SDWebImage
import JGProgressHUD

class HomeViewController: UIViewController,CPSliderDelegate {
    
    
  //  @IBOutlet weak var img_collectionview: BJAutoScrollingCollectionView!
    @IBOutlet weak var home_tableview: UITableView!
    
    @IBOutlet weak var static_tableview: UITableView!
    
    @IBOutlet weak var img_slider: CPImageSlider!
    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var lbl_tite: UILabel!
    @IBOutlet weak var lbl_username: UILabel!
    
    var secureView: UIView!
    
    var sliderImageArray = ["banner1","banner2"]
    var nameArray = ["आगामी त्योहार और दिन","आगामी त्योहार और दिनआगामी त्योहार और दिन","आगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिन ","आगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिन","आगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिन ","आगामीत्योहारऔरदिन आगामीत्योहारऔरदिआगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिनआगामी त्योहार और दिन ",]
    var imageArray = ["pf_s37","pf_s38","pf_s39","pf_s40","pf_s41","pf_s42"]
    var imageArray2 = ["pf_s49","pf_s50","pf_s51","pf_s52","pf_s53","pf_s54"]
    
    let yourImagesArray = [#imageLiteral(resourceName: "ic_mypost"),#imageLiteral(resourceName: "ic_callus"), #imageLiteral(resourceName: "ic_remove"),#imageLiteral(resourceName: "pf_s30"), #imageLiteral(resourceName: "pf_s51"), #imageLiteral(resourceName: "pf_s49"),#imageLiteral(resourceName: "pf_s41"), #imageLiteral(resourceName: "f_twitter")]
    
    var timer = Timer()
    var currentItem: Int = 0
    
  
    
    // var homeArrayList : HomeJsonVo?
    var cardDetailListArray = NSArray()

    var sectionImage = ["Apple","Bannana","Cat"]
    var recentlyAddedAudio_Id_Array = Array<String>()
    var otherRecentlyAddedAudio_Id_Array = Array<String>()
    var otherRecentlyAddedAudio_Id_Array2 = Array<String>()
    var otherRecentlyAddedAudio_Id_Array3 = Array<String>()
    
    var yourOtherRecentlyAddedAudio_Id_Array = [String:Any]()
    var yourOtherRecentlyAddedAudio_Id_Array2 = [String:Any]()
    var yourOtherRecentlyAddedAudio_Id_Array3 = [String:Any]()
    
    var cagegoriesArray:[HomeJsonVO] = Array<HomeJsonVO>()
    var filtered:[FeatuerJsonVO] = []
    
    var sliderArray:[SliderResultVO] = []
    var sliderResultArray:[SliderJsonVO] = []
    
    var videosJsonVO:[VideosJsonVO] = []
    var videosJsonVO2:[VideosJsonVO] = []
    var videosJsonVO3:[VideosJsonVO] = []
    var yourScroll_Image_Array = [String]()
    let hud = JGProgressHUD()
    var loginStatus = ""
    
    @IBOutlet weak var static_table: NSLayoutConstraint!
    //    HomeCollectionViewCell
    override func viewDidLoad() {
        super.viewDidLoad()
        homeAPICalling()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.static_tableview.isHidden = true
        img_slider.delegate = self
        
        guard let login = UserDefaults.standard.string(forKey: "LoginStatus") else { return }
        loginStatus = login
        let loginUserName = UserDefaults.standard.object(forKey:"name") as? String ?? ""

        lbl_username.text = loginUserName
        
        if loginStatus == "true"{
            let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
            if imgurl != nil {
                imgview.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
                lbl_username.text = loginUserName

            }else{
                imgview.image = UIImage(named: "latestst123")
            }
        }else{
            imgview.image = UIImage(named: "latestst123")
            lbl_username.text = "User"
        }
        
        
        imgview.layer.borderWidth = 1
        imgview.layer.masksToBounds = false
        imgview.layer.borderColor = UIColor.white.cgColor
        imgview.layer.cornerRadius = imgview.frame.height/2
        imgview.clipsToBounds = true
        //        self.tableViewUpdate()
        
        home_tableview.delegate = self
        home_tableview.dataSource = self
        let imageTableCell  = UINib(nibName: "HomeTableViewCell" , bundle: nil)
        home_tableview.register(imageTableCell, forCellReuseIdentifier: "HomeTableViewCell")
        
        
        static_tableview.delegate = self
        static_tableview.dataSource = self
                let imstaticCell  = UINib(nibName: "StaticCell" , bundle: nil)
        static_tableview.register(imstaticCell, forCellReuseIdentifier: "StaticCell")
//        StaticCell,StaticTableViewCell
        
        // Do any additional setup after loading the view, typically from a nib. image
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController                    .tappedMe))
        imgview.addGestureRecognizer(tap)
        imgview.isUserInteractionEnabled = true
        

    }
    @objc func tappedMe() {
        print(" on Image")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateBussinessProfileViewController") as! UpdateBussinessProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func sliderImageTapped(slider: CPImageSlider, index: Int) {
        print("\(index)")
    }
    
   
    func tableViewUpdate(){
        home_tableview.delegate = self
        home_tableview.dataSource = self
        
        home_tableview.register( UINib(nibName:  "BannerTableViewCell", bundle: nil), forCellReuseIdentifier:  "BannerTableViewCell")
        
        home_tableview.register( UINib(nibName:  "HomeTableViewCell", bundle: nil), forCellReuseIdentifier:  "HomeTableViewCell")
    }
    func homeAPICalling(){
        hud.show(in: self.view)
        cagegoriesArray.removeAll()
        self.filtered.removeAll()
        videosJsonVO.removeAll()
        getRequest(with: URL(string: "https://socialmediaallinone.com/sma_admin/rest-api/v100/home_content_for_android")!) { [self] (result) in
            //  print("Result",Result)cellfo
            hud.textLabel.text = "Loading"
            let respVO:HomeJsonVO = Mapper().map(JSONObject: result)!
            
            self.cagegoriesArray.append(respVO)
            let listArr = respVO.features_genre_and_movie
            //
            // print("self.videosJsonVOOne",respVO.slider)
            self.filtered = listArr!

            self.sliderArray.append(respVO.slider!)
            for allSlider in self.sliderArray {
                self.sliderResultArray = allSlider.slide!
                for allImage in self.sliderResultArray {
                    print("allImage.image_link",allImage.image_link ?? "")
                    self.yourScroll_Image_Array.append(allImage.image_link ?? "")
                }
                
            }
            DispatchQueue.main.async {
              //  self.updateData()
               // self.img_collectionview.reloadData()
                self.home_tableview.reloadData()
                self.img_slider.images = self.yourScroll_Image_Array
                self.img_slider.autoSrcollEnabled = true

                self.hud.dismiss()

            }
        }
    }
    func getRequest(with url: URL, callback: @escaping (Any?) -> Swift.Void) -> Void {
        self.cagegoriesArray.removeAll()
        self.videosJsonVO.removeAll()
        self.videosJsonVO2.removeAll()
        self.videosJsonVO3.removeAll()
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)

        let defaultConfigObject = URLSessionConfiguration.default
        defaultConfigObject.timeoutIntervalForRequest = 30.0
        defaultConfigObject.timeoutIntervalForResource = 60.0

        let session = URLSession.init(configuration: defaultConfigObject, delegate: nil, delegateQueue: nil)

        var urlRequest = URLRequest(url: url as URL)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("8e90d71140a94bb", forHTTPHeaderField: "API-KEY")


        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

            guard    let httpResponse: HTTPURLResponse = response as? HTTPURLResponse
                else {
                    print("Error: did not receive data")
                    return
            }

            var response : (Any)? = nil

            if httpResponse.statusCode == 200 {
                print(httpResponse)

                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }

                do {
                    let responseData = try JSONSerialization.jsonObject(with: responseData, options: [JSONSerialization.ReadingOptions.allowFragments])

                    response = responseData
                    print("response",response)
                    callback(response)
                    self.hud.dismiss()
                }
                catch _ as NSError {

                    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    callback(responseString)
                    return
                }
            }
            else {
                print(httpResponse)

                guard error == nil else {
                    print("error calling GET on /todos/1")
                    print(error ?? "error")
                    callback(response!)
                    return
                }
                self.hud.dismiss()
            }
        }).resume()
    }
    
    
    
    
}
    
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return self.filtered.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

            return 1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  220
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.More_Btn.tag = indexPath.section
      //  let subCategoryTitle = filtered[indexPath.section].videos
        cell.filteredVO.removeAll()
        cell.filteredVO = filtered[indexPath.section].videos!
        
      //  cell.yourData(yourData: subCategoryTitle!)
        // Set cell's delegate
        
        cell.lbl_Name.text = filtered[indexPath.section].name
        cell.cellDelegate = self
        cell.selectionStyle = .none


            
            cell.More_Btn.addTarget(self, action: #selector(moreClicked(_:)), for: .touchUpInside)
            return cell
    }
 
    
    @objc func moreClicked(_ sender : UIButton){
        
//        if loginStatus == "false"{
//            alertForLogin()
//        }else{
            let titleName = filtered[sender.tag].name
            let videosArray = filtered[sender.tag].videos
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
            toggleVC.videosFromJsonVO = videosArray!
            //            vc.Selectedlable_title = self.videosJsonVO.name
            toggleVC.Selectedlable_title = titleName ?? ""
            
            let navController = UINavigationController.init(rootViewController:toggleVC)
            // UserDefaults.standard.set(true, forKey: "LoginSession")
            let appDelegateP = UIApplication.shared
            appDelegateP.windows.first?.rootViewController = navController
            
//        }
        
    }
    func alertForLogin(){
        // create the alert
        
        let alert = UIAlertController(title: "Alert!", message: "Are you sure want to login now?", preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                 let navController = UINavigationController.init(rootViewController:toggleVC)
                 let appDelegateP = UIApplication.shared
                 appDelegateP.windows.first?.rootViewController = navController

             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                 
                 
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    
}
extension HomeViewController: HomeCollectionViewCellDelegate {
    func homeCollectionView(collectionviewcell: HomeCollectionViewCell?,section: Int ,index: String,title: String, didTappedInTableViewCell: HomeTableViewCell, sectionTitle: String) {
        
//        let name = filtered[IndexPath.tag].name
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "SubMoreViewController") as! SubMoreViewController
        toggleVC.isFromSubMore = "SubMore"
        toggleVC.selectedVideoId = index
        toggleVC.selectededTitle = title
        toggleVC.isRootFrom = sectionTitle
        let navController = UINavigationController.init(rootViewController:toggleVC)
                // UserDefaults.standard.set(true, forKey: "LoginSession")
        let appDelegateP = UIApplication.shared
        appDelegateP.windows.first?.rootViewController = navController
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubMoreViewController") as! SubMoreViewController
//        vc.isFromSubMore = "SubMore"
//        vc.selectedVideoId = index
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func alertForLogins(){
        // create the alert
        
        let alert = UIAlertController(title: "Alert!", message: "Are you sure want to login now?", preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                 let navController = UINavigationController.init(rootViewController:toggleVC)
                 let appDelegateP = UIApplication.shared
                 appDelegateP.windows.first?.rootViewController = navController

             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                 
                 
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    
}

 
