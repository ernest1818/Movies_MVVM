// FileManagerService.swift
// Copyright © Avagyan Ernest. All rights reserved.

import Foundation

/// Файл менеджер
final class FileManagerService: FileManagerServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let pathName = "images"
        static let slashChar = "/"
        static let slashString = "/"
        static let defaultText = "default"
        static let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    }

    // MARK: - Private Properties

    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime
    private static let pathName: String = {
        let pathName = Constants.pathName
        guard let cachesDirectory = FileManager.default.urls(
            for:
            .cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(
            pathName,
            isDirectory:
            true
        )
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private var imagesMap = [String: Data]()

    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data?) {
        guard let fileName = getFilePath(url: url),
              let data = data else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    func getImageFromCache(url: String) -> Data? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(
                  atPath:
                  fileName
              ),
              let modificationDate = info[FileAttributeKey.modificationDate] as?
              Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        let urlDataPath = URL(fileURLWithPath: fileName)
        guard
            lifeTime <= cacheLifeTime else { return nil }
        do {
            let data = try Data(contentsOf: urlDataPath)
            imagesMap[url] = data
            return data
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
            let hashName = url.split(separator: Constants.slashChar).last
        else {
            return nil
        }
        return cachesDirectory
            .appendingPathComponent("\(FileManagerService.pathName)\(Constants.slashString)\(hashName)").path
    }
}
