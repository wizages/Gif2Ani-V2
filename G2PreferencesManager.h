#import <Cephei/HBPreferences.h>

@interface G2PreferencesManager : NSObject

@property (nonatomic, readonly) BOOL isEnabled;
@property (nonatomic, readonly) NSString *imageTransformation;
@property (nonatomic, readonly) CGFloat customLoop;
@property (nonatomic, readonly) CGFloat customDuration;


+ (instancetype)sharedInstance;
- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback ;
@end