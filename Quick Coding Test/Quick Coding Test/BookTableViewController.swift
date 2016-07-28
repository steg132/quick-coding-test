//
//  BookTableViewController.swift
//  Quick Coding Test
//
//  Created by Ryan Schumacher on 7/27/16.
//  Copyright © 2016 Ryan Schumacher. All rights reserved.
//

import UIKit

let catalogURL = "http://de-coding-test.s3.amazonaws.com/books.json"

class BookTableViewController: UITableViewController {

	var books: [Book] = []
	var dataTask: NSURLSessionDataTask?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Kick off downloading Books here
		downloadBooks()

    }
	
	func downloadBooks() {
		guard let url = NSURL(string: catalogURL) else {
			// failed to build url. Bail out
			return
		}
		if dataTask != nil {
			dataTask?.cancel()
		}
		dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler:
			{ (_data, response, error) in
				// an error may be called in the following conditions:
				// - Data Task was canceled
				// - Network request failed
				// In either case, drop it on the floor
				guard let data = _data where error == nil,
					// TRY to serialize the json
					let _json = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
					// Unwrap try optional, and check if this is an array of objects
					let json = _json as? [AnyObject] else {
						
					return // Bail on failure
				}
				
				// process books on the background thread
				var books: [Book] = []
				for object in json {
					if let title = object["title"] as? String,
						let szImageUrl = object["imageURL"] as? String,
						let imageURL = NSURL(string: szImageUrl) {
						books.append(Book(title: title, imageUrl: imageURL))
					}
				}
				// Update UI on main thread
				dispatch_async(dispatch_get_main_queue(), { 
					self.books = books
					self.tableView.reloadData()
				})
				
				
				
		})
		dataTask?.resume()
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
