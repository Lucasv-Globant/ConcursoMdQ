//
//  ActivitiesViewControllerSwift.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/20/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import UIKit

class ActivitiesViewControllerSwift: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak private var tableActivities: UITableView!
    var activitiesData : NSArray
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        activitiesData = NSArray()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableActivities.registerNib(UINib(nibName: "ActivityTableViewCell",
                                    bundle: NSBundle.mainBundle()),
                                    forCellReuseIdentifier: "ActivityTableViewCell")
        
        
        self.tableActivities.backgroundColor = UIColor.clearColor()
        self.tableActivities.separatorColor = UIColor.clearColor()
        self.tableActivities.opaque = false
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mdq-bg1.jpg")!)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesData.count*2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row % 2 == 0 {
            return 80
        } else {
            return 20
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
        
    
    
}
