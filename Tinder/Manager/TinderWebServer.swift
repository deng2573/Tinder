//
//  TinderWebServer.swift
//  Tinder
//
//  Created by Deng on 2019/8/2.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import GCDWebServer

let GCDWebServerOption_ConnectionClass = "TinderWebServerConnection"

class TinderWebServer: GCDWebUploader {
	
	private var connection: GCDWebServerConnection!
	
	override init(uploadDirectory path: String) {
		super.init(uploadDirectory: path)
	}
//	override func willStartConnection(connection: GCDWebServerConnection) {
//		
//	}

}


class TinderWebServerConnection: GCDWebServerConnection {
	//	private
//	init
	
	
	
}
