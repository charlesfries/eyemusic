
// (c) 2012 Charles Fries. All rights reserved.
#import "ViewController.h"
@interface ViewController ()
@end
@implementation ViewController
@synthesize musicPlayer;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Begin instructional alert
    if (![@"1" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"alert"]])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"alert"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"Welcome to EyeMusic! To get started, make sure your music library is set to whichever playlist you want to listen to. In addition, make sure the repeat mode is on, so your playlist will repeat when it is finished. Thank you for downloading EyeMusic!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    // End instructional alert
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [self registerMediaPlayerNotifications];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification object: musicPlayer];
	[musicPlayer endGeneratingPlaybackNotifications];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification object: musicPlayer];
	[musicPlayer endGeneratingPlaybackNotifications];
}
- (void)registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver: self selector: @selector (handle_NowPlayingItemChanged:) name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification object: musicPlayer];
    [musicPlayer beginGeneratingPlaybackNotifications];
}
- (void)handle_NowPlayingItemChanged:(id)notification
{
   	MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle]; // Set title
    NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist]; // Set artist
    if (titleString) {titleLabel.text = [NSString stringWithFormat:@"%@",titleString];}
    else {titleLabel.text = @"Unknown";}
    if (artistString) {artistLabel.text = [NSString stringWithFormat:@"By: %@",artistString];}
    else {artistLabel.text = @"By: Unknown";}
}
// Begin about alert
- (IBAction)about
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About" message:@"This application was designed and developed by Charles Fries. Visit his website at charliefries.tk or email him at contact@charliefries.tk." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Website", @"Email", nil];
    [alert show];
}
// End about alert
// Begin alert actions
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://charliefries.tk/"]];}
    else if (buttonIndex == 2)
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        NSArray *toRecipients = [NSArray arrayWithObjects:@"contact@charliefries.tk", nil];
        [picker setToRecipients:toRecipients];
        [self presentModalViewController:picker animated:YES];
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {[self dismissModalViewControllerAnimated:YES];}
// End alert actions
// Begin music navigation
- (IBAction)play:(id)sender {[musicPlayer play];}
- (IBAction)pause:(id)sender {[musicPlayer pause];}
- (IBAction)previous:(id)sender {[musicPlayer skipToPreviousItem];}
- (IBAction)next:(id)sender {[musicPlayer skipToNextItem];}
// End music navigation
@end
