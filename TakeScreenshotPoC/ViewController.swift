 //
//  ViewController.swift
//  TakeScreenshotPoC
//
//  Created by Maximilian Gerlach on 2014-07-13.
//  Copyright (c) 2014 Maximilian Gerlach. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
	// MARK: Properties
	let url = "http://www.klick.com"
	@IBOutlet var webView: UIWebView
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIApplication.sharedApplication().statusBarHidden = true
		
		configureWebView()
		loadAddressURL()
		
		delay(5){
			let screenshot = self.webView.screenshot()
			println("Done")
		}
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
	
	func configureWebView() {
		webView.backgroundColor = UIColor.whiteColor()
		webView.scalesPageToFit = true
		webView.dataDetectorTypes = .All
		webView.delegate = self
	}
	
	// MARK: Convenience
	func loadAddressURL() {
		let requestURL = NSURL(string: url)
		let request = NSURLRequest(URL: requestURL)
		webView.loadRequest(request)
	}
	
	
	// MARK: UIWebViewDelegate
	func webViewDidStartLoad(_: UIWebView) {
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
	}

	func webViewDidFinishLoad(webView: UIWebView) {
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
		

	}

	func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
		// Report the error inside the web view.
		let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
		let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
		
		webView.loadHTMLString(errorHTML, baseURL: nil)
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
}

