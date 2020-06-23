//
//  ShareOptionsPicker.swift
//  OptionSetControl
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//
// based on SchedulePicker.swift by Bart Jacobs
//

import UIKit

// MARK: helpers

enum Color {
    static let skyBlue = UIColor(red: 53.0 / 255.0, green: 152.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
}

extension UIButton {
    func select(_ sel: Bool) {
        tintColor = sel ? Color.skyBlue : .lightGray
    }
}
/**
 ShareOptionsPicker presents a group of option buttons

 How to add an instance to a ViewController

    1. in .storyboard add a View, set its class to ShareOptionsPicker and add constraints

    2. in .storyboard -> ViewController attach a @IBOutlet weak var optionsPicker
 
    3. in .storyboard -> ViewController attach an @IBAction that will be called when the user clicks one of the control's buttons

    4. in ViewController.viewDidLoad call optionsPicker.setupButtons(buttonsPerRow: 2)

 The number of buttons and systemNames of their icons are defined by the enum ShareOption.
 Call to setupButtons adds buttons to the ShareOptionsPicker view.
 */

class ShareOptionsPicker: UIControl {
    private var buttons: [UIButton] = []

    /// Get icon image names
    let systemImageNames = EnumeratedOptions<ShareOption>.rawValues

    /// Initialize with all options selected
    var options = EnumeratedOptions(ShareOption.allCases) {
        didSet {
            updateButtons()
            printClassAndFunc(info: "options: \(options)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    /// Create buttons and add them to stacks
    func setupButtons(buttonsPerRow: Int) {
        var index = 0
        let rows = (systemImageNames.count - 1) / buttonsPerRow + 1
        var horStacks: [UIStackView] = []
        for _ in 0 ..< rows {
            var rowButtons: [UIButton] = []
            for _ in 0 ..< buttonsPerRow {
                let button = UIButton(type: .system)
                button.setImage(UIImage(systemName: systemImageNames[index]), for: .normal)
                button.addTarget(self, action: #selector(toggleOption(_:)), for: .touchUpInside)

                rowButtons.append(button)
                buttons.append(button)
                index += 1
            }
            let horStack = UIStackView(arrangedSubviews: rowButtons)
            horStack.spacing = 12.0
            horStack.axis = .horizontal
            horStack.alignment = .center
            horStack.distribution = .fillEqually
            horStacks.append(horStack)
        }

        // line up buttons vertically, adjusting for unequal icon widths
        let widths = buttons.map({ $0.intrinsicContentSize.width })
        let maxWidth = widths.reduce(0, { $1 > $0 ? $1 : $0 })
        for button in buttons {
            let lr = (maxWidth - button.intrinsicContentSize.width) / 2.0
            button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: lr, bottom: 0.0, right: lr)
        }

        let vertStackView = UIStackView(arrangedSubviews: horStacks)
        vertStackView.spacing = 8.0
        vertStackView.axis = .vertical
        vertStackView.alignment = .center
        vertStackView.distribution = .fillEqually
        vertStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vertStackView)

        NSLayoutConstraint.activate([
            vertStackView.topAnchor.constraint(equalTo: topAnchor),
            vertStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            vertStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vertStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        updateButtons()
    }

    func updateButtons() {
        for (index, button) in buttons.enumerated() {
            button.select(options.isSelected(atIndex: index))
        }
    }

    @IBAction func toggleOption(_ button: UIButton) {
        guard let index = buttons.firstIndex(of: button) else { return }
        options.toggle(atIndex: index)
        updateButtons()

        sendActions(for: .valueChanged)
    }
}
