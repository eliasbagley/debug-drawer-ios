//
//  RowControl.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

enum ControlType : String {
    case Switch = "SwitchCell"
    case Slider = "SliderCell"
    case Button = "ButtonCell"
    case DropDown = "DropDownCell"
    case Label = "LabelCell"
    case TextInput = "TextFieldCell"
}

class RowControl: NSObject {
    
    var name : String
    var type : ControlType
    init (name : String, type : ControlType) {
        self.name = name
        self.type = type
        super.init()
    }
}

class SwitchControl : RowControl {
    
    var block : Bool -> ()
    var value : Bool
    
    init (intialValue: Bool, name : String, block: Bool -> ()) {
        self.block = block
        self.value = intialValue
        super.init(name: name, type: .Switch)
    }
    
    func executeBlock (switchOn : Bool) {
        self.block(switchOn)
    }
}

class SliderControl : RowControl {
    
    var block : Float -> ()
    var value : Float

    init (intialValue: Float, name : String, block: Float -> ()) {
        self.block = block
        self.value = intialValue
        super.init(name: name, type: .Slider)
    }
    
    func executeBlock (sliderValue : Float) {
        self.block(sliderValue)
    }

}

class ButtonControl : RowControl {
    
    var block : () -> ()
    
    init (name : String, block: () -> ()) {
        self.block = block
        super.init(name: name, type: .Button)
    }
    
    func executeBlock () {
        self.block()
    }

}

class LabelControl : RowControl {
    
    var label :String
    
    init (name : String, label: String) {
        self.label = label
        super.init(name: name, type: .Label)
    }
    
}

class TextInputControl : RowControl {
    
    var block : String -> ()
    var value = ""
    
    init (name : String, block: (String) -> ()) {
        self.block = block
        super.init(name: name, type: .TextInput)
    }
    
    init (name : String, type:ControlType,  block: (String) -> ()) {
        self.block = block
        super.init(name: name, type: type)
    }
    
    func executeBlock (input: String) {
        self.block(input)
    }

}

class DropDownControl : RowControl {
    
    var options : Dictionary<String,AnyObject>
    var block : AnyObject -> ()
    var value : String
    var optionStrings : Array<String>
    
    init (initialValue: NSString, name : String, options: Dictionary<String,AnyObject>, block : (option: AnyObject) -> ()) {
        self.value = initialValue
        self.options = options
        self.optionStrings = [String](options.keys)
        self.block = block
        super.init(name: name, type: .DropDown)
    }
    
    func executeBlock(input: String) {
        self.block(self.options[input]!)
    }
    
}

