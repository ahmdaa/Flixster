//
//  MovieTrailerViewController.swift
//  Flixster
//
//  Created by Ahmed Abdalla on 2/9/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    
    var movie: [String: Any]!
    var movieVideos = [[String:Any]]()
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // webView.configuration.allowsInlineMediaPlayback = true
        
        let id = movie["id"] as! Int
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
              self.movieVideos = dataDictionary["results"] as! [[String:Any]]
            
              if(self.movieVideos.count > 0) {
                 let movieVideo = self.movieVideos[0]
                 let key = movieVideo["key"]!
                  
                 let Url = "https://www.youtube.com/embed/\(key)?playsinline=1"
                 let videoUrl = URL(string: Url)
                 let request = URLRequest(url: videoUrl!)
                 self.webView.load(request)
              }
           }
        }
        task.resume()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
