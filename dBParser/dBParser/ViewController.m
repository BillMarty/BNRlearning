//
//  ViewController.m
//  dBParser
//
//  Created by Bill Marty on 12/11/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "ViewController.h"
#import "loggingMacros.h"
#import "DBMScannerData.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    LogMethod();
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)chooseFileButton:(NSButton *)sender {
    
    LogMethod();

    // Code snippet from: xcdoc://?url=developer.apple.com/library/mac/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/UsingtheOpenandSavePanels/UsingtheOpenandSavePanels.html#//apple_ref/doc/uid/TP40010672-CH4-SW1

    NSOpenPanel* panel = [NSOpenPanel openPanel];
    panel.title = @"Choose a scanner data file";
    panel.showsResizeIndicator = YES;
    panel.canChooseDirectories = NO;
    panel.canCreateDirectories = NO;
    panel.allowsMultipleSelection = NO;
    
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  userFile = [[panel URLs] objectAtIndex:0];
            
            //Load data from the userFile
            MyLog(@"userFile %@", userFile);
            [self.dataFilePathLabel setStringValue:userFile.lastPathComponent];
            self.scannerData = [DBMScannerData initWithContentsOfFile:userFile];
        }
        
    }];
}

@end
