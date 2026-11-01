import Testing
@testable import AppTemplate

@Suite("AppModel")
struct AppModelTests {
    @Test func startsOnHome() {
        #expect(AppModel().selectedTab == .home)
    }

    @Test func expensiveWorkRunsOffTheMainActor() async {
        #expect(await AppModel.expensiveWork([1, 2, 3]) == 6)
    }
}
