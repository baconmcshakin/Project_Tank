//
//  HelloWorldLayer.h
//  TileGame
//
//  Created by Jose Lemus on 8/2/13.
//  Copyright Jose Lemus 2013. All rights reserved.
//


#import <GameKit/GameKit.h>


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


//HelloWorldHud
@interface HudLayer : CCLayer
- (void)numCollectedChanged:(int)numCollected;
@end

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

// in HelloWorldLayer, outside the curly braces
// allows communication over whether the button for shooting projectiles is on or off
@property (assign) int mode;


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end