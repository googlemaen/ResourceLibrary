//
//  Core.Library.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public extension Core {

	final class Library: NSObject {

		private static let queue: OperationQueue = {
			let queue = OperationQueue()
			queue.maxConcurrentOperationCount = 16
			let dispatchQueue = DispatchQueue(label: "resource", qos: .background, attributes: .concurrent)
			queue.underlyingQueue = dispatchQueue
			return queue
		}()

		private let container: DescriptorContainer = ResourceBuilder.createBaseContainer()

		private let service: FileSystem.ResourceService

		public init(folderName: String, extraContainer: DescriptorContainer?) throws {
			let fs = FileSystem.FileSystem()
			service = try FileSystem.ResourceService(folderName: folderName, fileSystem: fs, operationQueue: Library.queue)
			super.init()
			if let extraContainer = extraContainer {
				self.container.append(container: extraContainer)
			}
			try container.foreach { description in
				try service.createDirectoryIfNeeded(description.folderName)
			}
		}

		private convenience init(extraContainer: DescriptorContainer?) throws {
			try self.init(folderName: "ResourceLibraryV1", extraContainer: extraContainer)
		}

		public static func createDefault(_ extraContainer: DescriptorContainer? = nil) throws -> Library {
			return try Library(extraContainer: extraContainer)
		}

		public func read<T, R: ResourceProtocol>(_ resource: R.Type, forKey key: Model.Key, completion: @escaping (R?) -> Void) where R.T == T {
			let queue = OperationQueue.current?.underlyingQueue ?? DispatchQueue.main
			guard let descriptor = container.resolve(resource) else {
				queue.async {
					completion(nil)
				}
				return
			}
			service.read(descriptor: descriptor, forKey: key, completion: completion, completionQueue: queue)
		}

		public func write<T, R: ResourceProtocol>(_ resource: R) where R.T == T {
			guard let descriptor = container.resolve(R.self) else {
				return
			}
			service.write(resource: resource, with: descriptor)
		}
	}
}
