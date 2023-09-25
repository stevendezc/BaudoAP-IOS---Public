//
//  toCheckClass.swift
//  BaudoAP
//
//  Created by Codez Studio on 19/08/23.
//

import Foundation
import SwiftUI

class Alerter: ObservableObject {
    @Published var alert: Alert? {
        didSet { isShowingAlert = alert != nil }
    }
    @Published var isShowingAlert = false
}


