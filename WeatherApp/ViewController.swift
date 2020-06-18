//
//  ViewController.swift
//  WeatherApp
//
//  Created by macbook on 13.06.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet var successResponce: UILabel!
//    @IBOutlet var errorCodeResponce: UILabel!
    @IBOutlet weak var errorNumber: UILabel!
    @IBOutlet weak var message: UILabel!
    //    @IBOutlet var message: [UILabel]!
    @IBOutlet weak var searchBar: UISearchBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        
        let urlString = "https://api.weatherstack.com/current?access_key=065a33851220a1f9563d88869ad2bfcd&query=\(searchBar.text!)"
        let url = URL (string: urlString)
        
//        var locationName: String?
        var requestFull: String?
//        var typeLocation: String?
//        var errorCode: Int8?
        var successRequest: Bool?
//        var temperature:  Double?
        
        let task = URLSession.shared.dataTask(with: url! ){[weak self] (data, responce, error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options:  .mutableContainers)
                as! [String : AnyObject]
                
                if let success = json["success"] {
                    successRequest = success as? Bool
//                    print(successRequest!)
//                    typeLocation = request["type"] as? String
                }
                
                if let error = json["error"] {
                    requestFull = error["info"] as? String
//                    print(requestFull!)
                }
                
                DispatchQueue.main.async {
                    self?.message.text = "\(successRequest!)"
                    self?.errorNumber.text = requestFull
                }
            }
            catch let jsonError{
                print(jsonError)
            }
        }
        task.resume()
    }
}
