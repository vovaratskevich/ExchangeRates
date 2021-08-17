//
//  ViewController.swift
//  MyApp
//
//  Created by Vladimir Ratskevich on 13.08.21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var exchengeRates: ExchangeRatesSum?
    var rates: [Rates]?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkSessions.shared.loadExchange { result in
            switch result {
            case .success(let fetchedExchangeRates):
                DispatchQueue.main.async {
                    self.exchengeRates = fetchedExchangeRates
                    self.rates = fetchedExchangeRates.rates
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func cutMyString(_ str: String?, offsetBy num: Int) -> String {
        let index = str!.index(str!.startIndex, offsetBy: num)
        return String(str![..<index])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchengeRates?.rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        (cell as? TableViewCell)?.fromLabel.text = rates?[indexPath.row].currMnemFrom
        (cell as? TableViewCell)?.toLable.text = rates?[indexPath.row].currMnemTo
        (cell as? TableViewCell)?.buyLabel.text = cutMyString(rates?[indexPath.row].buy, offsetBy: 4)
        (cell as? TableViewCell)?.saleLable.text = cutMyString(rates?[indexPath.row].sale, offsetBy: 4)
        return cell
    }
}

