//
//  ViewController.h
//  dBParser
//
//  Created by Bill Marty on 12/11/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DBMScannerData.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *dataFilePathLabel;
@property DBMScannerData *scannerData;

@end

