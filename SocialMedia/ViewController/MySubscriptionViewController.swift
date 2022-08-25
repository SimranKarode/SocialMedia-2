//
//  MySubscriptionViewController.swift
//  SocialMedia
//
//  Created by Abdul on 25/06/22.
//

import UIKit
import ObjectMapper
import AFNetworking


class MySubscriptionViewController: UIViewController {

    
    
    @IBOutlet weak var my_SubscriptionTable: UITableView!
    
       var activeAndInactive_subscription:[SubscriptJsonVO] = []
        var active_subscription:[SubscriptResultVO] = []
        var inactive_subscription:[SubscriptResultVO] = []
    
    
    var loginuserid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        my_SubscriptionTable.delegate = self
        my_SubscriptionTable.dataSource =  self

        my_SubscriptionTable.register( UINib(nibName:  "SubList1TableViewCell", bundle: nil), forCellReuseIdentifier:  "SubList1TableViewCell")
        my_SubscriptionTable.register( UINib(nibName:  "SubListTableViewCell", bundle: nil), forCellReuseIdentifier:  "SubListTableViewCell")
        
        let loginUserid = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""
        loginuserid = loginUserid
        
        subscriptionListAPI(loginuserid: loginUserid)
        
    }
    func subscriptionListAPI(loginuserid: String) {
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/subscription_history?user_id=" + "" + "64"
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json","API-KEY/8e90d71140a94bb"]) as Set<NSObject> as? Set<String>
        manager.get(url, parameters: "", headers: ["API-KEY" : "8e90d71140a94bb"]) { homedData in
            //print("homedData",homedData)
        } success: { [self] operation,responseObject in
            
            let respVO:SubscriptJsonVO = Mapper().map(JSONObject: responseObject)!
            
            let listActiveArr = respVO.active_subscription
            let listInActiveArr = respVO.inactive_subscription
            
            self.active_subscription = listActiveArr!
            print("self.active_subscription.active_subscription",self.active_subscription.count,self.active_subscription)
            self.inactive_subscription = listInActiveArr!
            
            DispatchQueue.main.async {
            self.my_SubscriptionTable.reloadData()
            }
            
        } failure: {operation, error in
            print("error",error)
        }
    }

}
extension MySubscriptionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return active_subscription.count
        }else {
            return inactive_subscription.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let listTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SubList1TableViewCell", for: indexPath) as! SubList1TableViewCell
            listTableViewCell.lbl_title.text = active_subscription[indexPath.row].plan_title ?? ""
            listTableViewCell.lbl_expiredate.text = active_subscription[indexPath.row].expire_date ?? ""

            return listTableViewCell

        }else{
            let listTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SubListTableViewCell", for: indexPath) as! SubListTableViewCell
            
            return listTableViewCell

        }

        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 320

        }else {
            return 60
        }
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0{
               return "Subcription Active "
           }else{
              return "Subcription History"
         }
     }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 40
        }else{
            return 40
        }
    }
}
