//
//  ContentView.swift
//  Chat
//
//  Created by eyh.mac on 24.12.2023.
//

import SwiftUI

struct Message: Identifiable {
    let id: Int
    let text: String
    let isCurrentUser: Bool
    var reaction: String?
}

struct ContentView: View {
    
    @State private var messages = [
        Message(id: 0, text: "Hello, which products are discounted today?", isCurrentUser: false, reaction: nil),
        Message(id: 1, text: "Hello! We have great discounts on fruits and vegetables.", isCurrentUser: true, reaction: nil),
        Message(id: 2, text: "Is there a discount on organic products?", isCurrentUser: false, reaction: nil),
        Message(id: 3, text: "Yes, we also have a 20% discount on our organic products.", isCurrentUser: true, reaction: nil),
        Message(id: 4, text: "Do you have a special promotion for the weekend?", isCurrentUser: false, reaction: nil),
        Message(id: 5, text: "Yes, we will have some surprise discounts for the weekend.", isCurrentUser: true, reaction: nil),
        Message(id: 6, text: "Great, then I'll stop by again this weekend.", isCurrentUser: false, reaction: nil),
        Message(id: 7, text: "We look forward to seeing you again. Have a good day!", isCurrentUser: true, reaction: nil),
        Message(id: 8, text: "Thank you, good work!", isCurrentUser: false, reaction: nil),
        Message(id: 9, text: "You are welcome, I wish you a good shopping.", isCurrentUser: true, reaction: nil),
        Message(id: 10, text: "What are the new products coming this week?", isCurrentUser: false, reaction: nil),
        Message(id: 11, text: "Our special imported cheeses and fresh seafood arrived this week.", isCurrentUser: true, reaction: nil),
        Message(id: 12, text: "Where can I find the cheeses?", isCurrentUser: false, reaction: nil),
        Message(id: 13, text: "Our cheeses are located in the dairy products section.", isCurrentUser: true, reaction: nil),
        Message(id: 14, text: "Thanks, I'll take a look there.", isCurrentUser: false, reaction: nil),
        Message(id: 15, text: "You're welcome, if you need anything else, I'll be happy to help.", isCurrentUser: true, reaction: nil),
        // ... and you can continue like this.
    
    ]
    
    @State private var showingReactions = false
    @State private var selectedMessageId: Int?
    @State private var draftMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        ForEach($messages) { $message in
                            MessageView(message: $message)
                                .onTapGesture {
                                    self.selectedMessageId = message.id
                                    self.showingReactions.toggle()
                                }
                        }
                        .padding()
                    }
                    .blur(radius: showingReactions ? 20 : 0)
                    
                    MessageInputView(draftMessage: $draftMessage)
                }
                
                if showingReactions, let selectedMessageId = selectedMessageId {
                    ReactionPicker(selectedMessageId: selectedMessageId, messages: $messages, showingReactions: $showingReactions)
                }
            }
          
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                        
                    }
                    VStack(alignment: .leading) {
                                           HStack {
                                               Image("profile")
                                                   .resizable()
                                                   .frame(width: 40, height: 40)
                                                   .clipShape(Circle())
                                               VStack(alignment: .leading) {
                                                   Text("EYHAN")
                                                       .font(.system(size: 18, weight: .medium))
                                                   Text("Online")
                                                       .font(.system(size: 14))
                                                       .foregroundColor(.blue)
                                               }
                                           }
                                       }
                                   },
                trailing: HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                    }) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.blue)
                    }
                  
                }
            )
        }
    }
}

struct MessageView: View {
    @Binding var message: Message

    var body: some View {
        VStack(alignment: message.isCurrentUser ? .trailing : .leading) {
            HStack {
                if !message.isCurrentUser { Spacer() }
                Text(message.text)
                    .padding()
                    .background(message.isCurrentUser ? Color.white.opacity(0.2) : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                if message.isCurrentUser { Spacer() }
            }
            if let reaction = message.reaction {
                HStack {
                    if !message.isCurrentUser { Spacer() }
                    Text(reaction)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        
                    if message.isCurrentUser { Spacer() }
                }
            }
        }
        .transition(.slide)
        .animation(.default, value: message.reaction)
    }
}

struct ReactionPicker: View {
    let selectedMessageId: Int
    @Binding var messages: [Message]
    @Binding var showingReactions: Bool

    let reactions = ["👍", "❤️", "😂", "😢", "🤔"]

    var body: some View {
        HStack(spacing: 25) {
            ForEach(reactions, id: \.self) { reaction in
                Text(reaction)
                    .font(.system(size: 30))
                    .onTapGesture {
                        if let index = messages.firstIndex(where: { $0.id == selectedMessageId }) {
                            messages[index].reaction = reaction
                            showingReactions = false
                        }
                    }
            }
        }
        
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.bottom, 50)
    }
}

struct MessageInputView: View {
    @Binding var draftMessage: String

    var body: some View {
        HStack {
            TextField("Start typing...", text: $draftMessage)

                .padding(10)
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .shadow(radius: 3)

            Button(action: {
                // Mesaj gönderme işlemini burada ele alın
            }) {
                Image(systemName: "paperplane.fill") // Uygun simgeyi kullanın
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
