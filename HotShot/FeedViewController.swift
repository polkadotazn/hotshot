//
//  FeedViewController.swift
//  HotShot
//
//  Created by Emmanuel Feygelson on 2/20/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import AVFoundation
import AVKit
import GoogleMaps
import GooglePlaces


class FeedViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate , GMSMapViewDelegate {

    @IBOutlet weak var HotOrNew: UISegmentedControl!
    @IBAction func HotOrNew(_ sender: UISegmentedControl) {
        print("HOT OR NEW", sender.selectedSegmentIndex)
        self.viewDidLoad()
    }
    
    //    let videos = ref.child("videos");
    var videoUrls = ["02751332-633D-43C2-92A8-7F4AD5B104AF","mountains.mov"]
    var videoFiles = [URL]()
    var videoTitles = [String]()
    var votes = [Int]()
    var videoIds = [String]()
    var currentVotes = Array(repeating: 0, count: 10)
    
    @objc func updateView(sender: UIButton) {
//        let video = AVPlayer(url: videoUrl)
//        let videoPlayer = AVPlayerViewController()
//        videoPlayer.player = video
        
//        present(videoPlayer, animated: true, completion: {
//
//            video.play()
//        })print
        print("update")
        print(sender.accessibilityHint!)
        let fileUrl  = URL(string:sender.accessibilityHint!)
        let video = AVPlayer(url: fileUrl!)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        present(videoPlayer, animated: true, completion: {
            video.play()
        })
        
    }
    
    @objc func upVote(sender: UIButton) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
      print("UPVOTE")
        if self.currentVotes[sender.tag] < 1 {
            if self.currentVotes[sender.tag] == 0 {
                     print("currentVotes",self.currentVotes[sender.tag])
            self.currentVotes[sender.tag] = 1
                
            }
            
            else if self.currentVotes[sender.tag] == -1 {
                print("currentVotes",self.currentVotes[sender.tag])
                
                self.currentVotes[sender.tag] = 1
                
            }
            let indexPath = IndexPath(item: sender.tag, section: 0)
           tableView.reloadRows(at: [indexPath], with: .top)
            ref.child("videos").child(sender.accessibilityHint!).updateChildValues(["votes": self.votes[sender.tag] + self.currentVotes[sender.tag]])
            }
    
        }
    
    @objc func downVote(sender: UIButton) {
        print("DownVote")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if self.currentVotes[sender.tag] > -1 {
            if self.currentVotes[sender.tag] == 0 {
            self.currentVotes[sender.tag] = -1
            }
            
            else if self.currentVotes[sender.tag] == 1 {
                self.currentVotes[sender.tag] = -1
                
            }
                
            let indexPath = IndexPath(item: sender.tag, section: 0)
            tableView.reloadRows(at: [indexPath], with: .top)
            ref.child("videos").child(sender.accessibilityHint!).updateChildValues(["votes": self.votes[sender.tag] + self.currentVotes[sender.tag]])
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
     var locationManager = CLLocationManager()
    override func viewDidLoad() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        super.viewDidLoad()
  
        var videoFileNames = [String]()
        print("RUN")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storageRef = Storage.storage().reference()
        var fileRef = storageRef.child("mountains.mov")
        ref.child("videos").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                print("key",key)
                
                let snapshotValue = snap.value as! [String: AnyObject]
                print("SNAP")
                print(snapshotValue)
                let fileName  = snapshotValue["name"] as! String
                let title = snapshotValue["title"] as! String
                let vote = snapshotValue["votes"] as! Int
                videoFileNames.append(fileName)
                self.videoTitles.append(title)
                self.votes.append(vote)
                self.videoIds.append(key)
            }
            
        
            for name in videoFileNames {
                let outputFileName = NSUUID().uuidString
                var fileRef = storageRef.child(name)
                let localURL = (NSTemporaryDirectory() as NSString).appendingPathComponent((outputFileName as NSString).appendingPathExtension("mov")!)
                let tempFile = URL(string:"File://\(localURL)")
        // Download to the local filesystem
                let downloadTask = fileRef.write(toFile: tempFile!) { url, error in
                    if let error = error {
                // Uh-oh, an error occurred!
                print("ERROR2122")
                print(error)
                    } else {
                // Local file URL for "images/island.jpg" is returned
                        self.videoFiles.append(tempFile!)
                        print("SUCCESS")
                    }
                }
            }
        })
        
        
    }
    
 

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     
        
        return 10;
    }
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as! VideoCell
        var videos = [String]()
        var titles = [String]()
        var videoIds = [String]()
        var votes = [Int]()
        var avPlayer : AVPlayer?
        var ref: DatabaseReference!
        ref = Database.database().reference()
