//
//  KeyCode.swift
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

import Foundation

/// All possible key codes for each key on the keyboard.
enum KeyCode: UInt16 {
    case returnKey = 0x24
    case enter = 0x4C
    case tab = 0x30
    case space = 0x31
    case delete = 0x33
    case escape = 0x35
    case command = 0x37
    case shift = 0x38
    case capsLock = 0x39
    case option = 0x3A
    case control = 0x3B
    case rightShift = 0x3C
    case rightOption = 0x3D
    case rightControl = 0x3E
    case leftArrow = 0x7B
    case rightArrow = 0x7C
    case downArrow = 0x7D
    case upArrow = 0x7E
    case volumeUp = 0x48
    case volumeDown = 0x49
    case mute = 0x4A
    case help = 0x72
    case home = 0x73
    case pageUp = 0x74
    case forwardDelete = 0x75
    case end = 0x77
    case pageDown = 0x79
    case function = 0x3F
    case f1 = 0x7A // swiftlint:disable:this identifier_name
    case f2 = 0x78 // swiftlint:disable:this identifier_name
    case f4 = 0x76 // swiftlint:disable:this identifier_name
    case f5 = 0x60 // swiftlint:disable:this identifier_name
    case f6 = 0x61 // swiftlint:disable:this identifier_name
    case f7 = 0x62 // swiftlint:disable:this identifier_name
    case f3 = 0x63 // swiftlint:disable:this identifier_name
    case f8 = 0x64 // swiftlint:disable:this identifier_name
    case f9 = 0x65 // swiftlint:disable:this identifier_name
    case f10 = 0x6D
    case f11 = 0x67
    case f12 = 0x6F
    case f13 = 0x69
    case f14 = 0x6B
    case f15 = 0x71
    case f16 = 0x6A
    case f17 = 0x40
    case f18 = 0x4F
    case f19 = 0x50
    case f20 = 0x5A
    case a = 0x00 // swiftlint:disable:this identifier_name
    case b = 0x0B // swiftlint:disable:this identifier_name
    case c = 0x08 // swiftlint:disable:this identifier_name
    case d = 0x02 // swiftlint:disable:this identifier_name
    case e = 0x0E // swiftlint:disable:this identifier_name
    case f = 0x03 // swiftlint:disable:this identifier_name
    case g = 0x05 // swiftlint:disable:this identifier_name
    case h = 0x04 // swiftlint:disable:this identifier_name
    case i = 0x22 // swiftlint:disable:this identifier_name
    case j = 0x26 // swiftlint:disable:this identifier_name
    case k = 0x28 // swiftlint:disable:this identifier_name
    case l = 0x25 // swiftlint:disable:this identifier_name
    case m = 0x2E // swiftlint:disable:this identifier_name
    case n = 0x2D // swiftlint:disable:this identifier_name
    case o = 0x1F // swiftlint:disable:this identifier_name
    case p = 0x23 // swiftlint:disable:this identifier_name
    case q = 0x0C // swiftlint:disable:this identifier_name
    case r = 0x0F // swiftlint:disable:this identifier_name
    case s = 0x01 // swiftlint:disable:this identifier_name
    case t = 0x11 // swiftlint:disable:this identifier_name
    case u = 0x20 // swiftlint:disable:this identifier_name
    case v = 0x09 // swiftlint:disable:this identifier_name
    case w = 0x0D // swiftlint:disable:this identifier_name
    case x = 0x07 // swiftlint:disable:this identifier_name
    case y = 0x10 // swiftlint:disable:this identifier_name
    case z = 0x06 // swiftlint:disable:this identifier_name
    case zero = 0x1D
    case one = 0x12
    case two = 0x13
    case three = 0x14
    case four = 0x15
    case five = 0x17
    case six = 0x16
    case seven = 0x1A
    case eight = 0x1C
    case nine = 0x19
    case equals = 0x18
    case minus = 0x1B
    case semicolon = 0x29
    case apostrophe = 0x27
    case comma = 0x2B
    case period = 0x2F
    case forwardSlash = 0x2C
    case backslash = 0x2A
    case grave = 0x32
    case leftBracket = 0x21
    case rightBracket = 0x1E
    case keypadDecimal = 0x41
    case keypadMultiply = 0x43
    case keypadPlus = 0x45
    case keypadClear = 0x47
    case keypadDivide = 0x4B
    case keypadMinus = 0x4E
    case keypadEquals = 0x51
    case keypad0 = 0x52
    case keypad1 = 0x53
    case keypad2 = 0x54
    case keypad3 = 0x55
    case keypad4 = 0x56
    case keypad5 = 0x57
    case keypad6 = 0x58
    case keypad7 = 0x59
    case keypad8 = 0x5B
    case keypad9 = 0x5C

    /// Returns the `KeyCode` for a given `Character` instance.
    /// - Parameter char: The `Character` instance to convert to a `KeyCode`.
    /// - Returns:
    ///   - A `KeyCode`.
    static func keyCodeForChar(char: Character) -> KeyCode? { // swiftlint:disable:this cyclomatic_complexity
        switch String(char) {
        case "a":
            return .a
        case "b":
            return .b
        case "c":
            return .c
        case "d":
            return .d
        case "e":
            return .e
        case "f":
            return .f
        case "g":
            return .g
        case "h":
            return .h
        case "i":
            return .i
        case "j":
            return .j
        case "k":
            return .k
        case "l":
            return .l
        case "m":
            return .m
        case "n":
            return .n
        case "o":
            return .o
        case "p":
            return .p
        case "q":
            return .q
        case "r":
            return .r
        case "s":
            return .s
        case "t":
            return .t
        case "u":
            return .u
        case "v":
            return .v
        case "w":
            return .w
        case "x":
            return .x
        case "y":
            return .y
        case "z":
            return .z
        case "0":
            return .zero
        case "1":
            return .one
        case "2":
            return .two
        case "3":
            return .three
        case "4":
            return .four
        case "5":
            return .five
        case "6":
            return .six
        case "7":
            return .seven
        case "8":
            return .eight
        case "9":
            return .nine
        case "=":
            return .equals
        case "-":
            return .minus
        case ";":
            return .semicolon
        case "'":
            return .apostrophe
        case ",":
            return .comma
        case ".":
            return .period
        case "/":
            return .forwardSlash
        case "\\":
            return .backslash
        case "`":
            return .grave
        case "(":
            return .leftBracket
        case ")":
            return .rightBracket
        default:
            return nil
        }
    }
}
