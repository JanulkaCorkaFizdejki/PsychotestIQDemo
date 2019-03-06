//
//  IQTest.swift
//  Psychotests
//
//  Created by Robert Nowiński on 28/02/2019.
//  Copyright © 2019 Robert Nowiński. All rights reserved.
//

import UIKit
import Foundation

class IQTest: UIViewController{
    
    
    @IBOutlet weak var btn_start: UIButton!
    
    @IBOutlet weak var lbl_question: UITextView!
    @IBOutlet weak var lbl_timer: UILabel!
    @IBOutlet weak var lbl_test_count: UILabel!
    
    
    @IBOutlet weak var btn_answ1: UIButton!
    @IBOutlet weak var btn_answ2: UIButton!
    @IBOutlet weak var btn_answ3: UIButton!
    
    @IBOutlet weak var answer_1: UILabel!
    @IBOutlet weak var answer_2: UILabel!
    @IBOutlet weak var answer_3: UILabel!
    
    let ServerRq = ServerAction()
    let user_data_tests = UserDefaults.standard
    let time_limit: Int = 20 // Zmienna określająca czas na odpowieź w danym pytaniu
    var points_result: Int = 0
    
    
    
    // Przyciski wyboru odpowiedźi
    var checker_button: Int = 0
    @IBAction func btn_answers(_ sender: UIButton) {
        nonSelecrButton ()
        let tittle = sender.currentTitle
        sender.setImage(UIImage(named: "select"), for: .normal)
        switch tittle {
        case "1":
            checker_button = 1
        case "2":
            checker_button = 2
        case "3":
            checker_button = 3
        default:
            return
        }
    }
    


    func nonSelecrButton () -> Void {
        btn_answ1.setImage(UIImage(named: "no_select"), for: .normal)
        btn_answ2.setImage(UIImage(named: "no_select"), for: .normal)
        btn_answ3.setImage(UIImage(named: "no_select"), for: .normal)
    }

    
    // Kod timera ---------------------------------------------
    var timmerTest: Timer? = nil
    
    
    func StopTimmerTestIQ () {
        timmerTest?.invalidate()
        timmerTest = nil
    }
    
    func StartTimmerTestIQ (time_limit: Int, output: UILabel) -> Void {
        var countStart = time_limit
        output.text = String (countStart)
        timmerTest = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            timmer in
            countStart -= 1
            output.text = String (countStart)
            
            if countStart == 0 {
                timmer.invalidate()
                if self.addTestQuestion () == false {
                     self.SaveResultAndGoToNextVC()
                }
            }
        })
    }
    
    // --------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_start.layer.cornerRadius = 10
        btn_answ1.setImage(nil, for: .normal)
        btn_answ2.setImage(nil, for: .normal)
        btn_answ3.setImage(nil, for: .normal)
        ServerRq.dataIQTests() // Instancja zwraca pulę testów wraz z odpowiedźmiami (3 tablice zapisane na tel)
    }
    
    
    var checker: Int = 0
    func addTestQuestion () -> Bool {
        let array_question = user_data_tests.array(forKey: "questions") as? [String] ?? [String]()
        let array_answers = user_data_tests.array(forKey: "answers") as? [String] ?? [String]()
        
        if checker < array_question.count + 1 {
            switch checker_button{
            case 1:
                if addPoints ()[0] == "1" {points_result += 1}
            case 2:
                if addPoints ()[1] == "1" {points_result += 1}
            case 3:
                if addPoints ()[2] == "1" {points_result += 1}
            default:
                checker_button = 0
            }
        }

        if checker < array_question.count {
            StopTimmerTestIQ ()
            StartTimmerTestIQ(time_limit: 20, output: lbl_timer)
            lbl_question.text =  array_question[checker]
            
             nonSelecrButton ()
            
            let current_array_answers = setThreeAnswOrVal(array: array_answers, currentIndex: checker)
                answer_1.text = "(1). " + " " + current_array_answers[0]
                answer_2.text = "(2). " + " " + current_array_answers[1]
                answer_3.text = "(3). " + " " + current_array_answers[2]
                lbl_test_count.text = "Pozostało pytań: \(array_question.count - (checker + 1)) / (\(array_question.count))"

                checker += 1
                checker_button = 0
            return true
        } else {
            return false
        }
    }
    
    // Funkcja zwraca 3 odpowiedźi lub wartości odpowiedźi do bieżącego pytania
    func setThreeAnswOrVal (array: [String], currentIndex: Int) -> [String] {
        var output_array = [String]()
        var arrayStart: Int = 0
        if currentIndex == 0 {
           arrayStart = currentIndex
        } else {arrayStart = (3 * currentIndex)}
        for var i in 0..<3 {
            output_array.append(array[arrayStart])
            i += 1
            arrayStart += 1
        }
        return output_array
    }
    
    func addPoints () -> [String] {
        let array_values = user_data_tests.array(forKey: "values") as? [String] ?? [String]()
        let current_array_values = setThreeAnswOrVal(array: array_values, currentIndex: checker - 1)
        return current_array_values
    }

    // button START!
    @IBAction func btn_start_test(_ sender: UIButton) {
        
        let titleThisButton = String (sender.currentTitle!)
        
        if titleThisButton == "START" {
            sender.setTitle("DALEJ", for: .normal)
        }
        
        if checker > 8 {
            sender.backgroundColor = UIColor.red
            sender.setTitle("ZAKOŃCZ", for: .normal)
        }
        
        if addTestQuestion () == true {
            
        } else {
            SaveResultAndGoToNextVC()
        }
    }
    
    func SaveResultAndGoToNextVC () -> Void {
        let user_save = UserDefaults.standard
        user_save.set(points_result, forKey: "pointsresult")
        performSegue(withIdentifier: "iq_test_iq", sender: self)
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
