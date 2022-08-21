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

    func testExample() throws {
        let viewModel = ViewModel()
        let contentView = ContentView(viewModel: viewModel)
        viewModel.send(.tapCreateAccountButton)
        assertSnapshot(matching: contentView, as: .image, record: record)
    }
}
