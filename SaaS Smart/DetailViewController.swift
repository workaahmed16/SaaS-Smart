//
//  DetailViewController.swift
//  SaaS Smart
//
//  Created by Ahmed Ahmed on 5/1/20.
//  Copyright © 2020 Ahmed.org. All rights reserved.
//

/*
Disclaimer: This App is developed as an educational project
 */

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var btnSeeMore: UIButton!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    func getExternalImage(named imageName:String) -> UIImage{
        let url = URL(string: imageName)
        let dataBytes = try? Data(contentsOf:url!)
        let img = UIImage(data: dataBytes!)
        return img!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        detailDescriptionLabel.text = selectedStock.Name
        imgLogo.image = getExternalImage(named: selectedStock.Picture)
        lblDiscription.text = selectedStock.Description
        
        //Styling the button
        btnSeeMore.layer.cornerRadius = btnSeeMore.frame.height / 2
        btnSeeMore.layer.shadowColor = UIColor.darkGray.cgColor
        btnSeeMore.layer.shadowRadius = 25
        btnSeeMore.layer.shadowOpacity = 1.0
        btnSeeMore.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showStockDetail") {
            let controller = segue.destination as! StockDetailViewController
            controller.StockDetail = selectedStock
        }
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    var selectedStock: Stock = Stock()
    

}

