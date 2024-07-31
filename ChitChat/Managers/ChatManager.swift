//
//  ChatManager.swift
//  ChitChat
//
//  Created by Saadet Şimşek on 31/07/2024.
//

import Foundation
import StreamChat
import StreamChatUI
import UIKit

final class ChatManager{
    static let shared = ChatManager()
    
    private var client: ChatClient!
    
    func setUp(){
        let client = ChatClient(config: .init(apiKey: .init("bpv2bzgsztvy")))
        self.client = client
    }
    
    //Authentication
    
    func signIn(with username: String, completion: @escaping(Bool) -> Void) {
        
    }
    
    func signOut(){
        
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    var currentUser: String? {
        return nil
    }
    
    //ChannelList + Creation
    
    public func createChannelList() -> UIViewController {
        return UIViewController()
    }
    
    public func createNewChannel(name: String) {
        
    }
}
