//
//  JustPostedFlickerPhotosTVC.m
//  Shutterbug
//
//  Created by Zhuoran Li on 11/24/14.
//  Copyright (c) 2014 NYU. All rights reserved.
//

#import "JustPostedFlickerPhotosTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickerPhotosTVC ()

@end

@implementation JustPostedFlickerPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchPhotos];
}

- (IBAction) fetchPhotos{
    [self.refreshControl beginRefreshing]; 
    NSURL * url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQ = dispatch_queue_create("flicker fetch", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResult = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResult
                                                                            options:0
                                                                              error:NULL];
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.photos = photos;
        });
    });
   }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
