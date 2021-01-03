import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()

func playSoundWith(fileName: String, fileExtinsion: String) -> Void {
    
    let audioSourceURL = Bundle.main.url(forResource: fileName, withExtension: fileExtinsion)
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: audioSourceURL!)
    } catch {
        print(error)
    }
    audioPlayer.prepareToPlay()
    audioPlayer.play()
}

class startViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSoundWith(fileName: "Symphony", fileExtinsion: "mp3")
       
    }
    
    @IBAction func start(_ sender: UIButton) {
        audioPlayer.stop()
    }
    @IBAction func quit(_ sender: UIButton) {
        audioPlayer.stop()
        exit(0)
    }
    @IBAction func soundoff(_ sender: UIButton) {
        audioPlayer.pause()
    }
    @IBAction func soundon(_ sender: UIButton) {
        audioPlayer.play()
    }
    
}
