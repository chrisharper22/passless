import Orion
import PasslessC

class SBBootDefaultsHook: ClassHook<SBBootDefaults> {
    func dontLockAfterCrash() -> Bool {
        return true
    }
}
