
//
//  ViewController.swift
//  Laborator3
//
//  Created by user216460 on 8/31/22.
//

import UIKit


struct NasaNewsModel: Decodable{
    var items: [Item] = []
}

struct Item: Decodable{
    //let id:Int
    let title: String
    let date: String
    //let body: String
    
    //campurile trebuie sa se potriveasca cu json
    //Coding keys ptr a schimba
}
class ViewController: UIViewController {
    
    
    private var model = NasaNewsModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestItems()
        // Do any additional setup after loading the view.
    }
    
    private func requestItems(){
        let pathString = "https://mars.nasa.gov/api/v1/news_items/?page=0&per_page=10&order=publish_date+desc,created_at+desc"
        let url = URL(string: pathString)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let _ = error{
                //print("here::",error.localizedDescription)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let data = data else {return}
            guard let welf = self else {return}

            guard let items = try? jsonDecoder.decode(NasaNewsModel.self, from: data) else {return}
            welf.model.items = items.items //sau self?. fara welf
            DispatchQueue.main.async {
                welf.tableView.reloadData() // sau self?. fara welf
                
            }
        
            //print(items)
  
        }
        task.resume()
    }
    
    private func configure(){
        title = "NasaNews"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NasaNewsTableViewCell.self, forCellReuseIdentifier: NasaNewsTableViewCell.cellId)
    }
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaNewsTableViewCell.cellId, for: indexPath) as? NasaNewsTableViewCell else {return UITableViewCell()}
        
        //let model = NasaNewsTableViewCellModel(title: "title", date: "date\(indexPath.row)")
        let cellModel = model.items[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //2
        model.items.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



























































