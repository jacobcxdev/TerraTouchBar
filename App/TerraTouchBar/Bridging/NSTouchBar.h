//
//  NSTouchBar.h
//  TerraTouchBar
//
//  Created by Jacob Clayden on 15/12/2019.
//  Copyright © 2019 JacobCXDev. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSTouchBar (PrivateMethods)

// MARK: - Instance Methods

/// Presents a given @c NSTouchBar instance.
/// @param touchBar The @c NSTouchBar instance to present.
/// @param placement The placement of the @c NSTouchBar instance.
/// @param identifier The relevant @c NSTouchBarItemIdentifier.
+ (void)presentSystemModalTouchBar:(NSTouchBar *)touchBar placement:(long long)placement systemTrayItemIdentifier:(NSTouchBarItemIdentifier)identifier;

/// Presents a given @c NSTouchBar instance.
/// @param touchBar The @c NSTouchBar instance to present.
/// @param identifier The relevant @c NSTouchBarItemIdentifier.
+ (void)presentSystemModalTouchBar:(NSTouchBar *)touchBar systemTrayItemIdentifier:(NSTouchBarItemIdentifier)identifier;

/// Dismisses a given @c NSTouchBar instance.
/// @param touchBar The @c NSTouchBar instance to dismiss.
+ (void)dismissSystemModalTouchBar:(NSTouchBar *)touchBar;

/// Minimises a given @c NSTouchBar instance.
/// @param touchBar The @c NSTouchBar instance to minimise.
+ (void)minimizeSystemModalTouchBar:(NSTouchBar *)touchBar;

@end
