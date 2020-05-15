//
//  StockDetailViewController.swift
//  SaaS Smart
//
//  Created by Ahmed Ahmed on 5/2/20.
//  Copyright © 2020 Ahmed.org. All rights reserved.
//

/*
Disclaimer: This App is developed as an educational project
 */

import Foundation
import UIKit
import WebKit

class StockDetailViewController : UIViewController {
    
    
    @IBOutlet weak var btnYahoo: UIButton!
    @IBOutlet weak var video: WKWebView!	
    @IBOutlet weak var chart: UIImageView!
    
    @IBAction func btnYahoo(_ sender: Any) {
        let urlAddress:String = StockDetail.YahooFinanceLink
        let app = UIApplication.shared
        let urlw = URL(string:urlAddress)
        app.open(urlw!)
        
    }
    
    func getExternalImage(named imageName:String) -> UIImage{
        let url = URL(string: imageName)
        let dataBytes = try? Data(contentsOf:url!)
        let img = UIImage(data: dataBytes!)
        return img!
    }
    
    @IBOutlet weak var lblName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = "Ticker Symbol: " + StockDetail.Ticker
        chart.image = getExternalImage(named: StockDetail.Analyst)
        
        //Styling the button
        btnYahoo.layer.cornerRadius = btnYahoo.frame.height / 2
        btnYahoo.layer.shadowColor = UIColor.darkGray.cgColor
        btnYahoo.layer.shadowRadius = 25
        btnYahoo.layer.shadowOpacity = 1.0
        btnYahoo.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        //Bringing in Video
        let myURL = URL (string: StockDetail.Video)
        let myRequest = URLRequest (url: myURL!)
        video.load(myRequest)
        
        
        
    }
    
    var StockDetail : Stock = Stock()
    
}
