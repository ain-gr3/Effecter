//
//  Created by Ain Obara on 2023/10/16.
//

public protocol Effecter {

    associatedtype State
    associatedtype Event

    func run(event: Event, on state: inout State) -> Effect<Event>?
}
