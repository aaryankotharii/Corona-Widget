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
        self.fetch{ val in
            print(val)
        }
    }
}

extension SessionStore{
    func fetch(completion : @escaping(Corona)->()){
        CoronaClient.fetchSummary {
            self.current = $0
            completion($0)
        }
    }
}
