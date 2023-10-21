//
//  Created by Ain Obara on 2023/10/16.
//

import Foundation

public enum AsyncResult<Success> {

    case success(Success)
    case failure(Error)

    public init(_ handler: @escaping () async throws -> Success) async {
        do {
            self = try await .success(
                handler()
            )
        } catch {
            self = .failure(error)
        }
    }

    public static func detached(_ handler: @escaping () async throws -> Success) async -> Self {
        do {
            return try await .success(
                Task<Success, any Error>.detached {
                    try await handler()
                }.value
            )
        } catch {
            return .failure(error)
        }
    }
}

