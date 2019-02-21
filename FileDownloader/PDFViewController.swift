//
//  PDFViewController.swift
//  FileDownloader
//
//  Created by Feras Allaou on 2/21/19.
//  Copyright © 2019 Feras Allaou. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfView = PDFView()
    var fileURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pdfView)
        
        if let doc = PDFDocument(url: fileURL) {
            pdfView.document = doc
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }

}


