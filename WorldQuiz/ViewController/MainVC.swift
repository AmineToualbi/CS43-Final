//
//  ViewController.swift
//  WorldQuiz
//
//  Created by Yong Liang on 4/13/20.
//  Copyright © 2020 ToualbiApps. All rights reserved.
//

import UIKit

class MainVC : UITableViewController {
    
    var countries=["Germany","China","UK","Japan","France"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title="World Quiz"
        navigationController?.navigationBar.prefersLargeTitles=true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizItem", for: indexPath)
        let quizLeftUncomplete = getQuizStatus(country: countries[indexPath.row])
        if quizLeftUncomplete == true {
            cell.textLabel?.text = countries[indexPath.row] + " (in progress)"
        }
        else {
            cell.textLabel?.text=countries[indexPath.row]
        }
        cell.imageView?.image=UIImage(named:countries[indexPath.row])
        return cell
    }
    
    func getQuizStatus(country: String) -> Bool {
        let quizToCompleteKey = "\(country)-to-complete"
        let defaults = UserDefaults.standard
        let completed = defaults.bool(forKey: quizToCompleteKey)
        print("getQuizStatus() called.")
        print("KEY = \(quizToCompleteKey) & VALUE = \(completed)")
        return completed
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if previousQuizCompleted(quizIndex: indexPath.item-1) == true {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Quiz") as? QuizVC {
                vc.quizCountry = countries[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            showQuizIncompleteAlert()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func previousQuizCompleted(quizIndex: Int) -> Bool {
        if quizIndex < 0 {
            return true
        }
        let completedQuizKey = "\(countries[quizIndex])-completed"
        let defaults = UserDefaults.standard
        let completed = defaults.bool(forKey: completedQuizKey)
        print("KEY = \(completedQuizKey) & VALUE = \(completed)")
        return completed
    }
    
    func showQuizIncompleteAlert() {
        let alert = UIAlertController(title: "Cannot access the quiz", message: "You need to complete the previous quizzes before attempting a new one.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))

        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
