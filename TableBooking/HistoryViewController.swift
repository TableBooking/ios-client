//
//  HistoryViewController.swift
//  TableBooking
//
//  Created by Nikita Kirichek on 11/30/16.
//  Copyright © 2016 Nikita Kirichek. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let numberOfSectionsForTable = 2
    let heightForCell = 130
    
    @IBOutlet weak var orderHistory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderHistory.backgroundColor = Color.TBBackground
        navigationController?.navigationBar.barTintColor = Color.TBGreen
        navigationController?.navigationBar.barStyle = .black;
        navigationItem.title = "History"
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
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightForCell)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSectionsForTable
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "historyItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryItemTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Active"
        case 1:
            return "Previous"
        default:
            return ""
        }
    }
}











