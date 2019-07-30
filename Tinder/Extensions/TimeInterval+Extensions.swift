//
//  Int+Extensions.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/25.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import Foundation

extension TimeInterval {
  /// 当前时间
  fileprivate var selfDate : Date {
    return Date(timeIntervalSince1970: self)
  }
  
  /// 距当前有几分钟
  var minute: Int {
    let dateComponent = Calendar.current.dateComponents([.minute], from: selfDate, to: Date())
    return dateComponent.minute!
  }
  
  /// 距当前有几小时
  var hour: Int {
    let dateComponent = Calendar.current.dateComponents([.hour], from: selfDate, to: Date())
    return dateComponent.hour!
  }
  
  /// 距当前有几小时
  var day: Int {
    let dateComponent = Calendar.current.dateComponents([.day], from: selfDate, to: Date())
    return dateComponent.day!
  }
  
  /// 是否是今天
  var isToday : Bool {
    return Calendar.current.isDateInToday(selfDate)
  }
  
  /// 是否是昨天
  var isYesterday : Bool {
    return Calendar.current.isDateInYesterday(selfDate)
  }
  
  /// 是否是今年
  var isYear: Bool {
    let nowComponent = Calendar.current.dateComponents([.year], from: Date())
    let component = Calendar.current.dateComponents([.year], from: selfDate)
    return (nowComponent.year == component.year)
  }
  
  func dateTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    return format.string(from: selfDate)
  }
  
  func yesterdayTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "HH:mm"
    return format.string(from: selfDate)
  }
  
  func noYesterdayTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "MM-dd HH:mm"
    return format.string(from: selfDate)
  }
  
  func yearTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy年MM月dd日  HH:mm"
    return format.string(from: selfDate)
  }
  
  func monTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy/MM"
    return format.string(from: selfDate)
  }
  
  func monDayTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "MM-dd"
    return format.string(from: selfDate)
  }
  
  func allTime() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return format.string(from: selfDate)
  }
  
  func timeString() -> String {//校园圈列表，兴趣学院话题列表
    if isToday {
      if minute < 1 {
        return "刚刚"
      } else if hour < 1 {
        return "\(minute)分钟之前"
      } else {
        return "今天\(yesterdayTime())"
      }
    } else if isYesterday {
      return "昨天 \(yesterdayTime())"
    } else if isYear {
      return monDayTime()
    } else {
      return yearTime()
    }
  }
 
}
