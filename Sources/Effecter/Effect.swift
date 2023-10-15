//
//  Created by Ain Obara on 2023/10/16.
//

import Foundation

public enum Effect<Event> {

    case run(Event)
    case task(id: AnyHashable? = nil, handler: () async -> Event?)
    case cancel(AnyHashable)
    case zip([Effect<Event>])
}

extension EffectiveObject {

    func runEffecter(_ effect: Effect<Event>) {
        switch effect {
        case .run(let event):
            if let nextEffect = effecter.run(event: event, on: &state) {
                runEffecter(nextEffect)
            }

        case .task(let id, let handler):
            let task = Task<Void, Never> {
                if let event = await handler() {
                    if let nextEffect = effecter.run(event: event, on: &state) {
                        runEffecter(nextEffect)
                    }
                }
            }
            if let id = id {
                cancellables[id] = task
            }

        case .cancel(let id):
            cancellables[id]?.cancel()

        case .zip(let effects):
            for effect in effects {
                runEffecter(effect)
            }
        }
    }
}
