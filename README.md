#  OptionSetControl

ShareOptionsPicker is a custom control that presents a group of option buttons.

How to add an instance to a ViewController

   1. in .storyboard add a View, set its class to ShareOptionsPicker and add constraints

   2. in .storyboard -> ViewController attach a @IBOutlet weak var optionsPicker

   3. in .storyboard -> ViewController attach an @IBAction that will be called when the user clicks one of the control's buttons

   4. in ViewController.viewDidLoad call optionsPicker.setupButtons(buttonsPerRow: 2)

The number of buttons and systemNames of their icons are defined by an enum like ShareOption.
Call to setupButtons adds buttons to the ShareOptionsPicker view.


See also

[Protocol OptionSet](https://developer.apple.com/documentation/swift/optionset)

[How to Work With Bitmasks in Swift](https://cocoacasts.com/how-to-work-with-bitmasks-in-swift)

[How to Create a Custom Control Using a Bitmask](https://cocoacasts.com/how-to-create-a-custom-control-using-a-bitmask)

[HowToCreateACustomControlUsingABitmask](https://github.com/bartjacobs/HowToCreateACustomControlUsingABitmask)

[Option Set](https://nshipster.com/optionset/) shows an alternative approach.
