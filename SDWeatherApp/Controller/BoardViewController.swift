//
//  BoardViewController.swift
//  SDWeatherApp
//
//  Created by Arpit Lokwani on 7/14/18.
//  Copyright © 2018 SD. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var boardImageView: UIImageView!
    let weatherService = WeatherService()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.showAlert(title: "Place", message: "Please enter location")

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func getCityDetails(place:String) -> Void {
        weatherService.getWeatherReport(place:place,completetionHandler: { (success, reponseDict, responseString, error) in
            if success!{
                DispatchQueue.main.async {
                    self.moveToWeatherViewController()
                }
            }else{
                self.showOKAlertView(title: "Error", message:responseString! as String )
            }
        }) { (error) in
           
            print(error)
        }
    }
}

extension BoardViewController{
    func showAlert(title:String,message:String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            guard let textFields = alertController.textFields,
                textFields.count > 0 else {
                    // Could not find textfield
                    return
            }

            let field = textFields[0]
            // store your data
            UserDefaults.standard.set(field.text, forKey: "place")
            UserDefaults.standard.synchronize()
            
            if(field.text?.count == 0){
                self.showOKAlertView(title: "Error", message: Constant.locationMessage)
            }else{
                self.getCityDetails(place:field.text!)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            self.showAlert(title: Constant.locationTitle, message: Constant.locationMessage)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter location"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOKAlertView(title:String,message:String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.showAlert(title: Constant.locationTitle, message: Constant.locationMessage)
            
        }
        
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func moveToWeatherViewController() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(viewController, animated: true)

    }
}
