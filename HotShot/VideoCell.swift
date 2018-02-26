//
//  VideoCell.swift
//  HotShot
//
//  Created by Bryce Williams on 2/23/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import AVKit

class VideoClass: UIView {
    
    
}


class VideoCell: UITableViewCell {
  
    var videoUrl : URL!
    func setUrl(videoPath: URL) {
        videoUrl = videoPath
    }
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func PlayVideo(_ sender: UIButton) {
        let video = AVPlayer(url: videoUrl)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
       
    }
    
    @IBOutlet weak var Votes: UILabel!
    
    @IBOutlet weak var UpVote: UIButton!
    
    @IBAction func UpVote(_ sender: UIButton) {
    }
    
    @IBOutlet weak var DownVote: UIButton!
    
    @IBAction func DownVote(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var PlayerView: PlayerViewClass!
    

//    @IBOutlet weak var Vote: UIButton!
////    @IBAction func UpVote(_ sender: UIButton) {
////        print("hello")
////    }
//    @IBAction func UpVote(_ sender: UIButton) {
//        print("hello")
//        print(sender.tag)
//    }
   
    
    
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var title: UILabel!
    //    @IBOutlet weak var playerView: PlayerView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
