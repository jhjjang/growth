//
//  graphData.m
//  growth
//
//  Created by jungho jang on 12. 2. 1..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "graphData.h"

@implementation graphData



-(NSMutableString *) getGraphData:(NSDictionary *)child :(NSString *)mode
{
    //NSLog(@"info : %@",[child objectForKey:@"sex"]);
    //NSLog(@"mode : %@",mode);

    NSString *path = [[NSBundle mainBundle] pathForResource:@"childgrow" ofType:@"sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableString *height_data = [[NSMutableString alloc] init];
    NSMutableString *max_height_data = [[NSMutableString alloc] init];
    NSMutableString *min_height_data = [[NSMutableString alloc] init];

    NSMutableString *weight_data = [[NSMutableString alloc] init];
    NSMutableString *max_weight_data = [[NSMutableString alloc] init];
    NSMutableString *min_weight_data = [[NSMutableString alloc] init];

    if ([fileManager fileExistsAtPath:path]) {
        const char *pathCString = [path UTF8String];
        
        if (sqlite3_open(pathCString, &db)==SQLITE_OK) {
            const char *query = "SELECT * FROM growth";
            sqlite3_stmt *st;
            if (sqlite3_prepare_v2(db, query, -1, &st, nil)==SQLITE_OK) {
                int j=0;
                while (sqlite3_step(st)==SQLITE_ROW) {
                    NSString *month = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 0)];
                    /*
                    NSString *min_height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 1)];
                    NSString *height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 2)];
                    NSString *max_height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 3)]; 
                    */
                    NSString *min_height = nil;
                    NSString *height = nil;
                    NSString *max_height = nil;
                    
                    NSString *min_weight = nil;
                    NSString *weight = nil;
                    NSString *max_weight = nil;
                   
                    if ([child objectForKey:@"sex"]==@"male") {
                        min_height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 1)];
                        height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 2)];
                        max_height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 3)];
                        
                        min_weight = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 7)];
                        weight = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 8)];
                        max_weight = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 9)];
                    }else {
                        min_height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 4)];
                        height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 5)];
                        max_height = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 6)];
                        
                        min_weight = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 10)];
                        weight = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 11)];
                        max_weight = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(st, 12)];
                    }
                    
                    //NSLog(@"%@, %@",month,height);
                    
                    //NSLog(@"%d",j);
                    
                    [min_height_data appendFormat:@"[%@,%@]",month,min_height];
                    [height_data appendFormat:@"[%@,%@]",month,height];
                    [max_height_data appendFormat:@"[%@,%@]",month,max_height];
                    
                    [min_weight_data appendFormat:@"[%@,%@]",month,min_weight];
                    [weight_data appendFormat:@"[%@,%@]",month,weight];
                    [max_weight_data appendFormat:@"[%@,%@]",month,max_weight];
                    
                    if(j!=36) {
                        [height_data appendFormat:@","];
                        [min_height_data appendFormat:@","];
                        [max_height_data appendFormat:@","];
                        
                        [weight_data appendFormat:@","];
                        [min_weight_data appendFormat:@","];
                        [max_weight_data appendFormat:@","];
                    }
                    
                    j++;
                }
            }else {
                NSLog(@"Database found at %@ but couldnt't be opened",path);
                sqlite3_close(db);
            }
        }else {
            NSLog(@"DB not found");
        }
        
    }else {
        NSLog(@"error");
    }
    

    
    
    NSMutableString *pageStr = [@"<!DOCTYPE HTML>\n " mutableCopy];
    [pageStr appendString:@"<script type='text/javascript' src='jquery-js.html'></script>"];
    [pageStr appendString:@"<script type='text/javascript' src='highcharts-js.html'></script>"];
    [pageStr appendString:@"<script type='text/javascript' src='exporting-js.html'></script>"];
    [pageStr appendString:@"<script type='text/javascript' src='grid.js.html'></script>"];
    
    [pageStr appendString:@"<script type='text/javascript'>"];
    
    [pageStr appendString:@"var chart;"];
    [pageStr appendString:@"$(document).ready(function() {"];
    
    [pageStr appendString:@"chart = new Highcharts.Chart({"];
    [pageStr appendString:@"chart: {"];
    [pageStr appendString:@"renderTo: 'container'"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"xAxis: {"];
    [pageStr appendString:@"min: 0,"];
    [pageStr appendString:@"max: 36,"];
    [pageStr appendString:@"title: {"];
    [pageStr appendString:@"    text : '개월수'"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"yAxis: {"];


    if(mode==@"height"){
        [pageStr appendString:@"min: 40,"];
    }else {
        [pageStr appendFormat:@"min: 2,"];
    }
    


    [pageStr appendString:@"title: {"];
    [pageStr appendString:@"    text : ''"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"},tooltip: {"];
    [pageStr appendString:@"formatter: function() {"];
    [pageStr appendString:@"    return '<b>'+ this.series.name +'</b><br/>'+ this.x +': '+ this.y ;"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"title: {"];
    
    if(mode==@"height"){
        [pageStr appendString:@"text: '키(Cm)'"];
    }else {
        [pageStr appendFormat:@"text: '몸무게(Kg)'"];
    }
    [pageStr appendString:@"},"];
    [pageStr appendString:@"series: [{"];
    [pageStr appendString:@"type: 'line',"];
    [pageStr appendString:@"name: '95P',"];
    
    if(mode==@"height"){
        [pageStr appendFormat:@"data: [%@],",max_height_data];
    }else {
        [pageStr appendFormat:@"data: [%@],",max_weight_data];
    }
    
    
    
    [pageStr appendString:@"marker: {"];
    [pageStr appendString:@"enabled: false"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"states: {"];
    [pageStr appendString:@"hover: {"];
    [pageStr appendString:@"lineWidth: 0"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"enableMouseTracking: false"];
    [pageStr appendString:@"}"];
    
    
    
    [pageStr appendString:@",{"];
    [pageStr appendString:@"type: 'line',"];
    [pageStr appendString:@"name: '50P',"];
    

    if(mode==@"height"){
        [pageStr appendFormat:@"data: [%@],",height_data];
    }else {
        [pageStr appendFormat:@"data: [%@],",weight_data];
    }

    
    [pageStr appendString:@"marker: {"];
    [pageStr appendString:@"enabled: false"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"states: {"];
    [pageStr appendString:@"hover: {"];
    [pageStr appendString:@"lineWidth: 0"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"enableMouseTracking: false"];
    [pageStr appendString:@"}"];
    
    
    
    [pageStr appendString:@",{"];
    [pageStr appendString:@"type: 'line',"];
    [pageStr appendString:@"name: '3P',"];
    
    if(mode==@"height"){
        [pageStr appendFormat:@"data: [%@],",min_height_data];
    }else {
        [pageStr appendFormat:@"data: [%@],",min_weight_data];
    }
    
    [pageStr appendString:@"marker: {"];
    [pageStr appendString:@"enabled: false"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"states: {"];
    [pageStr appendString:@"hover: {"];
    [pageStr appendString:@"lineWidth: 0"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"},"];
    [pageStr appendString:@"enableMouseTracking: false"];
    [pageStr appendString:@"}"];
    
    
    [pageStr appendString:@",{"];
    [pageStr appendString:@"type: 'scatter',"];
    [pageStr appendString:@"name: '내아이',"];

    if(mode==@"height"){
        NSString *tmp = [[NSString alloc] initWithFormat:@"data: [[%@,%@]],",[child objectForKey:@"month"],[child objectForKey:@"height"]];
        [pageStr appendString:tmp];
    }else {
        NSString *tmp = [[NSString alloc] initWithFormat:@"data: [[%@,%@]],",[child objectForKey:@"month"],[child objectForKey:@"weight"]];
        [pageStr appendString:tmp];
    }
    
    [pageStr appendString:@"marker: {"];
    [pageStr appendString:@"radius: 4"];
    [pageStr appendString:@"}"];
    [pageStr appendString:@"}]"];
    [pageStr appendString:@"});"];
    
    [pageStr appendString:@"});"];
    [pageStr appendString:@"</script>"];
    
    [pageStr appendString:@"<body><div id='container' style='width: 100%; height: 300px; margin: 0 auto'></div></body>"];
    
    return pageStr;

}
@end
