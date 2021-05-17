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
struct sectionData{
    var header : String
    var footer : String
    var cells : [DataToShown]
}
struct Colors{
    static let headerbgcolor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
    static let textColor = UIColor(red: 99/255, green: 111/255, blue: 126/255, alpha: 1)
    
    static let textColorForHeader = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 1)
    static let seperatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
}

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var tableView: UITableView!
    var dataForSection = [sectionData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
//        tableView.separatorInset = UIEdgeInsets.zero
       
     
       
    }
    

    func setData(){
        
//        var data = [DataToShown]()
        let headData = ["App Defaults","Siri Shortcuts","Privacy & Security","Refresh portal metadata","Reset the app","Sign Out"]
        let bodyData = ["Choose default conversation, reply mode and reply behaviours","Configure to get stats at your cell","Explore the ways to increase the security and privacy of your account","Admin level modifications made accross the portal will be synced with app ","Removes the customization made ad takes Radar to it's initial state","Your account will be logged out"]
        let growingData = ["Choose default conversation, reply mode and reply behaviours","Configure to get stats at your cell Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.","Explore the ways to increase the security and privacy of your account Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words.","Admin level modifications made accross the portal will be synced with app Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source","Removes the customization made ad takes Radar to it's initial state Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum'  by Cicero, written in 45 BC. ","Your account will be logged out Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance."]
        let colorsData = [Colors.textColor,Colors.textColor,Colors.textColor,Colors.textColor,UIColor.red,UIColor.red]
        
        let result = headData.enumerated().map { DataToShown(head:$0.element, body: bodyData[$0.offset],color:colorsData[$0.offset])  }
        
        dataForSection.append(sectionData(header: "Fixed", footer: "Add More...", cells: result))
        
        let DataforSecondSection = headData.enumerated().map { DataToShown(head:$0.element, body: growingData[$0.offset],color:colorsData[$0.offset])  }

        
        dataForSection.append(sectionData(header: "Auto Dimension", footer: "Add 5 more rows", cells: DataforSecondSection))
        dataForSection.append(sectionData(header: "Calculated", footer: "Refresh", cells: result))
        
    }

}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    enum headerOrFooter{
        case header
        case footer
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataForSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataForSection[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
       
        let dataforCell = dataForSection[indexPath.section].cells[indexPath.row]
        cell.bioLabel.text = dataforCell.body
        cell.headLabel.text = dataforCell.head
        
//        cell.bioLabel.textColor = UIColor.clear
        
     
        cell.headLabel.textColor = dataforCell.color
        cell.seperator.backgroundColor = Colors.seperatorColor
//        cell.seperator.isHidden = true
       
//        cell.layoutMargins = UIEdgeInsets(top: 35, left: 160, bottom: 20, right: 15)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let contextItem = UIContextualAction(style: .destructive , title: "Delete") {  (contextualAction, view, boolValue) in
            self.dataForSection[indexPath.section].cells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            }
            return UISwipeActionsConfiguration(actions: [contextItem])
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
   
        let footerView = getHeaderOrFooter(set: dataForSection[section].footer, at: 0, in: .footer)
        
        guard let label = footerView.viewWithTag(100) else{
            return footerView
        }
        
        let emptySpace = UIView()
        emptySpace.backgroundColor = UIColor.systemBackground
        
        emptySpace.frame = CGRect(x: 0, y: (label.frame.maxY), width: UIScreen.main.bounds.width, height: 15)
        footerView.addSubview(emptySpace)
        
        let tapRecognizer = CustomTapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tapRecognizer.tappedSection = section
        tapRecognizer.numberOfTapsRequired = 2
        
        
        let tapRecognizer1 = CustomTapGestureRecognizer(target: self, action: #selector(handleTap1(sender:)))
        tapRecognizer1.tappedSection = section
        tapRecognizer1.require(toFail: tapRecognizer)
        
            footerView.addGestureRecognizer(tapRecognizer)
        footerView.addGestureRecognizer(tapRecognizer1)

//        for gesture in footerView.gestureRecognizers ?? []{
//            print(gesture)
//            footerView.removeGestureRecognizer(gesture)
//        }
      
        return footerView
    }
    @objc func handleTap1(sender: CustomTapGestureRecognizer){
        print("SDF")
    }
    @objc func handleTap(sender: CustomTapGestureRecognizer)
    {
    
        let cellForSection = dataForSection[sender.tappedSection].cells
        let randomNum = Int.random(in: 0..<cellForSection.count)
        
        switch sender.tappedSection{
        case 0: let newIndexPath = IndexPath(row: cellForSection.count, section: sender.tappedSection)
            dataForSection[sender.tappedSection].cells.append(cellForSection[randomNum])
                tableView.insertRows(at: [newIndexPath], with: .fade)
            
        case 1: var indexpatharray = [IndexPath]()
                for index in 0...4{
                    indexpatharray.append(IndexPath(row: dataForSection[sender.tappedSection].cells.count , section: sender.tappedSection))
                    dataForSection[sender.tappedSection].cells.append(cellForSection[index])
                }
                tableView.insertRows(at: indexpatharray, with: .fade)
            
        case 2: dataForSection[sender.tappedSection].cells.shuffle()
            tableView.reloadSections(IndexSet([1,2,2]), with: .fade)
            
        default : return
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = getHeaderOrFooter(set: dataForSection[section].header, at: 25, in: .header)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        switch indexPath.section{
        case 0: return 120
        case 1: return UITableView.automaticDimension
        case 2: return 100
//        case 2: return (tableView.frame.height*20)/100
        default: return 0
        }
        
    }
    
    func getHeaderOrFooter(set text: String,at position:Int,in headerOrFooter:headerOrFooter) -> UIView{
        let sectionView = UIView() //set these values as necessary
        sectionView.backgroundColor = Colors.headerbgcolor
        let label = UILabel()
        label.text = text
        if headerOrFooter == .footer{
            label.textAlignment = .center
        }
        label.textColor = Colors.textColorForHeader
        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.frame = CGRect(x: position, y: 5, width: Int(UIScreen.main.bounds.width), height: 35)
        let positionOfLabel = CGPoint(x: position, y: 5)
        let size = CGSize(width: tableView.frame.width, height: 35)
        label.frame = CGRect(origin: positionOfLabel, size: size)
        label.frame = CGRect(x: position, y: 5, width: tableView.frame.width, height: 35)
        label.tag = 100
//        label.frame = CGRect(x: position, y: 5, width: Int(sectionView.frame.width), height: 35)
        sectionView.addSubview(label)
        return sectionView
       
    }
    
}

extension CGRect{
    public init(x: Int, y: Int , width: CGFloat, height: Int){
        self.init(x: x, y: y, width: Int(width), height: height)
    }
        
    
}

// custom seperator

/*
         let contextItem1 = UIContextualAction(style: .destructive , title: "Delete1") {  (contextualAction, view, boolValue) in
             print("1")
 
             }
         let contextItem2 = UIContextualAction(style: .destructive , title: "Delete2") {  (contextualAction, view, boolValue) in
             print("2")
 
             }
         let contextItem3 = UIContextualAction(style: .destructive , title: "Delete3") {  (contextualAction, view, boolValue) in
             print("3")
 
             }
         let contextItem4 = UIContextualAction(style: .destructive , title: "Delete3") {  (contextualAction, view, boolValue) in
             print("4")

             }
 */
