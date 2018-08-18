#import "UIImage+animatedGIF.h"
#import "G2PreferencesManager.h"
#import <Photos/Photos.h>

static NSMutableArray *gifCGImages = nil;
static UIImage *gifImage = nil;
static bool foundImage = false;

%hook BKImageSequence

-(CGImageRef)imageAtIndex:(long long)arg1{
	if ([[G2PreferencesManager sharedInstance] isEnabled]){
		if (gifImage != nil && foundImage){
			return gifImage.images[arg1].CGImage;
		} else {
			return %orig;
		}
	} else{
		return %orig;
	}
}


-(id) initWithBasename:(id)arg1 bundle:(id)arg2 imageCount:(long long)arg3 scale:(double)arg4{
	if ([[G2PreferencesManager sharedInstance] isEnabled]){
		NSURL *refURL = [NSURL URLWithString:@"file:///var/mobile/Library/Preferences/Respring.gif"];
		gifImage = [UIImage animatedImageWithAnimatedGIFURL:refURL];
		if (gifCGImages == nil && gifImage != nil){
			arg3 = gifImage.images.count;
			foundImage = true;
			gifCGImages = [NSMutableArray array];
			for(UIImage *frame in gifImage.images){
				[gifCGImages addObject:(id)frame.CGImage];
			}
		}
	}
	return %orig;

}



%end

@interface CADisplay

-(CGRect) safeBounds;

@end

@interface BKDisplayRenderOverlaySpinny {
	CAKeyframeAnimation *_animation;
}

@property (readonly, nonatomic) CALayer *contentLayer;
@property (nonatomic, getter=_bounds, setter=_setBounds:) CGRect bounds;
@property (readonly, retain, nonatomic) CADisplay *display;

@end

%hook BKDisplayRenderOverlaySpinny 


-(void)_startAnimating{
	if (gifCGImages != nil && gifImage != nil && foundImage && [[G2PreferencesManager sharedInstance] isEnabled]){
		CAKeyframeAnimation *newAnimation = [CAKeyframeAnimation animation];
		[newAnimation setKeyPath:@"contents"];
		[newAnimation setValues:gifCGImages];
		[newAnimation setCalculationMode:@"discrete"];
		if ([[G2PreferencesManager sharedInstance] customLoop] < 0){
			[newAnimation setRepeatCount:HUGE_VALF];
		} else {
			[newAnimation setRepeatCount:[[G2PreferencesManager sharedInstance] customLoop]];
		}
		if ([[G2PreferencesManager sharedInstance] customDuration] < 0){
			[newAnimation setDuration:gifImage.duration];
		} else {
			[newAnimation setDuration:[[G2PreferencesManager sharedInstance] customDuration]];	
		}

		[self.contentLayer addAnimation:newAnimation forKey:nil];
	} else {
		%orig;
	}

}

-(CALayer *)_prepareContentLayerForPresentation:(id)arg1{
	if ([[G2PreferencesManager sharedInstance] isEnabled]){
		CALayer *result = %orig;
		result.contentsGravity = [[G2PreferencesManager sharedInstance] imageTransformation];
		[result setBounds:[self.display safeBounds]];
		result.backgroundColor = [[G2PreferencesManager sharedInstance] colorForPreference:@"backgroundColor" fallback:@"#000000"].CGColor;
		return result;
	} else {
		return %orig;
	}
}


%end