//
//  SubMoreViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit
import ObjectMapper
import SDWebImage
import JGProgressHUD

class SubMoreViewController: UIViewController {
    
    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var submore_collectionview: UICollectionView!
    
    var categoryJsonArray:[CategoryListJsonVO] = Array<CategoryListJsonVO>()
    var categoryResultArray:[CategoryResultVO] = []
    var episodResultArray:[EpispdeResultVo] = []

    var selectedVideoId = ""
    var selectededTitle = ""
    var isFromSubMore = ""
    var isRootFrom = ""
    var loginStatus = ""
    
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true

        guard let login = UserDefaults.standard.string(forKey: "LoginStatus") else { return }
        loginStatus = login
        
        submore_collectionview.delegate = self
        submore_collectionview.dataSource =  self
        
        lbl_title.text = selectededTitle

        
        submore_collectionview.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        categoryListApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
        
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        self.hud.dismiss()
    }
    func categoryListApi(){
        self.categoryJsonArray.removeAll()
        self.categoryResultArray.removeAll()
        self.episodResultArray.removeAll()
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/single_details?type=tvseries&id=\(selectedVideoId)"
        getRequest(with: URL(string: url)!) { (result) in
            let respVO:CategoryListJsonVO = Mapper().map(JSONObject: result)!
            self.categoryJsonArray.append(respVO)
            for all in self.categoryJsonArray {
                self.categoryResultArray = all.season!
            }
            print("self.categoryResultArray",self.categoryResultArray)
            for al in self.categoryResultArray {
                self.episodResultArray =  al.episodes!
            }
            DispatchQueue.main.async {
                self.hud.dismiss()
                self.submore_collectionview.reloadData()
            }
        }
    }
    
    func getRequest(with url: URL, callback: @escaping (Any?) -> Swift.Void) -> Void {
        
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
                
            }
        }).resume()
    }
    @IBAction func back_BtnActn(_ sender: UIButton) {
        if isFromSubMore == "SubMore" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarViewController
            let navController = UINavigationController.init(rootViewController:toggleVC)
            let appDelegateP = UIApplication.shared
            appDelegateP.windows.first?.rootViewController = navController
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
extension SubMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.self.episodResultArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "ImageCollectionViewCell", for:  indexPath) as! ImageCollectionViewCell
//        cell.backview.layer.cornerRadius = 6
//        cell.backview.layer.borderWidth = 1
//        cell.backview.layer.borderColor = UIColor.systemBlue.cgColor
        let yourData = self.episodResultArray[indexPath.item]
        cell.imgview.sd_setImage(with:URL(string: yourData.image_url ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = self.episodResultArray[indexPath.item].image_url ?? ""
        
        if loginStatus == "false"{
            alertForLogin()
        }else{
            if isRootFrom == "Wishes" {
                let createVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePostVC") as! CreatePostVC
                createVC.episodResultArray = episodResultArray
                createVC.isImageFromSelected = selectedImage
                print("selectedImage",selectedImage)
                self.navigationController?.pushViewController(createVC, animated: true)

            }else{
                let createVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
                createVC.episodResultArray = episodResultArray
                createVC.isImageFromSelected = selectedImage
                print("selectedImage",selectedImage)
                self.navigationController?.pushViewController(createVC, animated: true)

            }
        }
        
//
////        _ = self.episodResultArray[indexPath.row].image_url ?? ""
//        let createVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
//        createVC.episodResultArray = episodResultArray
//        createVC.isImageFromSelected = selectedImage
//
//        print("selectedImage",selectedImage)
//        self.navigationController?.pushViewController(createVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 6, left: 15, bottom: 6, right: 15)
        layout.minimumInteritemSpacing = 02
        layout.minimumLineSpacing = 02
        layout.invalidateLayout()
        return CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
    }
    func alertForLogin(){
        // create the alert
        
        let alert = UIAlertController(title: "Social Media!", message: "Are you sure want to login now?", preferredStyle: .alert)
        
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
