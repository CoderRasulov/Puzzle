import UIKit

class gameViewController: UIViewController {
   
    var numbers : Array<UIButton> = []
    var empty = 16
    var emount = 0

    var a : UIButton!
    var b : UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let width = view.frame.width
        let height = view.frame.height
        let widthButton = (width - 58)/4
        let heightButton = widthButton
        var x = 20 , y = 100
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.image = UIImage(named: "x")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        
        for _ in 1...4
        {
            x = 20
            for _ in 1...4
            {
                let square = UIButton(frame: CGRect(x: x, y: y, width: Int(widthButton), height: Int(heightButton)))
                square.setBackgroundImage(UIImage(named: "blue"), for: .normal)
                square.contentMode = .scaleAspectFill
                square.setTitle("\(emount + 1)", for: .normal)
                square.titleLabel?.font = UIFont.boldSystemFont(ofSize: widthButton /  4)
                square.tag = emount + 1
                square.setTitleColor(UIColor.white, for: .normal)
                square.adjustsImageWhenHighlighted = false
                square.adjustsImageWhenDisabled = false
                view.addSubview(square)
                numbers.append(square)
                square.addTarget(self, action: #selector(gameViewController.buttons(_:)), for: .touchUpInside)
                x = x + Int(widthButton) + 6
                emount += 1
                if emount == 15 { break }
            }
            y = y + Int(heightButton) + 6
        }
        
        let home = UIButton(frame: CGRect(x: 0.25 * width, y: CGFloat(y + 20), width: 0.5 * width, height: heightButton))
        home.setTitle("Home", for: .normal)
        home.titleLabel?.font = UIFont(name: "Chalkboard SE", size: width / 15)
        home.layer.cornerRadius = 20
        home.layer.borderWidth = 7
        home.clipsToBounds = true
        home.backgroundColor = UIColor(red: 78 / 255.0, green: 123 / 255.0, blue: 220 / 255.0, alpha: 1)
        home.layer.borderColor = UIColor(red: 204 / 255.0, green: 204 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
        home.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(home)
        random()
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
        playSoundWith(fileName: "Symphony", fileExtinsion: "mp3")
    }
    
    fileprivate func boolRight(_ i: Int, _ sender: UIButton, _ width: CGFloat, _ widthButton: CGFloat) -> Bool {
        return numbers[i].tag == sender.tag + 1 && sender.center.x < width - 20 - widthButton &&
            numbers[i].center.x < width - 20 - widthButton
    }
    
    fileprivate func moveLeft(_ i: Int, _ sender: UIButton, _ widthButton: CGFloat) -> Bool {
        return numbers[i].tag == sender.tag - 1 && sender.center.x > widthButton &&
            numbers[i].center.x > widthButton
    }
    
    @IBAction func buttons(_ sender: UIButton)
    {
        playSoundWith(fileName: "Button", fileExtinsion: "wav")
        
        let width = view.frame.width
        let widthButton = (width - 40 - 18)/4
        let blockRight = width - 20 - widthButton
        
        if sender.tag + 1 == empty && sender.center.x < blockRight {
            moveRight(button: sender)
            sender.tag = sender.tag + 1
            empty = empty - 1
        } else
        if sender.tag + 2 == empty {
            for i in 0...14 {
                if boolRight(i, sender, width, widthButton) {
                    moveRight(button: sender) ; moveRight(button: numbers[i])
                    sender.tag = sender.tag + 1 ; numbers[i].tag = numbers[i].tag + 1
                    empty = empty - 2 ; break
                }
            }
        } else
        if sender.tag + 3 == empty {
            for i in 0...14 {
                if sender.tag + 2 == numbers[i].tag {
                    a = numbers[i] ; break
                }
            }
            for i in 0...14 {
                if sender.tag + 1 == numbers[i].tag {
                    b = numbers[i] ; break
                }
            }
            if sender.center.x < blockRight && a.center.x < blockRight && b.center.x < blockRight {
                moveRight(button: a) ; moveRight(button: b) ; moveRight(button: sender)
                a.tag = a.tag + 1 ; b.tag = b.tag + 1 ; sender.tag = sender.tag + 1
                empty = empty - 3
            }
        } else
        if sender.tag - 1 == empty && sender.center.x > widthButton {
            moveLeft(button: sender)
            sender.tag = sender.tag - 1
            empty = empty + 1
        } else
        if sender.tag - 2 == empty {
            for i in 0...14 {
                if moveLeft(i, sender, widthButton) {
                    moveLeft(button: sender) ; moveLeft(button: numbers[i])
                    sender.tag = sender.tag - 1 ; numbers[i].tag = numbers[i].tag - 1
                    empty = empty + 2 ; break
                }
            }
        } else
        if sender.tag - 3 == empty {
            for i in 0...14 {
                if sender.tag - 2 == numbers[i].tag {
                    a = numbers[i] ; break
                }
            }
            for i in 0...14 {
                if sender.tag - 1 == numbers[i].tag {
                    b = numbers[i] ; break
                }
            }
            if sender.center.x > widthButton && a.center.x > widthButton && b.center.x > widthButton {
                moveLeft(button: a) ; moveLeft(button: b) ; moveLeft(button: sender)
                a.tag = a.tag - 1 ; b.tag = b.tag - 1 ; sender.tag = sender.tag - 1
                empty = empty + 3
            }
        } else
        if sender.tag + 4 == empty {
            moveBottom(button: sender)
            sender.tag = sender.tag + 4
            empty = empty - 4
        } else
        if sender.tag + 8 == empty {
            for i in 0...14 {
                if numbers[i].tag == sender.tag + 4 {
                    moveBottom(button: numbers[i])
                    numbers[i].tag = numbers[i].tag + 4
                    break
                }
            }
            moveBottom(button: sender)
            sender.tag = sender.tag + 4
            empty = empty - 8
        } else
        if sender.tag + 12 == empty {
            for i in 0...14 {
                if numbers[i].tag == sender.tag + 8 {
                    moveBottom(button: numbers[i])
                    numbers[i].tag = numbers[i].tag + 4
                    break
                }
            }
            for i in 0...14 {
                if numbers[i].tag == sender.tag + 4 {
                    moveBottom(button: numbers[i])
                    numbers[i].tag = numbers[i].tag + 4
                    break
                }
            }
            moveBottom(button: sender)
            sender.tag = sender.tag + 4
            empty = empty - 12
        } else
        if sender.tag - 4 == empty {
            moveUp(button: sender)
            sender.tag = sender.tag - 4
            empty = empty + 4
        } else
        if sender.tag - 8 == empty {
            for i in 0...14 {
                if numbers[i].tag == sender.tag - 4 {
                    moveUp(button: numbers[i])
                    numbers[i].tag = numbers[i].tag - 4
                    break
                }
            }
            moveUp(button: sender)
            sender.tag = sender.tag - 4
            empty = empty + 8
        } else
        if sender.tag - 12 == empty {
            for i in 0...14 {
                if numbers[i].tag == sender.tag - 8 {
                    moveUp(button: numbers[i])
                    numbers[i].tag = numbers[i].tag - 4
                    break
                }
            }
            for i in 0...14 {
                if numbers[i].tag == sender.tag - 4 {
                    moveUp(button: numbers[i])
                    numbers[i].tag = numbers[i].tag - 4
                    break
                }
            }
            moveUp(button: sender)
            sender.tag = sender.tag - 4
            empty = empty + 12
        }
        win()
    }

    func moveRight(button : UIButton)
    {
        let width = numbers[0].frame.width
        
        UIButton.animate(withDuration: 0.4)
        {
            button.center.x += width + 6
        }
    }
    func moveLeft(button : UIButton)
    {
        let width = numbers[0].frame.width

        UIButton.animate(withDuration: 0.4)
        {
            button.center.x -= width + 6
        }
    }
    func moveBottom(button : UIButton)
    {
        let height = numbers[0].frame.height

        UIButton.animate(withDuration: 0.4)
        {
            button.center.y += height + 6
        }
    }
    func moveUp(button : UIButton)
    {
        let height = numbers[0].frame.height

        UIButton.animate(withDuration: 0.4)
        {
            button.center.y -= height + 6
        }
    }
    func random()
    {
        for _ in 0...100
        {
            let a = numbers.randomElement()!
            let b = numbers.randomElement()!

            let c = a.currentTitle

            a.setTitle(b.currentTitle, for: .normal)
            b.setTitle(c, for: .normal)
        }
        
    }
    func win()
    {
        for i in 0...14
        {
            if numbers[i].tag == Int(numbers[i].currentTitle!)
            {
                emount += 1
            } else
            {
                emount = 0 ; break
            }
        }
        
        if emount == 15
        {
            let alert = UIAlertController(title: "YOU WIN !! ", message: "Try Again?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.random() }))
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
   }
}

