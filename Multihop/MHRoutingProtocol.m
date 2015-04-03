//
//  MHRoutingProtocol.m
//  Multihop
//
//  Created by quarta on 03/04/15.
//  Copyright (c) 2015 quarta. All rights reserved.
//

#import "MHRoutingProtocol.h"



@interface MHRoutingProtocol ()

@property (nonatomic, strong) NSMutableArray *neighbourPeers;
@end

@implementation MHRoutingProtocol

#pragma mark - Initialization
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.neighbourPeers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    self.neighbourPeers = nil;
}


- (void)discover
{
    
}

- (void)disconnect
{
    [self.neighbourPeers removeAllObjects];
}

- (void)sendPacket:(MHPacket *)packet
             error:(NSError **)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate mhProtocol:self sendPacket:packet toPeers:packet.destinations error:error];
    });
}




#pragma mark - ConnectionsHandler methods
- (void)hasConnected:(NSString *)info
                peer:(NSString *)peer
{
    [self.neighbourPeers addObject:peer];
}

- (void)hasDisconnected:(NSString *)info
                   peer:(NSString *)peer
{
    [self.neighbourPeers removeObject:peer];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate mhProtocol:self hasDisconnected:info peer:peer];
    });
}


- (void)didReceivePacket:(MHPacket *)packet
                fromPeer:(NSString *)peer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate mhProtocol:self didReceivePacket:packet];
    });
}

- (void)enteredStandby:(NSString *)info
                  peer:(NSString *)peer
{
    
}

- (void)leavedStandby:(NSString *)info
                 peer:(NSString *)peer
{
    
}



@end