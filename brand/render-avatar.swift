import Foundation
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

let size = 512
let output = CommandLine.arguments[1]
let context = CGContext(
    data: nil,
    width: size,
    height: size,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: CGColorSpaceCreateDeviceRGB(),
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
)!

func color(_ hex: UInt32) -> CGColor {
    CGColor(red: CGFloat((hex >> 16) & 255) / 255,
            green: CGFloat((hex >> 8) & 255) / 255,
            blue: CGFloat(hex & 255) / 255,
            alpha: 1)
}

func circle(_ x: CGFloat, _ y: CGFloat, _ r: CGFloat, fill: CGColor? = nil, stroke: CGColor? = nil, width: CGFloat = 1) {
    let rect = CGRect(x: x - r, y: y - r, width: 2 * r, height: 2 * r)
    if let fill { context.setFillColor(fill); context.fillEllipse(in: rect) }
    if let stroke { context.setStrokeColor(stroke); context.setLineWidth(width); context.strokeEllipse(in: rect) }
}

let navy = color(0x0c1820)
let mint = color(0x7ee0ca)
let amber = color(0xe2b472)
context.setFillColor(navy)
context.fill(CGRect(x: 0, y: 0, width: size, height: size))
context.translateBy(x: 64, y: 448)
context.scaleBy(x: 3, y: -3)
context.setLineCap(.round)
context.setLineJoin(.round)

context.setStrokeColor(mint)
context.setLineWidth(9)
context.move(to: CGPoint(x: 27, y: 91))
context.addLine(to: CGPoint(x: 62, y: 65))
context.addLine(to: CGPoint(x: 99, y: 31))
context.strokePath()

context.setStrokeColor(amber)
context.setLineWidth(6)
context.setLineDash(phase: 0, lengths: [1, 12])
context.move(to: CGPoint(x: 62, y: 65))
context.addLine(to: CGPoint(x: 100, y: 93))
context.strokePath()
context.setLineDash(phase: 0, lengths: [])

circle(27, 91, 8, fill: mint)
circle(62, 65, 10, fill: amber)
circle(99, 31, 8, fill: mint)
circle(100, 93, 8, stroke: amber, width: 5)

let image = context.makeImage()!
let destination = CGImageDestinationCreateWithURL(URL(fileURLWithPath: output) as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(destination, image, nil)
guard CGImageDestinationFinalize(destination) else { fatalError("Could not write PNG") }
