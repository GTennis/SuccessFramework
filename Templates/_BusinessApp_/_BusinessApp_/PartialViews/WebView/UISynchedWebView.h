//
//  TableWebView.h
//  TableWebView
//
//  Created by Sergey Gavrilyuk on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Note: The class allows to stop main thread execution and wait for webView content loading result. WebView loads content async by default

#import <Foundation/Foundation.h>


@interface UISynchedWebView : UIWebView <UIWebViewDelegate>
{
	id anotherDelegate;
}

@end
