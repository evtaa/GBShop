//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Alexandr Evtodiy on 04.04.2021.
//

import XCTest

class AuthUITests: XCTestCase {
    var app: XCUIApplication!
    var authView: XCUIElement!
    var authNavigationBar: XCUIElement!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        authView = app.otherElements["authView"]
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginSuccess() throws {
        self.enterAuthData(username: "test", password: "test")
        let catalogProductsView = app.otherElements["catalogProductsView"]
        XCTAssertTrue(catalogProductsView.waitForExistence(timeout: 2))
    }
    
    func testLoginFailedUsername() throws {
        self.enterAuthData(username: "", password: "test")
        let resultLabel = authView.staticTexts["resultData"]
        XCTAssertTrue(resultLabel.exists)
        XCTAssertEqual(resultLabel.label, "You entered invalid username")
    }
    
    func testLoginFailedPassword() throws {
        self.enterAuthData(username: "test", password: "")
        let resultLabel = authView.staticTexts["resultData"]
        XCTAssertTrue(resultLabel.exists)
        XCTAssertEqual(resultLabel.label, "You entered invalid password")
    }
    
    func testLogoutSuccess() throws {
        let logoutButton = app.navigationBars["authNavigationBar"].buttons["logout"]
        XCTAssertTrue(logoutButton.exists)
        logoutButton.tap()
        let resultLabel = authView.staticTexts["resultData"]
        XCTAssertTrue(resultLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(resultLabel.label, "You are logged out")
    }
    
    func testCreateAccountSuccess() throws {
        let createAccountButton = authView.buttons["createAccountButton"]
        XCTAssertTrue(createAccountButton.exists)
        createAccountButton.tap()
        let registrationView = app.otherElements["registrationView"]
        XCTAssertTrue(registrationView.waitForExistence(timeout: 2))
    }

    private func enterAuthData(username: String, password: String) {
        XCTAssertTrue(authView.waitForExistence(timeout: 1))
        
        let usernameTextField  = authView/*@START_MENU_TOKEN@*/.textFields["username"]/*[[".scrollViews.textFields[\"username\"]",".textFields[\"username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(usernameTextField.exists)
       
        let passwordTextField = authView/*@START_MENU_TOKEN@*/.secureTextFields["password"]/*[[".scrollViews.secureTextFields[\"password\"]",".secureTextFields[\"password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(passwordTextField.exists)

        usernameTextField.tap()
        usernameTextField.typeText(username)
       
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        let loginButton = authView.buttons["login"]
        XCTAssertTrue(loginButton.isHittable)
        loginButton.tap()
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
