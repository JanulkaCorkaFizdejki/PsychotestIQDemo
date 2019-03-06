//
//  IQTestResult.swift
//  Psychotests
//
//  Created by Robert Nowiński on 01/03/2019.
//  Copyright © 2019 Robert Nowiński. All rights reserved.
//

import UIKit


class IQTestResult: UIViewController {

     let ServerRq = ServerAction()
    let user_data_tests = UserDefaults.standard
    
    var checkUpload: Int = 0
    
    @IBOutlet weak var lbl_test_result: UILabel!
    @IBOutlet weak var lbl_test_result_2: UILabel!
    
    
    @IBOutlet weak var lbl_server_info: UILabel!
    @IBOutlet weak var btn_save_result: UIButton!
    @IBOutlet weak var btn_start: UIButton!
    
    
    @IBAction func btn_action_save_result(_ sender: UIButton) {
        if checkUpload == 0 {
        let result = user_data_tests.integer(forKey: "pointsresult")
            ServerRq.UploadDataServer(testNumberIn: 1, sumOfPiontsIn: result, info: lbl_server_info)
            checkUpload = 1
            
            let alert = UIAlertController(title: "TEST ZOSTAŁ ZAPISANY", message: "Jeśli chcesz zobaczyć wyniki wszystkich Twoich testów, przejedź do zakładki \"MOJE TESTY\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default){
                _ in
                return
            })
                present(alert, animated: true, completion: nil)
        }
        
        if checkUpload == 1 {
            btn_save_result.isEnabled = false
        }

    }

    
    @IBAction func btn_action_start(_ sender: UIButton) {
         performSegue(withIdentifier: "backstart", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_save_result.layer.cornerRadius = 10
        btn_start.layer.cornerRadius = 10

        let result = user_data_tests.integer(forKey: "pointsresult")
        
        lbl_test_result.text =  "\(result) pkt."
        lbl_test_result_2.text = "Co stanowi \(result)0% prawidłowych odpowiedźi"

    }
}
