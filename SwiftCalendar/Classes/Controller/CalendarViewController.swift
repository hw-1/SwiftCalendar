//
//  CalendarViewController.swift
//  SwiftCalendar
//
//  Created by hw on 2019/2/14.
//

import UIKit
import SnapKit

public class CalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView = UITableView()
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone =  TimeZone(identifier: "Asia/Shanghai") ?? TimeZone.current
        calendar.locale =  Locale(identifier: "zh_hans_CN")
        return calendar
    }()
    
    lazy   var weekDaysView: VAWeekDaysView = {
        let weekDaysView = VAWeekDaysView()
        let appereance = VAWeekDaysViewAppearance(symbolsType: .short, calendar: defaultCalendar)
        weekDaysView.appearance = appereance
        weekDaysView.backgroundColor = .white
        return weekDaysView
    }()
    
    lazy   var calendarView: VACalendarView = {
        let calendarView = VACalendarView()
        return calendarView
    }()
    
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    public func setup(){
        self.view.addSubview(tableView)
        tableView.register(CanlendarCell.self, forCellReuseIdentifier: "CanlendarCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.backgroundColor =  .white
        tableView.clipsToBounds = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints({
            $0.top.left.bottom.right.equalTo(0)
        })
        
    }
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

 
