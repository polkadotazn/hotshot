//
//  PlayerViewClass.swift
//  HotShot
//
//  Created by Bryce Williams on 2/24/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewClass: UIView {
    
    
    
    override static var layerClass: AnyClass {
        
        return AVPlayerLayer.self;
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    
    var player: AVPlayer? {
        
        get {
            return playerLayer.player;
            
        }
        
        set {
            
            playerLayer.player = newValue;
        }
    }
}
