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
    
    private let tokens = [
        "stevejobs" :  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic3RldmVqb2JzIn0.JNR2tyHkoCVkAlDFRBIJuYjDl3sOKIsTtwpjw8vK_Ak",
        "markz" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibWFya3oifQ.p4lPWAL3pWQ65MK0VLfBLBRZXDv1XWmmi80bPmkOQgs"
    ]
    
    func setUp(){
        let client = ChatClient(config: .init(apiKey: .init("bpv2bzgsztvy")))
        self.client = client
    }
    
    //Authentication
    
    func signIn(with username: String, completion: @escaping(Bool) -> Void) {
        guard !username.isEmpty else {
            completion(false)
            return
        }
        
        guard let token = tokens[username.lowercased()] else {
            completion(false)
            return
        }
        
        client.connectUser(userInfo: UserInfo(id: username, name: username),
                           token: Token(stringLiteral: token)) { error in
            completion(error == nil)
        }
    }
    
    // MARK: - Authentication
    func signOut() { // async eklendi await ile
         client.disconnect()
         client.logout()
    }
    
    var isSignedIn: Bool {
        return client.currentUserId != nil
    }
    
    var currentUser: String? {
        return client.currentUserId
    }
    
    //ChannelList + Creation
    
    public func createChannelList() -> UIViewController? {
        guard let id = currentUser else { return nil }
        let list = client.channelListController(query: .init(filter: .containMembers(userIds: [id])))
        
        let vc = ChatChannelListVC()
        vc.content = list
        
        list.synchronize()
        return vc
    }
    
    public func createNewChannel(name: String) {
        guard let current = currentUser else {
            return
        }
        let keys: [String] = tokens.keys.filter({ $0 != current }).map {$0}
        do{
            let result = try client.channelController(createChannelWithId: .init(type: .messaging, id: name),
                                                      name: name,
                                                      members: Set(keys),
                                                      isCurrentUserMember: true
            )
            result.synchronize()
        }
        catch{
            print("\(error)")
        }
    }
}
