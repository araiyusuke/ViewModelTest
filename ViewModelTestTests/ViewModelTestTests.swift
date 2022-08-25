//
//  ViewModelTestTests.swift
//  ViewModelTestTests
//
//  Created by 名前なし on 2022/08/21.
//

import XCTest
import SwiftUI

import SnapshotTesting

@testable import ViewModelTest

class ViewModelTestTests: XCTestCase {

    let record = false

    func testExample1() throws {
        let viewModel = ViewModel()
        let contentView = ContentView(viewModel: viewModel)
        viewModel.name = "test"
        viewModel.password = "test"
        viewModel.send(.onInputComplete)
        sleep(4)
        assertSnapshot(matching: contentView, as: .image, record: record)
    }

    func testExample2() throws {
        let viewModel = ViewModel()
        let contentView = ContentView(viewModel: viewModel)
        viewModel.name = "魚さん"
        viewModel.send(.onCommitInputName)

        assertSnapshot(matching: contentView, as: .image, record: record)
    }
}
