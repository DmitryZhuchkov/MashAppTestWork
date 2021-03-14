//
//  HotelsViewCell.swift
//  MashAppTestWork
//
//  Created by Дмитрий Жучков on 08.03.2021.
//

import UIKit
import Foundation
class HotelsViewCell: UITableViewCell {
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var priceForNightLabel: UILabel!
    @IBOutlet weak var priceForNightsLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cancellation: UILabel!
    @IBOutlet weak var prepayment: UILabel!
    @IBOutlet weak var checkCancellation: UIImageView!
    @IBOutlet weak var checkPrepayment: UIImageView!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var starStack: UIStackView!
    @IBOutlet weak var reward: UILabel!
    @IBOutlet weak var triangle: UIImageView!
    override func awakeFromNib() {
       super.awakeFromNib()
            cellView.layer.cornerRadius = 10
            cellView.layer.masksToBounds = true
            cellView.layer.shadowOpacity = 0.40
            cellView.layer.shadowRadius = 4
            reward.layer.cornerRadius = 8
            reward.layer.masksToBounds = true
            hotelImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tintColor = .red
            sender.setImage(UIImage(systemName:"heart.fill"), for: .normal)
            sender.tag = 1
        } else {
            sender.tintColor = .gray
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.tag = 0
        }
    }
    func priceForNightTextFormat(price: Int) -> NSAttributedString {
        let priceAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        let otherAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 13)]
        let priceText = NSMutableAttributedString(string: "$\(price)", attributes: priceAttributes)
        let otherText = NSAttributedString(string: " /night", attributes: otherAttributes)
        priceText.append(otherText)
        return priceText
    }
    func priceForNightsTextFormat(price: Int) -> NSAttributedString {
        let priceAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .bold),.strikethroughColor: UIColor.black]
        let otherAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 12)]
        let priceText = NSMutableAttributedString(string: "$\(price)", attributes: priceAttributes)
        let otherText = NSAttributedString(string: " for 1 night", attributes: otherAttributes)
        priceText.append(otherText)
        return priceText
    }
    func rewardTextFormat(percent: Int,amount:Int) -> NSAttributedString {
        let percentAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 13)]
        let amountAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        let percentText = NSMutableAttributedString(string: "\(percent)% reward back |", attributes: percentAttributes)
        let amountText = NSAttributedString(string: "$\(amount)", attributes: amountAttributes)
        percentText.append(amountText)
        return percentText
    }
}
extension UIStackView {

    open override func draw(_ rect: CGRect) {
         let starRating = self.subviews.filter{$0 is UIImageView}
         var starTag = 1
         for image in starRating {
             if let image = image as? UIImageView{
                 image.tag = starTag
                 starTag = starTag + 1
             }
         }
    }
    func setStarsRating(rating:Int){
        draw(.null)
        let stackSubViews = self.subviews.filter{$0 is UIImageView}
        for subView in stackSubViews {
            if let image = subView as? UIImageView{
                if image.tag > rating {
                    image.image = .none
                }else{
                    image.tintColor = .systemYellow
                    image.image = UIImage(systemName: "star.fill")
                }
            }
        }
    }
}
