//
//  ViewController.swift
//  TringConnect
//
//  Created by Apple on 30/04/22.
//

import UIKit

enum PostKind : Int {
    case events = 0
    case postwithImage = 1
    case postwithCollage = 2
    case postwithImages = 3
    case postwithButton = 4
    case postwithCarousel = 5
}


class ViewController: UIViewController {

    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tableView: UITableView!
    var personDetails: [PersonDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        fetchDetails()
    }

    func initialSetup() {
        registerNib()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func fetchDetails() {
        fetchData {[weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func registerNib() {
        let nib = UINib(nibName: TCConstant.kEventNibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: TCConstant.kEventTableViewCellIdentifier)
        
        let nib1 = UINib(nibName: TCConstant.kImagePostNibName, bundle: nil)
        self.tableView.register(nib1, forCellReuseIdentifier: TCConstant.kImagePostTableViewCellIdentifier)
        
        let nib2 = UINib(nibName: TCConstant.kPostWithButtonTableViewCell, bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: TCConstant.kPostWithButtonTableViewCellIdentifier)
        
        let nib3 = UINib(nibName: TCConstant.kPostWithCarouselTableViewCell, bundle: nil)
        self.tableView.register(nib3, forCellReuseIdentifier: TCConstant.kPostWithCarouselTableViewCellIdentifier)
        
        let nib4 = UINib(nibName: TCConstant.kPostWithCollageTableViewCell, bundle: nil)
        self.tableView.register(nib4, forCellReuseIdentifier: TCConstant.kPostWithCollageTableViewCellIdentifier)
    }
    
    func fetchData(completion: @escaping (Bool) -> ()) {
        
        let url = URL(string: TCConstant.kApiURL)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                let decoder = JSONDecoder()

                do {
                let responseModel = try decoder.decode([PersonDetails].self, from: data)
                    print(responseModel)
                    self.personDetails  = responseModel
                    completion(true)
                } catch {
                print(error.localizedDescription)
                    completion(false)
                }
               
            }
            
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> PersonDetails? {
        
        var returnValue: PersonDetails?
        do {
            returnValue = try JSONDecoder().decode(PersonDetails.self, from: data)
        } catch {
            print("Error took place\(error.localizedDescription).")
        }
        
        return returnValue
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postKind = PostKind(rawValue: indexPath.row)
        switch postKind {
        case .events:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TCConstant.kEventTableViewCellIdentifier, for: indexPath) as? EventsTableViewCell else {
                return UITableViewCell()
            }
            cell.setupDataSource()
            return cell
        case .postwithImage:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TCConstant.kImagePostTableViewCellIdentifier, for: indexPath) as? ImagePostTableViewCell else {
                return UITableViewCell()
            }
            cell.navigationDelegate = self
            if personDetails.count > 0 {
                cell.setupDataSource(index: indexPath.row, person: personDetails[0])
            }
            return cell
        case .postwithCollage:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TCConstant.kPostWithCollageTableViewCellIdentifier, for: indexPath) as? PostWithCollageTableViewCell else {
                return UITableViewCell()
            }
            cell.navigationDelegate = self
            return cell
        case .postwithImages:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TCConstant.kImagePostTableViewCellIdentifier, for: indexPath) as? ImagePostTableViewCell else {
                return UITableViewCell()
            }
            cell.navigationDelegate = self
            if personDetails.count > 0 {
                cell.setupDataSource(index: indexPath.row, person: personDetails[1])
            }
            return cell
        case .postwithButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TCConstant.kPostWithButtonTableViewCellIdentifier, for: indexPath) as? PostWithButtonTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .postwithCarousel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TCConstant.kPostWithCarouselTableViewCellIdentifier, for: indexPath) as? PostWithCarouselTableViewCell else {
                return UITableViewCell()
            }
            cell.setupDataSource()
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}

extension ViewController: UITableViewDelegate {
    
    // MARK: Context Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ViewController: TCNaviagtiondelegate {
    func presentViewControllerFromCell(image: UIImage) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.newImage = image
            self.present(vc , animated: true, completion: nil)
        }
        
    }
    
    func presentViewControllerFromCell(imageArray: [String], index: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaginationViewController") as? PaginationViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.imageArray = imageArray
            vc.index = index
            self.present(vc , animated: true, completion: nil)
        }
    }
}
