//
//  ViewController.swift
//  sections
//
//  Created by jeyaram-pt4154 on 11/05/21.
//

import UIKit
struct DataToShown {
    var head : String
    var body : String
    var color : UIColor
}
class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var tappedSection: Int = 0
}
class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var tableView: UITableView!
    var textColor = UIColor(red: 99/255, green: 111/255, blue: 126/255, alpha: 1)
    var textColorForHeader = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 1)
    
    var data = [DataToShown]()
    
    var descriptionData = [[DataToShown]]()
    let datatoAdd = DataToShown(head: "Sign Out", body: "Your account will be logged out",color: UIColor.red)
    
    var sectionNames = ["Fixed","Auto Dimension","Calculated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        data.append(DataToShown(head: "App Defaults", body: "Choose default conversation, reply mode and reply behaviours",color: textColor))
        data.append(DataToShown(head: "Siri Shortcuts", body: "Configure to get stats at your cell",color: textColor))
        data.append(DataToShown(head: "Privacy & Security", body: "Explore the ways to increase the security and privacy of your account",color: textColor))
        
        data.append(DataToShown(head: "Refresh portal metadata", body: "Admin level modifications made accross the portal will be synced with app ",color: textColor))
        data.append(DataToShown(head: "Reset the app", body: "Removes the customization made ad takes Radar to it's initial state",color: UIColor.red))
        data.append(datatoAdd)
        
        descriptionData.append(data)
        descriptionData.append(data)
   
        data.removeAll()
        
        data.append(DataToShown(head: "App Defaults", body: "Choose default conversation, reply mode and reply behaviours",color: textColor))
        data.append(DataToShown(head: "Siri Shortcuts", body: "Configure to get stats at your cell Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",color: textColor))
        data.append(DataToShown(head: "Privacy & Security", body: "Explore the ways to increase the security and privacy of your account Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words.",color: textColor))
        
        data.append(DataToShown(head: "Refresh portal metadata", body: "Admin level modifications made accross the portal will be synced with app Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source",color: textColor))
        data.append(DataToShown(head: "Reset the app", body: "Removes the customization made ad takes Radar to it's initial state Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum'  by Cicero, written in 45 BC. ",color: UIColor.red))
        data.append(DataToShown(head: "Sign Out", body: "Your account will be logged out Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance.",color: UIColor.red))
        
        descriptionData.insert(data, at: 1)
      
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.layoutMargins = UIEdgeInsets.zero
//        tableView.separatorInset = UIEdgeInsets.zero
//        tableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        tableView.separatorStyle = .none
        
       
     
       
    }


}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return descriptionData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
       

        cell.bioLabel.text = descriptionData[indexPath.section][indexPath.row].body
        cell.headLabel.text = descriptionData[indexPath.section][indexPath.row].head
        
        cell.bioLabel.textColor = UIColor(red: 99/255, green: 111/255, blue: 126/255, alpha: 1)
        
     
        cell.headLabel.textColor = descriptionData[indexPath.section][indexPath.row].color
        cell.seperator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.descriptionData[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            }
        
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

            return swipeActions
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        let label = UILabel()
        label.text = "Add more..."
        label.textAlignment = .center
        label.textColor = textColorForHeader
        label.frame = CGRect(x: 0, y: 5, width: UIScreen.main.bounds.width, height: 35)
        footerView.addSubview(label)
        let emptySpace = UIView()
        emptySpace.backgroundColor = UIColor.systemBackground
        emptySpace.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 15)
        footerView.addSubview(emptySpace)
        
        let tapRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            tapRecognizer.delegate = self
        tapRecognizer.tappedSection = section
            tapRecognizer.numberOfTapsRequired = 1
        
            tapRecognizer.numberOfTouchesRequired = 1
            footerView.addGestureRecognizer(tapRecognizer)
        return footerView
    }
    
    @objc func handleTap(sender: CustomTapGestureRecognizer)
    {
       let sec = sender.tappedSection
        let newIndexPath = IndexPath(row: descriptionData[sec].count, section: sec)
        descriptionData[sec].append(datatoAdd)
        tableView.insertRows(at: [newIndexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView() //set these values as necessary
        returnedView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)

        let label = UILabel()
        label.text = sectionNames[section]
        label.textColor = textColorForHeader
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.frame = CGRect(x: 25, y: 5, width: 400, height: 35)
        returnedView.addSubview(label)

        return returnedView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        switch indexPath.section{
        case 0: return 120
        case 1: return UITableView.automaticDimension
        case 2: return UITableView.automaticDimension
        default: return 0
        }
        
    }
    
}

// custom seperator
