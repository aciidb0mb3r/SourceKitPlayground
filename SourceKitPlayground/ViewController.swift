//
//  ViewController.swift
//  SourceKitPlayground
//
//  Created by Ankit Aggarwal on 17/06/16.
//  Copyright © 2016 ankit.im. All rights reserved.
//

import Cocoa
import Foundation

class ViewController: NSViewController {

    @IBOutlet var inputTextView: NSTextView!
    @IBOutlet var outputTextView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.isAutomaticQuoteSubstitutionEnabled = false
        outputTextView.isAutomaticQuoteSubstitutionEnabled = false
        inputTextView.font = NSFont.userFont(ofSize: 21)
        outputTextView.font = NSFont.userFont(ofSize: 21)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func playButtonPressed(_ sender: NSButton) {
        guard let inputString = inputTextView.string else { return }
        do {
            guard let data = inputString.data(using: String.Encoding.utf8) else { return }
            let json = try JSONSerialization.jsonObject(with: data)
            guard case let dict as [String: AnyObject] = json else {
                print("Bad json \(json)")
                return
            }

            let doc = try request(dict: dict)
            let result = try sourceKitJSONString(data: doc)
            outputTextView.string = result
        } catch {
            outputTextView.string = "\(error)"
            print("error \(error)")
        }
    }
}
