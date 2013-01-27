BKOCDAlignPlugin
================
This is a... bad idea, inspired by [Color Sense for Xcode](https://github.com/omz/ColorSense-for-Xcode) and [KSImageNamed](http://ksuther.com/2013/01/22/ksimagenamed-xcode-autocomplete-for-imagenamed/).   Both are great, helpful plugins for Xcode.

I had no idea plugins could be made for Xcode, and I have a bit of an obssession with text alignment.   Slightly un-aligned code make me twitch.  It's ok, I don't worry about it much, but I will subconciously insert spaces to Zen things up a bit while I'm having (hopefully) more productive concious thoughts.   So what does this plugin do?  It transforms these lines:

    self.rightLabel.textAlignment = UITextAlignmentRight;
    self.rightLabel.textColor = [UIColor blackColor]
    self.rightLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.rightLabel.shadowColor = [UIColor blackColor];
    self.rightLabel.shadowOffset = CGSizeMake(0, 1);

Into this:

    self.rightLabel.textAlignment = UITextAlignmentRight;
    self.rightLabel.textColor     = [UIColor blackColor];
    self.rightLabel.font          = [UIFont fontWithName:@"Helvetica" size:15];
    self.rightLabel.shadowColor   = [UIColor blackColor];
    self.rightLabel.shadowOffset  = CGSizeMake(0, 1);


In other words, it will align the first equal sign in all of the lines that are selected when the menu item is selected, or Command-= is pressed.

Installation
============
To install, build the project and restart Xcode.   To uninstall, remove the plugin from `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins`.
