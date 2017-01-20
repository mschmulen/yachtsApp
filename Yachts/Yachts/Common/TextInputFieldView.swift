//
//  TextInputFieldView.swift
//  Yachts
//
//  Created by Matt Schmulen on 1/20/17.
//  Copyright © 2017 Matt Schmulen. All rights reserved.
//

import UIKit

class TextInputFieldView: UIView {

//  @IBOutlet weak var textView: UITextView!
  var textView = UITextView()

  var textField = UITextField()


  override init (frame : CGRect) {
    super.init(frame : frame)
    configure()
  }

  convenience init () {
    self.init(frame:CGRect.zero)
    configure()
  }
  
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    configure()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func configure() {
    self.backgroundColor = UIColor.green
    textView.layer.borderWidth = 1.0
    textView.layer.borderColor = UIColor.darkGray.cgColor
    textView.layer.opacity = 0.9
    textView.layer.cornerRadius = 3
    textView.clipsToBounds = true

    textView.text = "yack"

    textField.text = "http://localhost:3000/users.json"
  }

//  func textField() {
//    let textField = UITextField(frame: CGRect(x:20.0, y:30.0, width:100.0, height:30.0))
//    textField.textAlignment = NSTextAlignment.center
//    textField.textColor = UIColor.blue
//    textField.borderStyle = UITextBorderStyle.line
//    textField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
//    //self.view.addSubview(textField)
//  }
//
//  func textView() {
//    let textView = UITextView(frame: CGRect(x:20.0, y:30.0, width:300.0, height:30.0))
//    textView.textAlignment = NSTextAlignment.center
//    textView.textColor = UIColor.blue
//    textView.backgroundColor = UIColor.red
//    //self.view.addSubview(textView)
//  }
//
//  func labelView() {
//    let textView = UITextView(frame: CGRect(x:20.0, y:30.0, width:300.0, height:30.0))
//    textView.textAlignment = NSTextAlignment.center
//    textView.textColor = UIColor.blue
//    textView.backgroundColor = UIColor.red
//    //self.view.addSubview(textView)
//  }
//
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
