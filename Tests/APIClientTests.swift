//
//  APIClientTests.swift
//  APIClientTests
//
//  Created by Jonathan Bailey on 6/20/20.
//  Copyright © 2020 Jonathan Bailey. All rights reserved.
//

import XCTest
@testable import APIClient

class APIClientTests: XCTestCase {

    let client = APIClient("jsonplaceholder.typicode.com")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test__get_request() {
        let request = GetPosts(userId: 1)
        let expectation = self.expectation(description: "Waiting for response...")
        client.send(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
                break
            case .failure(let err):
                print(err)
                XCTAssert(false)
                expectation.fulfill()
                break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    func test__post_request() {
        let request = CreateNewPost(newPost: Post(userId: 4, id: 1, title: "Hello, World!", body: "Test body string."))
        let expectation = self.expectation(description: "Waiting for response...")
        client.send(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
                break
            case .failure(let err):
                print(err)
                XCTAssert(false)
                expectation.fulfill()
                break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    func test__post_request__no_response() {
        let request = CreateNewPost_NR(newPost: Post(userId: 4, id: 1, title: "Hello, World!", body: "Test body string."))
        let expectation = self.expectation(description: "Waiting for response...")
        client.send(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
                break
            case .failure(let err):
                print(err)
                XCTAssert(false)
                expectation.fulfill()
                break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    func test__put_request() {
        // Assuming we've already created a post with the following ids...
        let request = UpdatePostPut(newPost: Post(userId: 1, id: 1, title: "foo", body: "bar"))
        let expectation = self.expectation(description: "Waiting for response...")
        client.send(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
                break
            case .failure(let err):
                print(err)
                XCTAssert(false)
                expectation.fulfill()
                break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    func test__patch_request() {
        // Assuming we've already created a post with the following ids...
        let request = UpdatePostPatch(newPost: Post(userId: 1, id: 1, title: "foo", body: "bar"))
        let expectation = self.expectation(description: "Waiting for response...")
        client.send(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
                break
            case .failure(let err):
                print(err)
                XCTAssert(false)
                expectation.fulfill()
                break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }

    func test__delete_request() {
        let request = DeletePost(postId: 1)
        let expectation = self.expectation(description: "Waiting for response...")
        client.send(request: request, completion: { result in
            switch result {
            case .success(_):
                XCTAssert(true)
                expectation.fulfill()
                break
            case .failure(let err):
                print(err)
                XCTAssert(false)
                expectation.fulfill()
                break
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
