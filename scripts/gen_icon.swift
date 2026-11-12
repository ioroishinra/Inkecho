#!/usr/bin/env swift
import AppKit
import Foundation

let bgColor  = NSColor(red: 0.059, green: 0.051, blue: 0.043, alpha: 1)
let fgColor  = NSColor(red: 0.831, green: 0.596, blue: 0.431, alpha: 1)
let char     = "書"

func makeIcon(size: Int) -> NSImage {
    let s = CGFloat(size)
    let rep = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: size, pixelsHigh: size,
        bitsPerSample: 8, samplesPerPixel: 4,
        hasAlpha: true, isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0, bitsPerPixel: 0
    )!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
    bgColor.setFill()
    NSRect(x: 0, y: 0, width: s, height: s).fill()
    let fontSize = s * 0.55
    let font = NSFont(name: "HiraginoSans-W6", size: fontSize)
        ?? NSFont.systemFont(ofSize: fontSize, weight: .bold)
    let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: fgColor]
    let str = NSAttributedString(string: char, attributes: attrs)
    let strSize = str.size()
    str.draw(at: NSPoint(x: (s - strSize.width) / 2, y: (s - strSize.height) / 2))
    NSGraphicsContext.restoreGraphicsState()
    let img = NSImage(size: NSSize(width: s, height: s))
    img.addRepresentation(rep)
    return img
}

func savePNG(_ image: NSImage, to path: String) {
    guard let tiff = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiff),
          let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Failed to encode \(path)")
    }
    try! png.write(to: URL(fileURLWithPath: path))
}

let root   = URL(fileURLWithPath: CommandLine.arguments[1])
let iosDir = root.appendingPathComponent("Apps/Inkecho-iOS/Assets.xcassets/AppIcon.appiconset")
let macDir = root.appendingPathComponent("Apps/Inkecho-macOS/Assets.xcassets/AppIcon.appiconset")

// iOS — traditional multi-size format
let iosSizes: [(idiom: String, size: String, scale: String, px: Int)] = [
    ("iphone", "20x20",   "2x", 40),
    ("iphone", "20x20",   "3x", 60),
    ("iphone", "29x29",   "2x", 58),
    ("iphone", "29x29",   "3x", 87),
    ("iphone", "40x40",   "2x", 80),
    ("iphone", "40x40",   "3x", 120),
    ("iphone", "60x60",   "2x", 120),
    ("iphone", "60x60",   "3x", 180),
    ("ipad",   "20x20",   "1x", 20),
    ("ipad",   "20x20",   "2x", 40),
    ("ipad",   "29x29",   "1x", 29),
    ("ipad",   "29x29",   "2x", 58),
    ("ipad",   "40x40",   "1x", 40),
    ("ipad",   "40x40",   "2x", 80),
    ("ipad",   "76x76",   "1x", 76),
    ("ipad",   "76x76",   "2x", 152),
    ("ipad",   "83.5x83.5","2x",167),
    ("ios-marketing","1024x1024","1x",1024)
]
var iosImages: [String] = []
var seen: [Int: String] = [:]
for entry in iosSizes {
    let fn: String
    if let existing = seen[entry.px] {
        fn = existing
    } else {
        fn = "icon_\(entry.px).png"
        savePNG(makeIcon(size: entry.px), to: iosDir.appendingPathComponent(fn).path)
        seen[entry.px] = fn
        print("iOS \(entry.px)px: done")
    }
    iosImages.append("    { \"filename\": \"\(fn)\", \"idiom\": \"\(entry.idiom)\", \"scale\": \"\(entry.scale)\", \"size\": \"\(entry.size)\" }")
}
try! "{\n  \"images\": [\n\(iosImages.joined(separator: ",\n"))\n  ],\n  \"info\": { \"author\": \"xcode\", \"version\": 1 }\n}"
    .write(to: iosDir.appendingPathComponent("Contents.json"), atomically: true, encoding: .utf8)
print("iOS: done")

// macOS — standard sizes
let macSizes = [(16,1),(16,2),(32,1),(32,2),(128,1),(128,2),(256,1),(256,2),(512,1),(512,2)]
var images: [String] = []
for (sz, sc) in macSizes {
    let px = sz * sc
    let fn = "icon_\(sz)x\(sz)@\(sc)x.png"
    savePNG(makeIcon(size: px), to: macDir.appendingPathComponent(fn).path)
    images.append("    { \"filename\": \"\(fn)\", \"idiom\": \"mac\", \"scale\": \"\(sc)x\", \"size\": \"\(sz)x\(sz)\" }")
    print("macOS \(px)px: done")
}
try! "{\n  \"images\": [\n\(images.joined(separator: ",\n"))\n  ],\n  \"info\": { \"author\": \"xcode\", \"version\": 1 }\n}"
    .write(to: macDir.appendingPathComponent("Contents.json"), atomically: true, encoding: .utf8)
print("All done.")
