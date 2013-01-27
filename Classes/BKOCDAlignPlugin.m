//
//  BKOCDAlignPlugin.h
//  BKOCDAlignPlugin
//
//  Created by Brian King on 1/26/13
//
//

#import "BKOCDAlignPlugin.h"
#import "JRSwizzle.h"

@implementation NSTextView (BKOCDAlign)

- (BOOL)bk_validateMenuItem:(NSMenuItem *)menuItem
{
    BOOL valid = [self bk_validateMenuItem:menuItem];
    
	if ([menuItem action] == @selector(bk_ocdAlign:)) {
        [menuItem setState:NSOnState];
        valid = YES;
	}
	return valid;
}

- (void)bk_ocdAlign:(id)sender
{
    NSCharacterSet *equalSet = [NSCharacterSet characterSetWithCharactersInString:@"="];
    NSUInteger maxEquals     = 0;
    NSString *selection      = [[[self textStorage] string] substringWithRange:[self selectedRange]];
    NSArray *lines           = [selection componentsSeparatedByString:@"\n"];
    
    for (NSString *line in lines)
    {
        NSUInteger equalLocation = [line rangeOfCharacterFromSet:equalSet].location;
        if (equalLocation != NSNotFound)
            maxEquals = MAX(maxEquals,equalLocation);
    }
    
    NSMutableString *replacement = [NSMutableString string];
    for (NSString *line in lines)
    {
        NSUInteger equalLocation = [line rangeOfCharacterFromSet:equalSet].location;
        if (equalLocation != NSNotFound)
        {
            NSMutableString *mutableLine = [line mutableCopy];
            
            for (NSUInteger i = equalLocation; i < maxEquals; i++)
                [mutableLine insertString:@" " atIndex:equalLocation];
            
            [replacement appendFormat:@"%@\n", mutableLine];
        }
        else
            [replacement appendFormat:@"%@\n", line];
    }
    
    [self insertText:replacement];
}

@end

@implementation BKOCDAlignPlugin

+ (void)load
{
    if (NSClassFromString(@"IDESourceCodeEditor") != NULL) {
        [NSClassFromString(@"IDESourceCodeEditor") jr_swizzleMethod:@selector(validateMenuItem:) withMethod:@selector(bk_validateMenuItem:) error:NULL];
    }
}

+ (void)pluginDidLoad:(NSBundle *)plugin
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[[self alloc] init];
	});
}

- (id)init
{
	self  = [super init];
	if (self) {
		//TODO: It would be better to add this to the Help menu, but that seems to be populated from somewhere else...
		NSMenuItem *editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
		if (editMenuItem) {
			[[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];
			NSMenuItem *toggleDashItem = [[[NSMenuItem alloc] initWithTitle:@"OCD Algin" action:@selector(bk_ocdAlign:) keyEquivalent:@"="] autorelease];
			[[editMenuItem submenu] addItem:toggleDashItem];
		}
	}
	return self;
}

@end
