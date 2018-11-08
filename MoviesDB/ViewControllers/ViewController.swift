//
//  ViewController.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 07/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else {
            print("Couldn't create cell")
            fatalError("Couldn't create cell")
        }
        cell.setup(name: "filme")
        return cell
    }

    
}

