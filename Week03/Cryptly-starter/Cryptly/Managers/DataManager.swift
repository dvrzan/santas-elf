/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class DataManager {
  static let shared = DataManager()
  let cryptoData = DataGenerator.shared.generateData()
  
  public var allCurrencies: String {
    guard let cryptoData = cryptoData else { return "No data available" }
    return cryptoData.reduce("") { (result, currency) in
      result + currency.name + ", "
    }
  }
  
  public var risingCurrencies: String {
    guard let cryptoData = cryptoData else { return "No data available" }
    return cryptoData.filter {
      $0.trend == .rising
    }.reduce("") { (result, currency) in
      result + currency.name + ", "
    }
  }
  
  public var fallingCurrencies: String {
    guard let cryptoData = cryptoData else { return "No data available" }
    return cryptoData.filter {
      $0.trend == .falling
    }.reduce("") { (result, currency) in
      result + currency.name + ", "
    }
  }
  
  public func mostRisingCurrency() -> String {
    guard let cryptoData = cryptoData else { return "N/A" }
    let array = cryptoData.map { $0.valueRise }
    return String(array.max() ?? 0)
  }
  
  public func mostFallingCurrency() -> String {
    guard let cryptoData = cryptoData else { return "N/A" }
    let array = cryptoData.map { $0.valueRise }
    return String(array.min() ?? 0)
  }
  
  private init() {}
  
}
