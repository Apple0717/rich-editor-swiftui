//
//  RichTextAction.swift
//  RichEditorSwiftUI
//
//  Created by Divyesh Vekariya on 21/10/24.
//

import SwiftUI
import Combine

/**
 This enum defines rich text actions that can be executed on
 a rich text editor.

 This type also serves as a type namespace for other related
 types and views, like ``RichTextAction/Button``.
 */
public enum RichTextAction: Identifiable, Equatable {

    /// Copy the currently selected text, if any.
    case copy

    /// Dismiss any presented software keyboard.
    case dismissKeyboard

    /// Paste a single image.
//    case pasteImage(RichTextInsertion<ImageRepresentable>)
//
//    /// Paste multiple images.
//    case pasteImages(RichTextInsertion<[ImageRepresentable]>)
//
//    /// Paste plain text.
//    case pasteText(RichTextInsertion<String>)

    /// A print command.
    case print

    /// Redo the latest undone change.
    case redoLatestChange

    /// Select a range.
    case selectRange(NSRange)

    /// Set the text alignment.
    case setAlignment(_ alignment: RichTextAlignment)

    /// Set the entire attributed string.
    case setAttributedString(NSAttributedString)

    // Change background color
    case setColor(RichTextColor, ColorRepresentable)

    // Highlighted renge
    case setHighlightedRange(NSRange?)

    // Change highlighting style
    case setHighlightingStyle(RichTextHighlightingStyle)

    /// Set a certain ``RichTextStyle``.
    case setStyle(RichTextStyle, Bool)

    /// Step the font size.
    case stepFontSize(points: Int)

    /// Step the indent level.
    case stepIndent(points: CGFloat)

    /// Step the line spacing.
    case stepLineSpacing(points: CGFloat)

    /// Step the superscript level.
    case stepSuperscript(steps: Int)

    /// Toggle a certain style.
    case toggleStyle(_ style: RichTextStyle)

    /// Undo the latest change.
    case undoLatestChange

    /// Set HeaderStyle.
    case setHeaderStyle(_ style: RichTextSpanStyle)
}

public extension RichTextAction {

    typealias Publisher = PassthroughSubject<Self, Never>

    /// The action's unique identifier.
    var id: String { title }

    /// The action's standard icon.
    var icon: Image {
        switch self {
        case .copy: .richTextCopy
        case .dismissKeyboard: .richTextDismissKeyboard
//        case .pasteImage: .richTextDocuments
//        case .pasteImages: .richTextDocuments
//        case .pasteText: .richTextDocuments
        case .print: .richTextPrint
        case .redoLatestChange: .richTextRedo
        case .selectRange: .richTextSelection
        case .setAlignment(let val): val.icon
        case .setAttributedString: .richTextDocument
        case .setColor(let color, _): color.icon
        case .setHighlightedRange: .richTextAlignmentCenter
        case .setHighlightingStyle: .richTextAlignmentCenter
        case .setStyle(let style, _): style.icon
        case .stepFontSize(let val): .richTextStepFontSize(val)
        case .stepIndent(let val): .richTextStepIndent(val)
        case .stepLineSpacing(let val): .richTextStepLineSpacing(val)
        case .stepSuperscript(let val): .richTextStepSuperscript(val)
        case .toggleStyle(let val): val.icon
        case .undoLatestChange: .richTextUndo
        case .setHeaderStyle: .richTextIgnoreIt
        }
    }

    /// The localized label to use for the action.
    var label: some View {
        icon.label(title)
    }

    /// The localized title to use in the main menu.
    var menuTitle: String {
        menuTitleKey.text
    }

    /// The localized title key to use in the main menu.
    var menuTitleKey: RTEL10n {
        switch self {
        case .stepIndent(let points): .menuIndent(points)
        default: titleKey
        }
    }

    /// The localized action title.
    var title: String {
        titleKey.text
    }

    /// The localized action title key.
    var titleKey: RTEL10n {
        switch self {
        case .copy: .actionCopy
        case .dismissKeyboard: .actionDismissKeyboard
//        case .pasteImage: .pasteImage
//        case .pasteImages: .pasteImages
//        case .pasteText: .pasteText
        case .print: .actionPrint
        case .redoLatestChange: .actionRedoLatestChange
        case .selectRange: .selectRange
        case .setAlignment(let alignment): alignment.titleKey
        case .setAttributedString: .setAttributedString
        case .setColor(let color, _): color.titleKey
        case .setHighlightedRange: .highlightedRange
        case .setHighlightingStyle: .highlightingStyle
        case .setStyle(let style, _): style.titleKey
        case .stepFontSize(let points): .actionStepFontSize(points)
        case .stepIndent(let points): .actionStepIndent(points)
        case .stepLineSpacing(let points): .actionStepLineSpacing(points)
        case .stepSuperscript(let steps): .actionStepSuperscript(steps)
        case .toggleStyle(let style): style.titleKey
        case .undoLatestChange: .actionUndoLatestChange
        case .setHeaderStyle: .ignoreIt
        }
    }
}

// MARK: - Aliases

public extension RichTextAction {

    /// A name alias for `.redoLatestChange`.
    static var redo: RichTextAction { .redoLatestChange }

    /// A name alias for `.undoLatestChange`.
    static var undo: RichTextAction { .undoLatestChange }
}

public extension CGFloat {

    /// The default rich text indent step size.
    static var defaultRichTextIntentStepSize: CGFloat = 30.0
}

public extension UInt {

    /// The default rich text indent step size.
    static var defaultRichTextIntentStepSize: UInt = 30
}

