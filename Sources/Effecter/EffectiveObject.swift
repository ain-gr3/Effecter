//
//  Created by ain on 2023/10/16
//


import Combine
import SwiftUI

@dynamicMemberLookup
@MainActor
public final class EffectiveObject<E>: ObservableObject where E: Effecter {

    public typealias State = E.State
    public typealias Event = E.Event

    let effecter: E

    @Published var state: State

    var cancellables: [AnyHashable: Task<Void, Never>] = [:]

    public init(state: State, effecter: E) {
        self.state = state
        self.effecter = effecter
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        state[keyPath: keyPath]
    }

    public func send(_ event: Event) {
        runEffecter(.run(event))
    }
}
