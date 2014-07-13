//
//  ScreenshotExtension.swift
//  TakeScreenshotPoC
//
//  Created by Maximilian Gerlach on 2014-07-13.
//  Copyright (c) 2014 Maximilian Gerlach. All rights reserved.
//

import Foundation
import UIKit


extension UIWebView {
	//http://stackoverflow.com/questions/20610513/is-it-possible-to-capture-a-screenshot-of-a-whole-webpage-in-the-ios-simulator
	func screenshot() -> UIImage {
		var pngImg: NSData
		var max : CGFloat, scale: CGFloat = 1.0
		let viewSize = self.bounds.size
		
		// Get the size of the the FULL Content, not just the bit that is visible
		let size = self.sizeThatFits(CGSizeZero)
		
		// Scale down if on iPad to something more reasonable
		/*
		max = (viewSize.width > viewSize.height) ? viewSize.width : viewSize.height;
		if( max > 960 )
		scale = 960/max;
		*/
		
		UIGraphicsBeginImageContextWithOptions( size, true, scale );
		
		// Set the view to the FULL size of the content.
		self.frame = CGRectMake(0, 0, size.width, size.height)
		
		let context = UIGraphicsGetCurrentContext();
		self.layer.renderInContext(context)

		pngImg = UIImagePNGRepresentation( UIGraphicsGetImageFromCurrentImageContext() );
		
		UIGraphicsEndImageContext();
		
		return UIImage(data: pngImg);
	}
}

func delay(delay:Double, closure:()->()) {
	dispatch_after(
		dispatch_time(
			DISPATCH_TIME_NOW,
			Int64(delay * Double(NSEC_PER_SEC))
		),
		dispatch_get_main_queue(), closure)
}