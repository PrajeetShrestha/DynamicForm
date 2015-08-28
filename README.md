# DynamicForm

## Usage:
* Import PJDynamicForm folder from the project.
* Import PJDynamicForm.h in your class. ```#import PJDynamicForm.h````
* You need IQKeyboardManager for this to work with TextFields, so install through pod ```pod 'IQKeyboardManager'```
* If you need basic customization you can do that through PJConfig.h which is in folder PJDynamicForm/Globals

```
- (IBAction)push:(id)sender {

    NSMutableArray *cellDefinitions = [NSMutableArray new];

    PJTextField *textField = [PJTextField new];
    textField.titleText       = @"Email Address";
    textField.isRequired      = YES;
    textField.key             = @"email";
    textField.inputType       = PJEmail;
    textField.placeholderText = @"Type your email...";
    [cellDefinitions addObject:textField];

    PJTextField *addressField = [PJTextField new];
    addressField.titleText       = @"Address";
    addressField.key             = @"address";
    addressField.isRequired      = NO;
    addressField.inputType       = PJString;
    addressField.placeholderText = @"Type your address...";
    [cellDefinitions addObject:addressField];

    PJBoolField *boolField = [PJBoolField new];
    boolField.key          = @"subscription";
    boolField.titleText    = @"Subscribe to our newsletter";
    boolField.defaultValue = @YES;
    boolField.valueWhenOff = @"NO";
    boolField.valueWhenOn  = @"YES";
    [cellDefinitions addObject:boolField];

    PJDescription *descriptionField  = [PJDescription new];
    descriptionField.key             = @"about";
    descriptionField.titleText       = @"About you!";
    descriptionField.placeholderText = @"Type your description here...";
    descriptionField.isRequired      = YES;
    descriptionField.defaultValue    = @"HEY";
    [cellDefinitions addObject:descriptionField];

    PJDatePicker *datePicker   = [PJDatePicker new];
    datePicker.key             = @"dob";
    datePicker.titleText       = @"Date of Birth";
    datePicker.isRequired      = YES;
    datePicker.placeholderText = @"Select your date of birth...";
    datePicker.datePickerMode  = UIDatePickerModeDate;
    [cellDefinitions addObject:datePicker];


    PJSubmitCell *submit = [PJSubmitCell new];
    [cellDefinitions addObject:submit];

    FieldsViewController *vc = [FieldsViewController new];
    vc.titleString = @"Registration";
    vc.cellDefinition = cellDefinitions;
    [self showViewController:vc sender:nil];
}
```

