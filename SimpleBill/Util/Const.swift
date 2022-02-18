//
//  Const.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/17.
//

import Foundation
import UIKit

let kIOSX: Bool = UIDevice.current.isiPhoneX()

let kScreenHeight: Double = UIScreen.main.bounds.height
let kScreenWidth: Double = UIScreen.main.bounds.width
let kStatusBarHeight: Double = kIOSX ? 44 : 20
let kNavigationHeight: Double = kIOSX ? 88 : 64
let kSafeBottomHeight: Double = kIOSX ? 34 : 0
let kTopSensorHeight: Double = kIOSX ? 32 : 0
let kAPPNavigationHeight: Double = kStatusBarHeight + 70
let kAPPSafeBottomHeight: Double = kIOSX ? 20 : 0

//
//#define IPHONE_NAVIGATIONBAR_HEIGHT  (IS_IPHONE_X ? 88 : 64)
//#define APP_NAVIGATIONBAR_HEIGHT     (IPHONE_STATUSBAR_HEIGHT + 70)
//#define IPHONE_STATUSBAR_HEIGHT      (IS_IPHONE_X ? 44 : 20)
//#define IPHONE_SAFEBOTTOMAREA_HEIGHT (IS_IPHONE_X ? 34 : 0)
//#define APP_SAFEBOTTOMAREA_HEIGHT    (IS_IPHONE_X ? 20 : 0)
//#define IPHONE_TOPSENSOR_HEIGHT      (IS_IPHONE_X ? 32 : 0)

extension UIDevice {
    func isiPhoneX() -> Bool {
        var isMore: Bool = false
        if #available(iOS 11.0, *) {
            isMore = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0.0
        }
        return isMore
    }
}

//extension UIApplication {
//    var keyWindow: UIWindow? {
//        // Get connected scenes
//        return UIApplication.shared.connectedScenes
//            // Keep only active scenes, onscreen and visible to the user
//            .filter { $0.activationState == .foregroundActive }
//            // Keep only the first `UIWindowScene`
//            .first(where: { $0 is UIWindowScene })
//            // Get its associated windows
//            .flatMap({ $0 as? UIWindowScene })?.windows
//            // Finally, keep only the key window
//            .first(where: \.isKeyWindow)
//    }
//
//}

enum BillDateType {
    case BillDateType_Today
    case BillDateType_AnotherDay
    case BillDateType_SomeMonth
    case BillDateType_SomeYear
}

//enum BillExpenditureType {
//    case BillExpenditureType_Shop
//    case BillExpenditureType_Food
//    case BillExpenditureType_Entertainment
//    case BillExpenditureType_Transportation
//    case BillExpenditureType_Medical
//    case BillExpenditureType_House
//    case BillExpenditureType_Communication
//    case BillExpenditureType_Learning
//    case BillExpenditureType_Other
//}
//
//enum BillIncomeType {
//    case BillIncomeType_Salary
//    case BillIncomeType_Bonus
//    case BillIncomeType_Investment
//    case BillIncomeType_Windfall
//    case BillIncomeType_Other
//}
