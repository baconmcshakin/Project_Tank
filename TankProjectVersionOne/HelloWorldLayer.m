//
//  HelloWorldLayer.m
//  TankProjectVersionOne
//
//  Created by Ethan Horing on 5/27/14.
//  Copyright __MyCompanyName__ 2014. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation

@interface HelloWorldLayer()

@property (strong) CCTMXTiledMap *tankMap;
@property (strong) CCTMXLayer *background;
@property (strong) CCTMXLayer *foreground;
@property (strong) CCTMXLayer *meta;
@property (strong) CCSprite *player;
@property (strong) CCTMXLayer *objects;




@end

//

@implementation HelloWorldLayer


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        isTouchEnabled_ = YES;
        
        self.tankMap = [CCTMXTiledMap tiledMapWithTMXFile:@"TankMap.tmx"];
        self.background = [_tankMap layerNamed:@"Background"];
        self.foreground = [_tankMap layerNamed:@"Foreground"];
        self.meta = [_tankMap layerNamed:@"Meta"];
        self.meta.visible = NO;
        
        
        CCTMXObjectGroup *objects = [_tankMap objectGroupNamed:@"Objects"];
        NSMutableDictionary *SpawnPoint = [objects objectNamed:@"playerSpawnPoint"];
        
        int x = [[SpawnPoint valueForKey:@"x"]intValue];
        int y = [[SpawnPoint valueForKey:@"y"]intValue];
        
        _player = [CCSprite spriteWithFile:@"tankPlayer.png"];
        _player.position = ccp(x,y);
        [self addChild:_player];

        
        [self setViewPointCenter:_player.position];
        [self addChild:_tankMap z:-1];
        

	}
	return self;
}

- (void)setViewPointCenter:(CGPoint) position {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
        
    int x = MAX(position.x, winSize.width/2);
    int y = MAX(position.y, winSize.height/2);
    x = MIN(x, (_tankMap.mapSize.width * _tankMap.tileSize.width) - winSize.width / 2);
    y = MIN(y, (_tankMap.mapSize.height * _tankMap.tileSize.height) - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
}


//

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}


-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:touch.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    CGPoint playerPos = _player.position;
    CGPoint diff = ccpSub(touchLocation, playerPos);
    
    if ( abs(diff.x) > abs(diff.y) ) {
        if (diff.x > 0) {
            playerPos.x += _tankMap.tileSize.width;
        } else {
            playerPos.x -= _tankMap.tileSize.width;
        }
    } else {
        if (diff.y > 0) {
            playerPos.y += _tankMap.tileSize.height;
        } else {
            playerPos.y -= _tankMap.tileSize.height;
        }
    }
    
    CCLOG(@"playerPos %@",CGPointCreateDictionaryRepresentation(playerPos));
    
}

-(CGPoint)tileCoordForPosition:(CGPoint)position{
    //gets the tile coords
    int x = position.x/_tankMap.tileSize.width;
    int y = ((_tankMap.mapSize.height * _tankMap.tileSize.height)-position.y)/_tankMap.tileSize.height;
    
    return ccp(x, y);
}

@end
