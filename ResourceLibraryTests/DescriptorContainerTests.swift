//
//  DescriptorContainerTests.swift
//  ResourceLibraryTests
//
//  Created by Илья Зимонин on 01.09.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

import XCTest
@testable import ResourceLibrary

final class DescriptorContainerTests: XCTest {

	func testPutAndResolve() {
		// Arrange
		let container = Core.DescriptorContainer()
		let folderName = "folder"
		let descriptor = Core.Descriptor(resourceClass: TestResource.self, folderName: folderName)

		// Act
		container.put(descriptor: descriptor)

		// Assert
		guard let resolvedDescriptor = container.resolve(TestResource.self) else {
			XCTFail("Descriptor was not resolved")
			return
		}
		XCTAssert(resolvedDescriptor.folderName == "folder")
	}

	func testAppend() {
		// Arrange
		let firstContainer = Core.DescriptorContainer()
		let firstFolderName = "folder"
		let firstDescriptor = Core.Descriptor(resourceClass: TestResource.self, folderName: firstFolderName)
		let secondContainer = Core.DescriptorContainer()
		let secondFolderName = "folder2"
		let secondDescriptor = Core.Descriptor(resourceClass: Model.Image.self, folderName: secondFolderName)

		// Act
		firstContainer.put(descriptor: firstDescriptor)
		secondContainer.put(descriptor: secondDescriptor)
		firstContainer.append(container: secondContainer)

		// Assert
		guard let firstResolvedDescriptor = firstContainer.resolve(TestResource.self) else {
			XCTFail("Descriptor was not resolved")
			return
		}
		guard let secondResolvedDescriptor = firstContainer.resolve(Model.Image.self) else {
			XCTFail("Descriptor was not resolved")
			return
		}
		XCTAssert(firstResolvedDescriptor.folderName == firstFolderName)
		XCTAssert(secondResolvedDescriptor.folderName == secondFolderName)
	}

	func testForeach() {
		// Arrange
		let container = Core.DescriptorContainer()
		let firstDescriptor = Core.Descriptor(resourceClass: TestResource.self, folderName: "folder1")
		let secondDescriptor = Core.Descriptor(resourceClass: Model.Image.self, folderName: "folder2")

		// Act
		container.put(descriptor: firstDescriptor)
		container.put(descriptor: secondDescriptor)
		var count = 0
		container.foreach { descriptor in
			count = count + 1
		}

		// Assert
		XCTAssert(count == 2)
	}
}
