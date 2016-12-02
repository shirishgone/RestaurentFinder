//
//  RFAWebViewController.swift
//  RestaurentFinder
//
//  Created by shirish gone on 03/11/16.
//  Copyright © 2016 Shirish. All rights reserved.
//

import UIKit

class RFAWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadWebViewWith(urlString:RFAConstants.WebView.BottleRocketUrl)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    func loadWebViewWith(urlString: String)
    {
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        self.webView.loadRequest(urlRequest)
    }

    // ToolBar Button Action methods
    @IBAction func backButtonTouched(_ sender: UIBarButtonItem)
    {
        if self.webView.canGoBack {
            self.webView.goBack();
        }
    }

    @IBAction func refreshButtonTouched(_ sender: UIBarButtonItem)
    {
        self.webView.reload();
    }
    
    @IBAction func forwardButtonTouched(_ sender: UIBarButtonItem)
    {
        if self.webView.canGoForward
        {
            self.webView.goForward();
        }
    }
    
    // WebView Delegate methods to showing activity indicator
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        self.activityIndicator.stopAnimating()
    }
}
