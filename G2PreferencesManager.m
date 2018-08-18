#import "G2PreferencesManager.h"
#import <Cephei/HBPreferences.h>
#import <libcolorpicker.h>

static NSString *const kG2EnabledKey = @"isEnabled";
static NSString *const kG2ImageTransformKey = @"imageTransformation";
static NSString *const kG2LoopKey = @"customLoop";
static NSString *const kG2DurationKey = @"customDuration";

@implementation G2PreferencesManager {
	HBPreferences *_preferences;
}

+ (instancetype)sharedInstance {
	static G2PreferencesManager *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.wizages.gif2aniprefs"];

		[_preferences registerBool:&_isEnabled default:YES forKey:kG2EnabledKey];

		[_preferences registerObject:&_imageTransformation default:kCAGravityResizeAspect forKey:kG2ImageTransformKey];

		[_preferences registerFloat:&_customLoop default:-1.0 forKey:kG2LoopKey];
		[_preferences registerFloat:&_customDuration default:-1.0 forKey:kG2DurationKey];
	}

	return self;
}

- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback {

	NSString *potentialIndividualTint = _preferences[string];
	if (potentialIndividualTint) {
		return LCPParseColorString(potentialIndividualTint, @"#000000");
	}
	return LCPParseColorString(fallback, @"#000000");
}


@end