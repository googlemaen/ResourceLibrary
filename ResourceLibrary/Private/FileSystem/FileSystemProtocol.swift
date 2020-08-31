//
//  FileSystemProtocol.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 31.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

protocol FileSystemProtocol {

	func cachesDirectoryURL() throws -> URL

	func createDirectoryIfNeeded(_ path: URL) throws

	func save(data: Data, at path: URL)

	func getData(at path: URL) -> Data?
}
