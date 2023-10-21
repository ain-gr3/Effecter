//
//  Created by Ain Obara on 2023/10/21.
//

import SwiftUI

@propertyWrapper
public struct BindableState<V> {

    private var binding: Binding<V>

    public var wrappedValue: V {
        didSet {
            binding.wrappedValue = wrappedValue
        }
    }

    public init(_ binding: Binding<V>) {
        self.binding = binding
        self.wrappedValue = binding.wrappedValue
    }

    public static func constant(_ value: V) -> Self {
        .init(.constant(value))
    }
}
