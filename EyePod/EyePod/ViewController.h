
// (c) 2012 Charles Fries. All rights reserved.
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *artistLabel;
    MPMusicPlayerController *musicPlayer;
}
- (IBAction)about;
- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;
@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;
@end
