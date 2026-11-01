import Testing
@testable import DesignSystem

@Suite("Palette contrast")
struct PaletteContrastTests {
    /// Every declared pairing meets its minimum in light, dark and both Increase Contrast variants.
    @Test(arguments: Palette.contrastRequirements.map(\.name))
    func pairingMeetsMinimum(name: String) throws {
        let requirement = try #require(Palette.contrastRequirements.first { $0.name == name })
        let palette = Theme.default.palette
        let fg = palette[keyPath: requirement.foreground]
        let bg = palette[keyPath: requirement.background]

        for ((variant, f), (_, b)) in zip(fg.variants, bg.variants) {
            let ratio = f.contrastRatio(with: b)
            #expect(ratio >= requirement.minimum, "\(name) in \(variant): \(f) on \(b) is \(ratio):1, needs \(requirement.minimum):1")
        }
    }

    /// Increase Contrast variants must never be weaker than the default ones.
    @Test(arguments: Palette.contrastRequirements.map(\.name))
    func highContrastIsNotWeaker(name: String) throws {
        let requirement = try #require(Palette.contrastRequirements.first { $0.name == name })
        let palette = Theme.default.palette
        let fg = palette[keyPath: requirement.foreground]
        let bg = palette[keyPath: requirement.background]

        #expect(fg.lightHighContrast.contrastRatio(with: bg.lightHighContrast) >= fg.light.contrastRatio(with: bg.light) - 0.01)
        #expect(fg.darkHighContrast.contrastRatio(with: bg.darkHighContrast) >= fg.dark.contrastRatio(with: bg.dark) - 0.01)
    }

    @Test func contrastMathMatchesWCAG() {
        #expect(abs(RGB(0x000000).contrastRatio(with: RGB(0xFFFFFF)) - 21) < 0.01)
        #expect(abs(RGB(0x777777).contrastRatio(with: RGB(0xFFFFFF)) - 4.48) < 0.01)
    }
}

@Suite("Motion")
struct MotionTests {
    @Test func reduceMotionDisablesAmbientAndUsesReducedCurve() {
        let motion = MotionStyle.calm
        #expect(motion.animation(.ambient, reduceMotion: true) == nil)
        #expect(motion.animation(.standard, reduceMotion: true) == motion.reduced)
        #expect(motion.animation(.standard, reduceMotion: false) == motion.standard)
    }
}
