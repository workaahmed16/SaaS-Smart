//
//  MasterViewController.swift
//  SaaS Smart
//
//  Created by Ahmed Ahmed on 5/1/20.
//  Copyright © 2020 Ahmed.org. All rights reserved.
//

/*
Disclaimer: This App is developed as an educational project
 */

import UIKit

class MasterViewController: UITableViewController {
    var StockArray = [Stock]()


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //populateStocks()
        populateJSONData()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //Find the Selected Row
                let selectedS = StockArray[indexPath.row]
                // Find the segue 's destination controller
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //Set the Selected Object on the Controller's object
                controller.selectedStock = selectedS
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
        
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StockArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let selectedS = StockArray[indexPath.row]
        
        
        cell.textLabel!.text = selectedS.Name
        cell.detailTextLabel!.text = "P/E Ratio: " + selectedS.PERatio
        //cell.detailTextLabel!.text = String(selectedS.PERatio)
        
        //Displaying logo image
        let img = getExternalImage(named: selectedS.Logo)
        cell.imageView!.image = img
        return cell
    }


    //Getting the image from external source
    //convert to image type
    //display image on ImageView label
    
    func getExternalImage(named imageName:String) -> UIImage{
        let url = URL(string: imageName)
        let dataBytes = try? Data(contentsOf:url!)
        let img = UIImage(data: dataBytes!)
        return img!
    }
    
    func populateJSONData(){
        let endPoint = "https://raw.githubusercontent.com/workaahmed16/JSON-Stocks/master/stock2"
        //let endPoint = "http://www.protogic.com/universityservice/service.svc/AllHikingTrails"
        let jsURL:URL = URL(string: endPoint)!
        
         // 2. Call the Rest End point. by using the Data function
         let jsonData = try? Data (contentsOf: jsURL)
         print(jsonData ?? "ERROR: No Data To Print. JSONURLData is Nil")
        
        if (jsonData != nil) {
           
            //3. Receive the Incoming Data (JSON). In a Local Dictionary object
            let dictionary:NSDictionary =
                (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
        
        
        let stockDictionary = dictionary["Stocks"]! as! [[String:AnyObject]]
        
            for index in 0...stockDictionary.count - 1 {
                let singleStock  = stockDictionary[index]
                let s  = Stock()
                            
                s.Name = singleStock["Name"] as! String
                s.Ticker = singleStock["Ticker"] as! String
                s.PERatio = singleStock["PERatio"] as! String
                s.Logo = singleStock["Logo"] as! String
                s.Picture = singleStock["Picture"] as! String
                s.YahooFinanceLink = singleStock["YahooFinanceLink"] as! String
                s.Description = singleStock["Description"] as! String
                s.Video = singleStock["Video"] as! String
                s.Analyst = singleStock["Analyst"] as! String
               
                StockArray.append(s)
            }
        }
        
        
    }
    
    func populateStocks() {
         
            let s1 = Stock()
            s1.Name = "Axon Enterprise, Inc"
            s1.Ticker =  "AAXN"
            s1.PERatio = "7,271"
            s1.Logo = "https://www.safelogic.com/wp-content/uploads/2017/02/axon_logo2x.jpg"
            s1.Picture = "https://www.nokia.com/blog/sites/blog_nokia_com/files/styles/blog_post_image/public/blogs/1567749353900-750_23261.jpg"
            s1.YahooFinanceLink = "https://finance.yahoo.com/quote/AAXN/"
            s1.Description = "This company started out in Scottsdale, Arizona. Its initial product was tasers for law enforcement. It has evolved to sell body cameras and organize footage for law enforcement in cloud environments. Its a great company to invest in because its growing at a fast clip and it has a predictable income from contracts with large law enforcement agencies."
            StockArray.append(s1)
            
            
        }



}

