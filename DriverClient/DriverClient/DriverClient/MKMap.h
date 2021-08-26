//
//  MKMap.h
//  UserClient
//
//  Created by DSL on 2016/7/21.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import <MapKit/MapKit.h>
@class MKMap;
@protocol MKMapDelegate <NSObject>
-(CGRect)MKMapSetFrame:(MKMap *)MKMap;


@end


@interface MKMap : MKMapView<CLLocationManagerDelegate,MKMapViewDelegate,UISearchBarDelegate>
@property(nonatomic) id<MKMapDelegate>DataSource;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *myGeocoder;

-(void)setMKMapDataSource;


@end
