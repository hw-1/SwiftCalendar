//
//  DIYCalendarCell.swift
//  FSCalendarSwiftExample
//
//  Created by dingwenchao on 06/11/2016.
//  Copyright © 2016 wenchao. All rights reserved.
//

import Foundation
import FSCalendar
import UIKit

public enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

public enum HolidayType : Int {
    case none
    case work
    case holiday
}


class DIYCalendarCell: FSCalendarCell {
    
    var circleImageView: CAShapeLayer!
    var selectionLayer: CAShapeLayer!
    var workLabel =  UILabel()
    var workLabelCircle = CAShapeLayer()
    var holidayLabel =  UILabel()
    var holidayLabelCircle = CAShapeLayer()
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    var holidayType:HolidayType = .none {
        didSet {
            resetHoliday()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.init(hex: 0x00bc98, alpha: 1.0).cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel!.layer)
        self.selectionLayer = selectionLayer
        
        let circleImageView = CAShapeLayer()
        circleImageView.strokeColor = UIColor.init(hex: 0x00bc98, alpha: 1.0).cgColor
        circleImageView.fillColor = UIColor.clear.cgColor
        circleImageView.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(circleImageView, below: self.titleLabel!.layer)
        self.circleImageView = circleImageView
  
        self.shapeLayer.isHidden = true
        
        workLabelConfig()
        holidayLabelConfig()
 
        let view = UIView(frame: self.bounds)
        view.backgroundColor =  .clear
        self.backgroundView = view;
        
    }
    
    func workLabelConfig(){
        workLabel.frame = CGRect(x: self.contentView.bounds.size.width - 20, y: 5, width: 10, height: 10)
        workLabel.layer.cornerRadius = 5
        workLabel.layer.masksToBounds = true
        workLabel.backgroundColor = UIColor.red
        workLabel.text = "班"
        workLabel.font = UIFont.systemFont(ofSize: 7)
        workLabel.textAlignment = .center
        workLabel.textColor = .white
        self.contentView.addSubview(workLabel)
//        let workLabelCircle = CAShapeLayer()
        workLabelCircle.strokeColor = UIColor.white.cgColor
        workLabelCircle.fillColor = UIColor.clear.cgColor
        workLabelCircle.actions = ["hidden": NSNull()]
        self.contentView.layer.addSublayer(workLabelCircle)
        workLabelCircle.frame = self.contentView.bounds
        workLabelCircle.path = UIBezierPath(ovalIn:workLabel.frame).cgPath
        workLabel.isHidden = true
        workLabelCircle.isHidden = true
    }
    
    func holidayLabelConfig(){
        holidayLabel.frame = CGRect(x: self.contentView.bounds.size.width - 20, y: 5, width: 10, height: 10)
        holidayLabel.layer.cornerRadius = 5
        holidayLabel.layer.masksToBounds = true
        holidayLabel.backgroundColor = UIColor.init(hex: 0x00bc98, alpha: 1.0)
        holidayLabel.text = "休"
        holidayLabel.font = UIFont.systemFont(ofSize: 7)
        holidayLabel.textAlignment = .center
        holidayLabel.textColor = .white
        self.contentView.addSubview(holidayLabel)
//        let holidayLabelCircle = CAShapeLayer()
        holidayLabelCircle.strokeColor = UIColor.white.cgColor
        holidayLabelCircle.fillColor = UIColor.clear.cgColor
        holidayLabelCircle.actions = ["hidden": NSNull()]
        self.contentView.layer.addSublayer(holidayLabelCircle)
        holidayLabelCircle.frame = self.contentView.bounds
        holidayLabelCircle.path = UIBezierPath(ovalIn:holidayLabel.frame).cgPath
        holidayLabel.isHidden = true
        holidayLabelCircle.isHidden = true
    }
    
    func resetHoliday(){
        if self.holidayType == .work {
            workLabel.isHidden = false
            workLabelCircle.isHidden = false
            holidayLabel.isHidden = true
            holidayLabelCircle.isHidden = true
            
        }else if self.holidayType == .holiday {
            workLabel.isHidden = true
            workLabelCircle.isHidden = true
            holidayLabel.isHidden = false
            holidayLabelCircle.isHidden = false
        }else{
            workLabel.isHidden = true
            workLabelCircle.isHidden = true
            holidayLabel.isHidden = true
            holidayLabelCircle.isHidden = true
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.circleImageView.frame = self.contentView.bounds
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.selectionLayer.frame = self.contentView.bounds
         
        let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width) - 10
        
        self.circleImageView.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2 - 3 , width: diameter, height: diameter)).cgPath
 
        self.selectionLayer.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2 - 3 , width: diameter, height: diameter)).cgPath
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        // Override the build-in appearance configuration
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
            self.titleLabel.textColor = UIColor.lightGray
        }else{
            self.titleLabel.textColor = .black
            self.titleLabel.highlightedTextColor = .white
            self.subtitleLabel.textColor = .black
            self.subtitleLabel.highlightedTextColor = .white
        }
    }
    
}
