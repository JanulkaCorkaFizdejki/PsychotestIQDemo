//
//  ViewController.swift
//  Psychotests
//
//  Created by Robert Nowiński on 28/02/2019.
//  Copyright © 2019 Robert Nowiński. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btn_test_iq: UIButton!
    @IBOutlet weak var btn_moje_testy: UIButton!
    
    /* AKCJA: Przejedź do widoku testu IQ. Przejeście jest możliwe tylko wówczas, kiedy
     użytkownik ma dostęp do Internetu
     */
    @IBAction func btn_test_iq_action(_ sender: UIButton) {
        if CheckInternet.Connection() {
               performSegue(withIdentifier: "test_iq_start", sender: self)
        } else {
            let alert = UIAlertController(title: "BRAK POŁĄCZENIA Z INTERNETEM!", message: "Aby wykonać test musisz mieć dostęp do Internetu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default){
                _ in
                return
            })
            present(alert, animated: true, completion: nil)
        }
    }
 // -----------------------------------------------------------------------

    /* AKCJA: Przejedź do widoku "lista wykonanych testów". Przejeście jest możliwe tylko wówczas, kiedy użytkownik ma dostęp do Internetu
     */
    @IBAction func btn_show_user_tests_action(_ sender: UIButton) {
        if CheckInternet.Connection() {

            
            performSegue(withIdentifier: "show_user_tests", sender: self)
        } else {
            let alert = UIAlertController(title: "BRAK POŁĄCZENIA Z INTERNETEM!", message: "Aby zobaczyć swoje wyniki z testów musisz mieć dostęp do Internetu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default){
                _ in
                return
            })
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let serwerAction = ServerAction()
        serwerAction.ShowMyTests()
        btn_test_iq.layer.cornerRadius = 10
        btn_moje_testy.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var shouldAutorotate: Bool {
        if UIDevice.current.orientation.isLandscape == false {
             return true
        }
        else {
            return false
        }
    }

}

