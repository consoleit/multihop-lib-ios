//
//  MHUnicastRoutingProtocol.m
//  Multihop
//
//  Created by quarta on 03/04/15.
//  Copyright (c) 2015 quarta. All rights reserved.
//

#import "MHUnicastRoutingProtocol.h"



@interface MHUnicastRoutingProtocol () <MHConnectionsHandlerDelegate>

@property (nonatomic, strong) NSMutableArray *neighbourPeers;
@property (nonatomic, strong) MHConnectionsHandler *cHandler;
@end

@implementation MHUnicastRoutingProtocol

#pragma mark - Initialization
- (instancetype)initWithServiceType:(NSString *)serviceType
                        displayName:(NSString *)displayName
{
    self = [super init];
    if (self)
    {
        self.neighbourPeers = [[NSMutableArray alloc] init];
        self.cHandler = [[MHConnectionsHandler alloc] initWithServiceType:serviceType
                                                              displayName:displayName];
        
        self.cHandler.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.neighbourPeers = nil;
    self.cHandler = nil;
}

- (void)disconnect
{
    [self.neighbourPeers removeAllObjects];
    [self.cHandler disconnectFromNeighbourhood];
}

- (NSString *)getOwnPeer
{
    return [self.cHandler getOwnPeer];
}

- (void)applicationWillResignActive
{
    [self.cHandler applicationWillResignActive];
}

- (void)applicationDidBecomeActive
{
    [self.cHandler applicationDidBecomeActive];
}

#pragma mark - Overridable methods

- (void)sendPacket:(MHPacket *)packet
             error:(NSError **)error
{
    // Must be overridden
}

- (int)hopsCountFromPeer:(NSString*)peer
{
    // Must be overridden
    return 0;
}


#pragma mark - Connectionshandler delegate methods
- (void)cHandler:(MHConnectionsHandler *)cHandler
 failedToConnect:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate mhProtocol:self failedToConnect:error];
    });
}

- (void)cHandler:(MHConnectionsHandler *)cHandler
    hasConnected:(NSString *)info
            peer:(NSString *)peer
     displayName:(NSString *)displayName
{
    // Must be overridden
}

- (void)cHandler:(MHConnectionsHandler *)cHandler
 hasDisconnected:(NSString *)info
            peer:(NSString *)peer
{
    // Must be overridden
}


- (void)cHandler:(MHConnectionsHandler *)cHandler
  didReceiveData:(NSData *)data
        fromPeer:(NSString *)peer
{
    // Must be overridden
}

- (void)cHandler:(MHConnectionsHandler *)cHandler
  enteredStandby:(NSString *)info
            peer:(NSString *)peer
{
    // Must be overridden
}

- (void)cHandler:(MHConnectionsHandler *)cHandler
   leavedStandby:(NSString *)info
            peer:(NSString *)peer
{
    // Must be overridden
}
@end
