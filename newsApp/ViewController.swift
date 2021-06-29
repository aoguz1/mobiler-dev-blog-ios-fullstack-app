//
//  ViewController.swift
//  newsApp
//
//  Created by Abdullah Oğuz on 24.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    @IBOutlet weak var tableView: UITableView!
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        getData {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = news[indexPath.row].title.capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewsTableViewController{
            destination.newsData = news[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    
    func getData(complated: @escaping () -> ()) {
        
        
        let url = URL(string: "https://news-app-mobiler.herokuapp.com/public/v1/News/")
       let task =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
          
            
            if error == nil {
                
                do {
                    self.news = try JSONDecoder().decode([News].self, from: data!)
                    
                    DispatchQueue.main.async {
                        complated()
                    }
                } catch  {
                    print("JSON ERROR")
                }
            }
        }
        task.resume()
    }

}

