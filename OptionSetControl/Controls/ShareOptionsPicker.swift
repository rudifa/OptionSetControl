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

enum Color {
    static let skyBlue = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 220.0/255.0, alpha: 1.0)
}
extension UIButton {
    func select(_ sel: Bool) {
        tintColor = sel ? Color.skyBlue : .lightGray
    }
}

class ShareOptionsPicker: UIControl {


    private var buttons: [UIButton] = []
    let systemImageNames = ["envelope", "person.3", "video", "timer", "exclamationmark.triangle", "lock"]

    var options: ShareOptions = [] {
        didSet {
            updateButtons()
            printClassAndFunc(info: "options: \(options)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
    }

    func setupButtons(buttonsPerRow: Int) {
        var index = 0
        let rows = (systemImageNames.count - 1) / buttonsPerRow + 1
        var horStacks: [UIStackView] = []
        for row in 0 ..< rows {
            var rowButtons: [UIButton] = []
            for col in 0 ..< buttonsPerRow {
                let button = UIButton(type: .system)
                button.setImage(UIImage(systemName: systemImageNames[index]), for: .normal)
                button.addTarget(self, action: #selector(toggleOption(_:)), for: .touchUpInside)

                rowButtons.append(button)
                buttons.append(button)
                index += 1
                printClassAndFunc(info: "row= \(row)  col= \(col)  frame= \(button.frame) width= \(button.intrinsicContentSize.width)")
            }
            let horStack = UIStackView(arrangedSubviews: rowButtons)
            horStack.spacing = 12.0
            horStack.axis = .horizontal
            horStack.alignment = .center
            horStack.distribution = .fillEqually
            horStacks.append(horStack)
        }

        let widths = buttons.map({ $0.intrinsicContentSize.width })
        printClassAndFunc(info: "widths= \(widths)")
        let maxWidth = widths.reduce(0, { $1 > $0 ? $1 : $0 })
        printClassAndFunc(info: "maxWidth= \(maxWidth)")

        for button in buttons {
            let lr = (maxWidth - button.intrinsicContentSize.width) / 2.0
            button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: lr, bottom: 0.0, right: lr)
        }

        printClassAndFunc(info: "\(buttons.count)")
        let vertStackView = UIStackView(arrangedSubviews: horStacks)

        addSubview(vertStackView)
        vertStackView.spacing = 8.0
        vertStackView.axis = .vertical
        vertStackView.alignment = .center
        vertStackView.distribution = .fillEqually
        vertStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            vertStackView.topAnchor.constraint(equalTo: topAnchor),
            vertStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            vertStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vertStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        updateButtons()
        printClassAndFunc(info: "vertStackView.frame= \(vertStackView.frame)")
        printClassAndFunc(info: "vertStackView.intrinsicContentSize= \(vertStackView.intrinsicContentSize)")
    }

    func updateButtons() {
        buttons[0].select(options.contains(.email))
        buttons[1].select(options.contains(.addGroup))
        buttons[2].select(options.contains(.faceTime))
        buttons[3].select(options.contains(.booking))
        buttons[4].select(options.contains(.warning))
        buttons[5].select(options.contains(.lock))
    }

    @IBAction func toggleOption(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else {
            return
        }

        // Helpers
        let option: ShareOptions.Element

        switch index {
        case 0: option = .email
        case 1: option = .addGroup
        case 2: option = .faceTime
        case 3: option = .booking
        case 4: option = .warning
        default: option = .lock
        }

        options.toggle(option: option)

        updateButtons()

        sendActions(for: .valueChanged)
    }
}
