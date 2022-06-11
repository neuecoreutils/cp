import Foundation
import ArgumentParser

func copy(_ i: String, _ o: String) {

    if FileManager.default.fileExists(atPath: i) == false {
        print("file \(i) does not exist.")
        exit(127)
    }
 
    let input = InputStream(fileAtPath: i)!
    let output = OutputStream(toFileAtPath: o, append: false)!
    input.open()
    output.open()
    let bufferSize = 1024
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
    defer {
        buffer.deallocate()
    }
    while input.hasBytesAvailable {
        let read = input.read(buffer, maxLength: bufferSize)
        if read > 0 {
            output.write(buffer, maxLength: read)
        }
    }
}

@main
struct cp: ParsableCommand {
    @Argument(help: "The file to copy")
    var ip: String

    @Argument(help: "The destination file")
    var out: String

    mutating func run() throws {
        copy(ip, out)
    }
}