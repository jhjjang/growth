//
//  graphData.h
//  growth
//
//  Created by jungho jang on 12. 2. 1..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface graphData : NSObject
{
    sqlite3 *db;
}

-(NSMutableString *) getGraphData:(NSDictionary *)child :(NSString *)mode;

@end
