#import "MyAnnotation.h"

@implementation MyAnnotation
//-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
//                subTitle:(NSString *)paramSubitle
//{
//    self = [super init];
//    if(self != nil)
//    {
//        _coordinate = paramCoordinates;
//        _title = paramTitle;
//        _subtitle = paramSubitle;
//       // _pinColor = MKPinAnnotationColorGreen;
//    }
//    return self;
//}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t{
    self = [super init];
    if(self){
        _coordinate = c;
        _title = t;
    }
    return self;
}


@end