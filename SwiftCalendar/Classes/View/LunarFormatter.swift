//
//  LunarFormatter.swift
//  FSCalendarSwiftExample
//
//  Created by Wenchao Ding on 25/07/2017.
//  Copyright © 2017 wenchao. All rights reserved.
//

import UIKit
import LunarCore

open class LunarFormatter: NSObject {
    
    fileprivate let chineseCalendar = Calendar(identifier: .chinese)
    fileprivate let formatter = DateFormatter()
    fileprivate let lunarDays = ["初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","廿十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"]
    fileprivate let lunarMonths = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
  
    
    override init() {
        self.formatter.calendar = self.chineseCalendar
        self.formatter.dateFormat = "M"
    }
    
    /// 获取农历当月天数
    open func getDaysFromLunarMonth(date: Date) -> Int {
        let daysCount = self.chineseCalendar.range(of: .day, in: .month, for: date)?.count ?? 29
        return daysCount
    }
    
    /// 获取农历当年月数
    open func getMonthsFromLunarYear(date: Date) -> Int {
        let daysCount = self.chineseCalendar.range(of: .month, in: .year, for: date)?.count ?? 12
        return daysCount
    }
    
    open func  getLunarLeapMonth(date: Date) {
        
    }
    
    open func lunarDict(from date: Date) -> NSMutableDictionary?{
        let calendar = Calendar(identifier: .gregorian)
        let year =  calendar.component(.year, from: date)
        let month =  calendar.component(.month, from: date)
        let day =  calendar.component(.day, from: date)
        guard let lunarDict = LunarCore.shareInstance()?.solar(toAlmanac: year, _month: month, _day: day) else{
            return nil
        }
        
        return lunarDict
    }
    
    open func getFestival(from date: Date) -> String? {
        
        guard let lunarDict = self.lunarDict(from: date) else{
            return nil
        }
        
        if let lunarFestival = lunarDict["lunarFestival"] as? String,  lunarFestival.count > 0 {
            return lunarFestival
        }
        
        if let term = lunarDict["term"] as? String,  term.count > 0 {
            if term == "清明" {
                return "清明节"
            }
            return term
        }
        
        if let solarFestival = lunarDict["solarFestival"] as? String,  solarFestival.count > 0 {
            return solarFestival
        }
        
        if let weekFestival = lunarDict["weekFestival"] as? String,  weekFestival.count > 0 {
            return weekFestival
        }
        
        return nil
    }
    
    open func string(from date: Date) -> String {
        if let festival = getFestival(from :date) as String? {
            return festival
        }
    
        let day = self.chineseCalendar.component(.day, from: date)
        if day != 1 {
            return self.lunarDays[day-2]
        }
        // First day of month
        let monthString = self.formatter.string(from: date)
        if self.chineseCalendar.veryShortMonthSymbols.contains(monthString) {
            if let month = Int(monthString) {
                return self.lunarMonths[month-1]
            }
            return ""
        }
        // Leap month
        let month = self.chineseCalendar.component(.month, from: date)
        return "闰" + self.lunarMonths[month-1]
    }
    
    open func getHolidayType(from date: Date) -> HolidayType {
        
        guard let lunarDict = self.lunarDict(from: date) else{
            return .none
        }
        
        guard let  worktime = lunarDict["worktime"] as? Int else{
            return .none
        }
        
        if worktime == 1 {
            return .work
        }
        
        if worktime == 2 {
            return .holiday
        }
        
        return .none
        
    }
    
    open func getGanZhiYear(from date: Date) -> String {
        guard let lunarDict = self.lunarDict(from: date) else{
            return ""
        }
        
        guard let  GanZhiYear = lunarDict["GanZhiYear"] as? String else{
            return ""
        }
        
        guard let  GanZhiMonth = lunarDict["GanZhiMonth"] as? String else{
            return ""
        }
        
        guard let  GanZhiDay = lunarDict["GanZhiDay"] as? String else{
            return ""
        }
        
        guard let zodiac = lunarDict["zodiac"] as? String else{
            return ""
        }
        
        guard let lunarMonthName = lunarDict["lunarMonthName"] as? String else{
            return ""
        }
        
        guard let lunarDayName = lunarDict["lunarDayName"] as? String else{
            return ""
        }
        
        guard let astro = lunarDict["astro"] as? String else{
            return ""
        }
        
        guard let weekOfYear = lunarDict["weekOfYear"] as? NSInteger else{
            return ""
        }
        
        guard let intervalDayFromNow = lunarDict["intervalDayFromNow"] as? NSInteger else{
            return ""
        }
        
        var intervalDay = "今天"
        if intervalDayFromNow > 0{
            intervalDay = "\(intervalDayFromNow)天前"
        }else if intervalDayFromNow < 0{
            intervalDay = "\(-intervalDayFromNow)天后"
        }
        
        guard  let emperorYear = lunarDict["emperorYear"] as? NSInteger  else {
            return ""
        }
        
        let  emperorYearCN = "黄帝纪元\(LunarFormatter.arabicDigitIntoChineseString(number:emperorYear))年"
        
        guard let yi = lunarDict["yi"] as? String else{
            return ""
        }
        
        guard let ji = lunarDict["ji"] as? String else{
            return ""
        }
        
        guard let jiXiong = lunarDict["jiXiong"] as? String else{
            return ""
        }
        
        guard let chongSha = lunarDict["chongSha"] as? String else{
            return ""
        }
        
        guard let zhiShen = lunarDict["zhiShen"] as? String else{
            return ""
        }
        
        guard let wuXing = lunarDict["wuXing"] as? String else{
            return ""
        }
        
        guard let xingXiu = lunarDict["xingXiu"] as? String else{
            return ""
        }
        
        guard let penZhuBaiJi = lunarDict["penZhuBaiJi"] as? String else{
            return ""
        }
        
        guard let jiShen = lunarDict["jiShen"] as? String else{
            return ""
        }
        
        guard let xiongShen = lunarDict["xiongShen"] as? String else{
            return ""
        }
        
        guard let taiShen = lunarDict["taiShen"] as? String else{
            return ""
        }
        
        
        return "\(GanZhiYear)年(\(zodiac)年) \(GanZhiMonth)月 \(GanZhiDay)日  农历\(lunarMonthName)\(lunarDayName) \(astro) 第\(weekOfYear)周 \(intervalDay) \(emperorYearCN) 宜：\(yi) 忌：\(ji) 时辰吉凶:\(jiXiong) 冲煞:\(chongSha) 值神:\(zhiShen) 五行:\(wuXing) 星宿:\(xingXiu) 彭祖百忌:\(penZhuBaiJi) 吉神：\(jiShen) 凶神：\(xiongShen)  胎神:\(taiShen)"
    }
    
}


extension LunarFormatter {
    
    /// 阿拉伯数字转汉语
    public class func arabicDigitIntoChineseString(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        if let style = NumberFormatter.Style(rawValue: UInt(CFNumberFormatterRoundingMode.roundHalfDown.rawValue)) {
            formatter.numberStyle = style
            if let string = formatter.string(from: NSNumber(value: number)) {
                return string
            }
        }
        
        return String(number)
    }
    
}
