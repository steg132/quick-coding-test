//
//  BookCell.swift
//  Quick Coding Test
//
//  Created by Ryan Schumacher on 7/27/16.
//  Copyright © 2016 Ryan Schumacher. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
	
	@IBOutlet weak var spinnerView: UIActivityIndicatorView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var thumbView: UIImageView!
	
	var dataTask: NSURLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	
	func loadBook(book: Book) {
		titleLabel.text = book.title
		
		// Kick off data task to download thumbnail
		self.dataTask = NSURLSession.sharedSession().dataTaskWithURL(book.imageUrl)
		{ (_data, response, error) in
			
			// an error may be called in the following conditions:
			// - Data Task was canceled
			// - Network request failed
			// In either case, drop it on the floor
			guard let data = _data where error == nil  else {
				return // Bail
			}
			
			// Build UIImage with data
			let image = UIImage(data: data)
			// GO to main thread to update UI
			dispatch_async(dispatch_get_main_queue(),
			               {
							// Chack if request was canceled again?
							self.thumbView.image = image
			})
		}
	}
	override func prepareForReuse() {
		// reset cell state
		spinnerView.hidden = false
		titleLabel.text = ""
		thumbView.image = nil
		
		dataTask?.cancel()
		dataTask = nil
		
	}

}
