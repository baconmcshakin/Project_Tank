//
//  MyCocos2DClass.h
//  TileGame
//
//  Created by Jose Lemus on 8/8/13.
//  Copyright 2013 Jose Lemus. All rights reserved.
//

#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
}
@property (nonatomic, strong) CCLabelTTF *label;
@end

@interface GameOverScene : CCScene {
}
@property (nonatomic, strong) GameOverLayer *layer;
@end