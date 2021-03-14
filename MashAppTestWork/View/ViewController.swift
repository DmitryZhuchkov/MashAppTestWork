//
//  ViewController.swift
//  MashAppTestWork
//
//  Created by Дмитрий Жучков on 07.03.2021.
//

import UIKit
import Kingfisher
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var hotelsTableView: UITableView!
    @IBOutlet weak var helpButtons: UIStackView!
    var data: JSONDecode?
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelsTableView.delegate = self
        hotelsTableView.dataSource = self
        helpButtons.layer.cornerRadius = 10
        helpButtons.layer.masksToBounds = true
        ServiceLoad.load.loadInfo { response in
            self.data = response
            DispatchQueue.main.async {
                self.hotelsTableView?.reloadData()
            }
        }
           }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelsViewCell", for: indexPath) as? HotelsViewCell
        if data != nil {
        let url = URL(string: (data?.data[indexPath.row].image)!)
        let resourse = ImageResource(downloadURL: url!, cacheKey: (data?.data[indexPath.row].image))
        cell?.hotelImage.kf.setImage(with: resourse)
        cell?.titleLabel.text = data?.data[indexPath.row].title
        cell?.adressLabel.text = " \((data?.data[indexPath.row].address)!)"
        cell?.priceForNightLabel.attributedText = cell?.priceForNightTextFormat(price: Int((data?.data[indexPath.row].price)!))
        cell?.priceForNightsLabel.attributedText = cell?.priceForNightsTextFormat(price: Int((data?.data[indexPath.row].priceNight)!))
        cell?.typeLabel.text = data?.data[indexPath.row].type.rawValue
        cell?.scoreLabel.text = String((data?.data[indexPath.row].reviewsScore)!)
        cell?.reward.attributedText = cell?.rewardTextFormat(percent: (data?.data[indexPath.row].rewardPercent)!, amount: Int((data?.data[indexPath.row].rewardAmount)!))
            if data?.data[indexPath.row].freeCancellation == true {
                cell?.cancellation.text = "Free cancellation"
                cell?.checkCancellation.image = UIImage(systemName: "checkmark.circle")
            }
            if data?.data[indexPath.row].prepayment == false {
                cell?.prepayment.text = "No prepayment needed"
                cell?.checkPrepayment.image = UIImage(systemName: "checkmark.circle")
            }
            cell?.tax.text = "+$\(Int((data?.data[indexPath.row].tax)!)) taxes & fees"
            cell?.starStack.setStarsRating(rating: (data?.data[indexPath.row].stars)!)
            
        }
        return cell!
    }
    @IBAction func ButtonTapped(sender: UIButton) {
        let alert = UIAlertController( title: "", message: "Coming soon", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }

    }
}
