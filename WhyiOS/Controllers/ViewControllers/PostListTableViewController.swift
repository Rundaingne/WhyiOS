//
//  PostListTableViewController.swift
//  WhyiOS
//
//  Created by Brooke Kumpunen on 3/20/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
        refreshData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        let post = PostController.shared.posts[indexPath.row]
        cell?.post = post
        // Configure the cell...

        return cell ?? UITableViewCell()
    }
    //UGH. Gotta do a delegate here for the cell.
    
    //MARK: - Methods
    func refreshData() {
        PostController.shared.fetchPosts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func presentAlertController() {
        
        let alertController = UIAlertController(title: "Create Post", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Cohort"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Reason"
        }
        
        let postAction = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let userName = alertController.textFields?[0].text,
                let cohort = alertController.textFields?[1].text,
                let reason = alertController.textFields?[2].text else {return}
            PostController.shared.postPost(cohort: cohort, name: userName, reason: reason, completion: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(postAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    //MARK: - Actions
    @IBAction func addPostButtonTapped(_ sender: UIBarButtonItem) {
        presentAlertController()
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        refreshData()
    }
}
