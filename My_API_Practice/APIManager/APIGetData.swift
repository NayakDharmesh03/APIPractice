//
//  APIGetData.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import UIKit

class APIGetData: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    var todos: [APIData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    

    @IBAction func FetchDataButtonAction(_ sender: UIButton) {
        getData()
    }
    func getData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
                    return
                }

            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, error == nil else {
                        // Handle the error
                        return
                    }

                    do {
                        self?.todos = try JSONDecoder().decode([APIData].self, from: data)
                        DispatchQueue.main.async {
                            self?.myTable.reloadData()
                        }
                    } catch {
                        // Handle the error
                    }
            }.resume()
    }

}
extension APIGetData : UITableViewDataSource{
    // Implement UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GetDataCell
        let todo = todos[indexPath.row]
        cell.idLbl.text = String(todo.id)
        cell.titleLbl.text = todo.title
        cell.completedResultLbl.text = todo.completed ? "Completed" : "Incomplete"
        return cell
    }

    
    
}
