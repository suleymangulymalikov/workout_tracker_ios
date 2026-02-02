//
//  Workout_TrackerUITests.swift
//  Workout TrackerUITests
//
//  Created by stud on 19/01/2026.
//

import XCTest

final class Workout_TrackerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    //    1) App launches and Home is visible
    func test01_AppLaunches_ShowHomeScreen() {
        XCTAssertTrue(app.tabBars.buttons["Home"].exists)
        XCTAssertTrue(app.staticTexts["Workout Tracker"].exists)
    }
    
    //    2) Tapbar contains expected tabs
    func test02_TabBar_ShowAllTabs() {
        let tabBarsQuery = app.tabBars
        XCTAssertTrue(tabBarsQuery.buttons["Home"].exists)
        XCTAssertTrue(tabBarsQuery.buttons["Workouts"].exists)
        XCTAssertTrue(tabBarsQuery.buttons["Progress"].exists)
        XCTAssertTrue(tabBarsQuery.buttons["Settings"].exists)
        
    }
    
    //    3)Navigate to Workouts tab
    func test03_TapWorkoustTab_ShowsWorkoutsTitle() {
        app.tabBars.buttons["Workouts"].tap()
        XCTAssertTrue(app.staticTexts["Workouts"].exists)
    }
    
    //    4)Navigate to to Progress Tab
    func test04_TapProgressTab_ShowsProgressTitle() {
        app.tabBars.buttons["Progress"].tap()
        XCTAssertTrue(app.staticTexts["Progress"].exists)
    }
    
//    5) Navigate to Settings tab
    func test05_TapSettingsTab_ShowsSettingsTitle() {
        app.tabBars.buttons["Settings"].tap()
        XCTAssertTrue(app.staticTexts["Settings"].exists)
    }
    
//    6) Workouts tab shows "Create Workout" text
    func test06_TapWorkoutsTab_ShowCreateWorkoutText() {
        app.tabBars.buttons["Workouts"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["Create Workout"].firstMatch.exists)
    }
    
//    7) Workouts tab have "Add Exercise" button
    func test07_TapWorkoutsTab_ShowAddExerciseButton() {
        app.tabBars.buttons["Workouts"].firstMatch.tap()
        XCTAssertTrue(app.buttons["Add Exercise"].firstMatch.exists)
    }
    
//    8) Workouts tab have "Save Workout" button
    func test08_TapWorkoutsTab_ShowSaveWorkoutButton() {
        app.tabBars.buttons["Workouts"].firstMatch.tap()
        XCTAssertTrue(app.buttons["Save Workout"].firstMatch.exists)
    }
    
//    9) Show home quick actions
    func test09_HomeScreen_ShowQuickActions() {
        app.tabBars.buttons["Home"].tap()
        XCTAssertTrue(app.buttons["Workouts"].firstMatch.isHittable)
        XCTAssertTrue(app.buttons["Progress"].firstMatch.isHittable)
        XCTAssertTrue(app.buttons["Settings"].firstMatch.isHittable)
    }
}
