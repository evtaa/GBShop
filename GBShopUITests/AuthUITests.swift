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
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        authView = app.otherElements["authView"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginSuccess() throws {
        self.enterAuthData(username: "test", password: "test")
        let catalogProductsView = app.otherElements["catalogProductsView"]
        XCTAssertTrue(catalogProductsView.waitForExistence(timeout: 10))
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
        XCTAssertTrue(resultLabel.waitForExistence(timeout: 10))
        XCTAssertEqual(resultLabel.label, "You are logged out")
    }
    
    func testCreateAccountSuccess() throws {
        let createAccountButton = authView.buttons["createAccountButton"]
        XCTAssertTrue(createAccountButton.exists)
        createAccountButton.tap()
        let registrationView = app.otherElements["registrationView"]
        XCTAssertTrue(registrationView.waitForExistence(timeout: 10))
    }
    
    func testSnapshot() throws {
        let password = "test"
        let username = "test"
        
        XCTAssertTrue(authView.waitForExistence(timeout: 5))
        snapshot("LoginScreen")

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
        
        let catalogProductsView = app.otherElements["catalogProductsView"]
        XCTAssertTrue(catalogProductsView.waitForExistence(timeout: 10))
        snapshot("ProductsScreen")
    }

    private func enterAuthData(username: String, password: String) {
        XCTAssertTrue(authView.waitForExistence(timeout: 5))
        
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
