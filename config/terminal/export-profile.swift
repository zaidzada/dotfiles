// Export the _zz Terminal.app profile with every color slot set to an
// appearance-adaptive macOS system color.
import AppKit
let d = UserDefaults(suiteName: "com.apple.Terminal")!
var p = d.dictionary(forKey: "Window Settings")!["_zz"] as! [String: Any]
let colors: [String: String] = [
  "ANSIBlackColor": "textColor",
  "ANSIRedColor": "systemRedColor",
  "ANSIGreenColor": "systemGreenColor",
  "ANSIYellowColor": "systemYellowColor",
  "ANSIBlueColor": "systemBlueColor",
  "ANSIMagentaColor": "systemPurpleColor",
  "ANSICyanColor": "systemTealColor",
  "ANSIWhiteColor": "unemphasizedSelectedTextBackgroundColor",
  "ANSIBrightBlackColor": "systemGrayColor",
  "ANSIBrightRedColor": "systemRedColor",
  "ANSIBrightGreenColor": "systemGreenColor",
  "ANSIBrightYellowColor": "systemYellowColor",
  "ANSIBrightBlueColor": "systemBlueColor",
  "ANSIBrightMagentaColor": "systemPurpleColor",
  "ANSIBrightCyanColor": "systemTealColor",
  "ANSIBrightWhiteColor": "unemphasizedSelectedTextBackgroundColor",
  "BackgroundColor": "textBackgroundColor",
  "TextColor": "textColor",
  "TextBoldColor": "textColor",
  "SelectionColor": "selectedTextBackgroundColor",
]
for (key, name) in colors {
  let c = NSColor(catalogName: "System", colorName: name)!
  p[key] = try! NSKeyedArchiver.archivedData(withRootObject: c, requiringSecureCoding: true)
}
p["name"] = "_zz"
let out = try! PropertyListSerialization.data(fromPropertyList: p, format: .xml, options: 0)
try! out.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
