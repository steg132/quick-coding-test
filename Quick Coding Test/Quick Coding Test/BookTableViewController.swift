//
//  BookTableViewController.swift
//  Quick Coding Test
//
//  Created by Ryan Schumacher on 7/27/16.
//  Copyright © 2016 Ryan Schumacher. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {

	var books: [Book] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Kick off downloading Books here
		

    }
	
	func downloadBooks() {
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let _cell = tableView.dequeueReusableCellWithIdentifier("bookCell", forIndexPath: indexPath)

		if let cell = _cell as? BookCell {
			cell.loadBook( books[indexPath.row] )
		}
		

        return _cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
