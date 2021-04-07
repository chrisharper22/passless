// swiftlint:disable all

import Foundation
import Orion
import PasslessC

extension SBBootDefaultsHook {
    enum _Glue: _GlueClassHook {
        typealias HookType = SBBootDefaultsHook

        final class OrigType: SBBootDefaultsHook, _GlueClassHookTrampoline {
            @objc override func dontLockAfterCrash() -> Bool {
                _Glue.orion_orig1(target, _Glue.orion_sel1)
            }
        }

        final class SuprType: SBBootDefaultsHook, _GlueClassHookTrampoline {
            @objc override func dontLockAfterCrash() -> Bool {
                callSuper((@convention(c) (UnsafeRawPointer, Selector) -> Bool).self) { $0($1, _Glue.orion_sel1) }
            }
        }

        static let storage = initializeStorage()

        private static let orion_sel1 = #selector(SBBootDefaultsHook.dontLockAfterCrash as (SBBootDefaultsHook) -> () -> Bool)
        private static var orion_orig1: @convention(c) (Target, Selector) -> Bool = { target, _cmd in
            SBBootDefaultsHook(target: target).dontLockAfterCrash()
        }
    
        static func activate(withClassHookBuilder builder: inout _GlueClassHookBuilder) {
            builder.addHook(orion_sel1, orion_orig1, isClassMethod: false) { orion_orig1 = $0 }
        }
    }
}

#if canImport(OrionBackend_Substrate)
import OrionBackend_Substrate
#endif

@_cdecl("orion_init")
func orion_init() {
    DefaultTweak.activate(
        backend: Backends.Substrate(),
        hooks: [
            SBBootDefaultsHook._Glue.self
        ]
    )
}
