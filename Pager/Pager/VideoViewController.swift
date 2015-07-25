//
//  VideoViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/24/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoViewController: UIViewController {

    @IBOutlet weak var expertView: UIView!
    @IBOutlet weak var expertPhoto: UIImageView!
    @IBOutlet weak var expertBackgroundGreen: UIImageView!
    var moviePlayer : MPMoviePlayerController?

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playVideo()
        expertHead()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func playVideo() {
        if let
            path = NSBundle.mainBundle().pathForResource("video-sharing", ofType:"MOV"),
            url = NSURL(fileURLWithPath: path),
            moviePlayer = MPMoviePlayerController(contentURL: url) {
                self.moviePlayer = moviePlayer
                moviePlayer.view.frame = self.view.bounds
                moviePlayer.prepareToPlay()
                moviePlayer.scalingMode = .AspectFill
                moviePlayer.controlStyle = .None
                self.view.addSubview(moviePlayer.view)
        } else {
            debugPrintln("Ops, something wrong when playing video.m4v")
        }
    }
    
    func expertHead(){
        
        self.view.addSubview(closeButton)
        self.view.addSubview(expertView)
 
        UIView.animateWithDuration(1.0, delay:0, options: .Repeat | .Autoreverse, animations: {
            
            self.expertBackgroundGreen.transform = CGAffineTransformMakeScale(1.1, 1.1)
            
        }, completion: nil)
        
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {

        self.navigationController?.popViewControllerAnimated(true)
    }
    



}
