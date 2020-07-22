//
//  SessionStore.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import Foundation
import Combine

final class SessionStore: ObservableObject {
    @Published  var current : Corona?
    init(){
        self.fetch()
    }
}

extension SessionStore{
    func fetch(){
        CoronaClient.fetchSummary {
            self.current = $0
        }
    }
}