//        ref.child("videos").observe(.childAdded, with: { (snapshot) in
//            let keySnapshot = snapshot.key
//            print(keySnapshot)
//            ref.child(keySnapshot).observe(.value, with: { (snapshot2) in
//                print(snapshot2)
//            }) { (error) in
//                print("error###\(error)")
//
//            }
//
//        })
            cell.UpVote.tag = indexPath.row
            cell.DownVote.tag = indexPath.row
           cell.myButton.addTarget(self, action: #selector(updateView), for: .touchUpInside)
        
        cell.UpVote.addTarget(self, action: #selector(upVote),
                              for: .touchUpInside)
        
        cell.DownVote.addTarget(self, action: #selector(downVote),
                              for: .touchUpInside)

        if self.videoFiles.isEmpty || self.videoFiles.count < indexPath.row + 1  {
        
        ref.child("videos").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                print("key",key)
                
                let snapshotValue = snap.value as! [String: AnyObject]
                print("SNAP")
                print(snapshotValue)
                let url = snapshotValue["url"] as! String
                let title = snapshotValue["title"] as! String
                let vote = snapshotValue["votes"] as! Int
                print("url")
                print(url)
                videos.append(url)
                titles.append(title)
                votes.append(vote)
                videoIds.append(key)
                
            }
        
            if !videos.isEmpty {
            avPlayer = AVPlayer(url: URL(string: videos[indexPath.row])!)
            cell.setUrl(videoPath: URL(string: videos[indexPath.row])!)
            cell.myButton.accessibilityHint = videos[indexPath.row]
            cell.PlayerView?.playerLayer.player = avPlayer
            cell.PlayerView?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            cell.title.text = titles[indexPath.row]
            cell.Votes.text = String(votes[indexPath.row] + self.currentVotes[indexPath.row])
            cell.UpVote.accessibilityHint = videoIds[indexPath.row]
            cell.DownVote.accessibilityHint = videoIds[indexPath.row]
            //            cell.PlayerView.player?.play()
//            cell.Vote.tag = indexPath.row
            }
            
        })
        }
        
        else {
            print(self.videoFiles)
            print("Videofiles")
            
            avPlayer = AVPlayer(url: self.videoFiles[indexPath.row])
            
            
            cell.myButton.accessibilityHint = self.videoFiles[indexPath.row].absoluteString
            cell.title.text = self.videoTitles[indexPath.row]
            
            cell.Votes.text = String(self.votes[indexPath.row] + self.currentVotes[indexPath.row])
            cell.UpVote.accessibilityHint = self.videoIds[indexPath.row]
            cell.DownVote.accessibilityHint = self.videoIds[indexPath.row]
            
            
            cell.PlayerView?.playerLayer.player = avPlayer
            cell.PlayerView?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            var currentTime: Double {
                get {
                    return CMTimeGetSeconds(avPlayer!.currentTime())
                }
                set {
                    let newTime = CMTimeMakeWithSeconds(newValue, 1)
                    avPlayer!.seek(to: newTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
                }
            }
            
            var duration: Double {
                guard let currentItem = avPlayer!.currentItem else { return 0.0 }
                
                return CMTimeGetSeconds(currentItem.duration)
            }
            print("Duration",duration)
            print("currentTime",currentTime)
        }
       

        
        
       
//                cell.PlayerView.playerLayer.player = avPlayer
//                cell.PlayerView.player?.play()
//
//                //                let videoPlayer = AVPlayerViewController()
////                videoPlayer.player = video
////                video.play()
      
        
//
//
        
//
        
//
        
      
//        cell.PlayerView?.playerLayer.player = avPlayer
//
//        cell.PlayerView.player?.play()
        
        
        
        
        
        
        
        
        
        
        

        
        return cell;
    }

    
    
    

//
//    @IBAction func hotNewSelectorChanged(_ sender: UISegmentedControl) {
//        isHot = !isHot
//    }
    

}
