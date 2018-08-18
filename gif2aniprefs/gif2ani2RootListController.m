#include "gif2ani2RootListController.h"
#include <CepheiPrefs/HBSupportController.h>
#include <AppSupport/CPDistributedMessagingCenter.h>
#import <Photos/Photos.h>

@implementation gif2ani2RootListController

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    return @"Make your resprings awesome or something like that... Or just say hi to Apple :)";
}

+(NSString *)hb_shareURL {
    return @"";
}

- (void)showSupportEmailController {
	UIViewController *viewController = (UIViewController *)[HBSupportController supportViewControllerForBundle:[NSBundle bundleForClass:self.class] preferencesIdentifier:@"com.dopeteam.tails"];
	[self.navigationController pushViewController:viewController animated:YES];
}

- (void)selectPhotos
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *refURL = [info objectForKey:UIImagePickerControllerReferenceURL];
	if (refURL){
		PHAsset *asset = [[PHAsset fetchAssetsWithALAssetURLs:@[refURL] options:nil] lastObject];
		if (asset){
			[[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info){
				if (imageData){
					//UIImage *gifforrespring = [UIImage animatedImageWithAnimatedGIFData:imageData];
					CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.wizages.WriteAnywhereServer"];
					NSMutableDictionary *sendImage = [[NSMutableDictionary alloc] init];
					sendImage[@"filelocation"] = @"/var/mobile/Library/Preferences/Respring.gif";
					sendImage[@"data"] = imageData;
					[messagingCenter sendMessageName:@"writeDataTo" userInfo:sendImage];
				}
			}];
		}
	}

	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
	

	
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray *)getTransformTypesTitle{
	return [[NSArray alloc] initWithObjects:kCAGravityResizeAspect, kCAGravityResizeAspectFill, kCAGravityResize, kCAGravityCenter, nil];
}

-(NSArray *)getTransformTypes{
	return [[NSArray alloc] initWithObjects:kCAGravityResizeAspect, kCAGravityResizeAspectFill, kCAGravityResize, kCAGravityCenter, nil];
}

-(void)respring{
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	system("killall -9 backboardd");
	#pragma clang diagnostic pop
}

@end
