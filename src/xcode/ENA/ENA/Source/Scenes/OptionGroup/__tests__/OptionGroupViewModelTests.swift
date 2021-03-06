//
// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import XCTest
import Combine
@testable import ENA

class OptionGroupViewModelTests: XCTestCase {

    func testInitialSelectionNil() {
		let viewModel = OptionGroupViewModel(
			options: [.option(title: "0"), .option(title: "1"), .option(title: "2")],
			initialSelection: nil
		)

		XCTAssertNil(viewModel.selection)
    }

	func testInitialOptionSelectionNotNil() {
		let initialSelection: OptionGroupViewModel.Selection = .option(index: 1)

		let viewModel = OptionGroupViewModel(
			options: [.option(title: "0"), .option(title: "1"), .option(title: "2")],
			initialSelection: initialSelection
		)

		XCTAssertEqual(viewModel.selection, initialSelection)
    }

	func testInitialOptionSelectionNilChanged() {
		let viewModel = OptionGroupViewModel(
			options: [.option(title: "0"), .option(title: "1"), .option(title: "2")],
			initialSelection: nil
		)

		viewModel.optionTapped(index: 0)

		XCTAssertEqual(viewModel.selection, .option(index: 0))
    }

	func testInitialOptionSelectionNotNilChanged() {
		let viewModel = OptionGroupViewModel(
			options: [.option(title: "0"), .option(title: "1"), .option(title: "2")],
			initialSelection: .option(index: 1)
		)

		viewModel.optionTapped(index: 0)

		XCTAssertEqual(viewModel.selection, .option(index: 0))
    }

	func testInitialOptionSelectionNotNilChangedTwice() {
		let viewModel = OptionGroupViewModel(
			options: [.option(title: "0"), .option(title: "1"), .option(title: "2")],
			initialSelection: .option(index: 1)
		)

		viewModel.optionTapped(index: 0)
		viewModel.optionTapped(index: 2)

		XCTAssertEqual(viewModel.selection, .option(index: 2))
    }

	func testInitialOptionSelectionNotNilChangedToTheSameOptionTwice() {
		let viewModel = OptionGroupViewModel(
			options: [.option(title: "0"), .option(title: "1"), .option(title: "2")],
			initialSelection: .option(index: 1)
		)

		viewModel.optionTapped(index: 0)
		viewModel.optionTapped(index: 0)

		XCTAssertEqual(viewModel.selection, .option(index: 0))
    }

	func testInitialMultipleChoiceOptionSelectionNotNil() {
		let initialSelection: OptionGroupViewModel.Selection = .multipleChoiceOption(index: 1, selectedChoices: [0, 4])

		let viewModel = OptionGroupViewModel(
			options: [
				.option(title: "0"),
				.multipleChoiceOption(title: "1", choices: [
					.init(iconImage: nil, title: "1.0"),
					.init(iconImage: nil, title: "1.1"),
					.init(iconImage: nil, title: "1.2"),
					.init(iconImage: nil, title: "1.3"),
					.init(iconImage: nil, title: "1.4")
				])
			],
			initialSelection: initialSelection
		)

		XCTAssertEqual(viewModel.selection, initialSelection)
    }

	func testInitialMultipleChoiceOptionSelectionNotNilDeselectOne() {
		let initialSelection: OptionGroupViewModel.Selection = .multipleChoiceOption(index: 1, selectedChoices: [0, 4])

		let viewModel = OptionGroupViewModel(
			options: [
				.option(title: "0"),
				.multipleChoiceOption(title: "1", choices: [
					.init(iconImage: nil, title: "1.0"),
					.init(iconImage: nil, title: "1.1"),
					.init(iconImage: nil, title: "1.2"),
					.init(iconImage: nil, title: "1.3"),
					.init(iconImage: nil, title: "1.4")
				])
			],
			initialSelection: initialSelection
		)

		viewModel.multipleChoiceOptionTapped(index: 1, choiceIndex: 4)

		XCTAssertEqual(viewModel.selection, .multipleChoiceOption(index: 1, selectedChoices: [0]))
    }

	func testInitialMultipleChoiceOptionSelectionNotNilSelectOneMore() {
		let initialSelection: OptionGroupViewModel.Selection = .multipleChoiceOption(index: 1, selectedChoices: [0, 4])

		let viewModel = OptionGroupViewModel(
			options: [
				.option(title: "0"),
				.multipleChoiceOption(title: "1", choices: [
					.init(iconImage: nil, title: "1.0"),
					.init(iconImage: nil, title: "1.1"),
					.init(iconImage: nil, title: "1.2"),
					.init(iconImage: nil, title: "1.3"),
					.init(iconImage: nil, title: "1.4")
				])
			],
			initialSelection: initialSelection
		)

		viewModel.multipleChoiceOptionTapped(index: 1, choiceIndex: 2)

		XCTAssertEqual(viewModel.selection, .multipleChoiceOption(index: 1, selectedChoices: [0, 2, 4]))
    }

	func testInitialMultipleChoiceOptionSelectionNotNilDeselectAll() {
		let initialSelection: OptionGroupViewModel.Selection = .multipleChoiceOption(index: 1, selectedChoices: [0, 4])

		let viewModel = OptionGroupViewModel(
			options: [
				.option(title: "0"),
				.multipleChoiceOption(title: "1", choices: [
					.init(iconImage: nil, title: "1.0"),
					.init(iconImage: nil, title: "1.1"),
					.init(iconImage: nil, title: "1.2"),
					.init(iconImage: nil, title: "1.3"),
					.init(iconImage: nil, title: "1.4")
				])
			],
			initialSelection: initialSelection
		)

		viewModel.multipleChoiceOptionTapped(index: 1, choiceIndex: 0)
		viewModel.multipleChoiceOptionTapped(index: 1, choiceIndex: 4)

		XCTAssertNil(viewModel.selection)
    }

	func testInitialOptionSelectionNotNilSelectFirstMultipleChoiceOption() {
		let initialSelection: OptionGroupViewModel.Selection = .option(index: 0)

		let viewModel = OptionGroupViewModel(
			options: [
				.option(title: "0"),
				.multipleChoiceOption(title: "1", choices: [
					.init(iconImage: nil, title: "1.0"),
					.init(iconImage: nil, title: "1.1"),
					.init(iconImage: nil, title: "1.2"),
					.init(iconImage: nil, title: "1.3"),
					.init(iconImage: nil, title: "1.4")
				])
			],
			initialSelection: initialSelection
		)

		viewModel.multipleChoiceOptionTapped(index: 1, choiceIndex: 2)

		XCTAssertEqual(viewModel.selection, .multipleChoiceOption(index: 1, selectedChoices: [2]))
    }

}
