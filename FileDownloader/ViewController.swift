//
//  ViewController.swift
//  FileDownloader
//
//  Created by Feras Allaou on 2/21/19.
//  Copyright © 2019 Feras Allaou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let fileURL = "http://feras.ws/CV.pdf"
    var downloadedFileURL: URL! {
        didSet {
            DispatchQueue.main.async {
                self.openPDFBtn.isEnabled = true
            }
            
        }
    }
    
    
    @IBOutlet weak var openPDFBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        openPDFBtn.isEnabled = false
        
    }

    
    @IBAction func downloadFIle(_ sender: UIButton) {
        downloadFile(with: fileURL)
    }
    
    
    @IBAction func openPDF(_ sender: UIButton) {
        let PDFView = PDFViewController()
        PDFView.fileURL = downloadedFileURL
        present(PDFView, animated: false, completion: nil)
    }
    
    
    func downloadFile(with url:String){
        guard let url = URL(string: fileURL) else { return }
        
        let downloadSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        let downloadTask = downloadSession.downloadTask(with: url)
        downloadTask.resume()
        
    }

}

extension ViewController: URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

        
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.downloadedFileURL = destinationURL
            print(downloadedFileURL)
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}

