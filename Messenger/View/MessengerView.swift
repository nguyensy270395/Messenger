//
//  Messenger.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 18/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessengerView: View {
    @State var text = ""
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.self) var env
    @StateObject var viewModel = MessengerViewModel()
    @State var pushImagePicker = false
    var body: some View {
        BaseView(isNav: false, title: "", navigationBarHidden: true) {
            VStack(spacing: 0) {
                Group {
                    HStack {
                        Button {
                            env.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 27, height: 27)
                                .padding(.trailing, 10)
                        }
                        Image("imageAccount")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                        VStack {
                            Text("Thanh Thanh")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                                .padding(.top, 8)
                            Spacer(minLength: 0)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "phone.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 28, height: 28)
                                .padding(.trailing, 12)
                        }
                        
                        Button {
                           
                        } label: {
                            Image(systemName: "video.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 35, height: 35)
                        }
                        
                        
                    }
                    .frame(height: 65)
                    .padding(.horizontal)
                    
                }
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        VStack(alignment: .leading) {
                            ForEach(viewModel.message, id: \.id) { contentMessage in
                                if contentMessage.to == 1 {
                                    MessageReceivedView(message: contentMessage)
                                        .environmentObject(viewModel)
                                } else {
                                    MessageSendView(message: contentMessage)
                                        .environmentObject(viewModel)
                                }
//                                if contentMessage.image != "" {
                                    AnimatedImage(url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/messengerapp-88ebe.appspot.com/o/images%2F0376F221-46B3-454C-A969-64215DA0F430.jpg?alt=media&token=9bb6740c-c982-4f34-a383-d6bca8f548be"))
//                                    
//                                }
                                
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        
                    }
                    .onChange(of: viewModel.lastMessageId) { id in
           
                            proxy.scrollTo(id, anchor: .bottom)
                        
                    }
                }
                Group {
                    HStack(spacing: 16){
                        
                        
                        Button {
                            pushImagePicker.toggle()
                        } label: {
                            Image(systemName: "photo")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 32, height: 32)
                        }
                        .sheet(isPresented: $pushImagePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
                        }

                        if viewModel.image != UIImage() {
                            ZStack(alignment: .topTrailing){
                                Image(uiImage: viewModel.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 100)
                                    .clipped()
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .onTapGesture {
                                        viewModel.image = UIImage()
                                    }
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                            Button {
                                viewModel.sendImage()
                                
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("Color1"))
                                    .frame(width: 32, height: 32)
                                    .rotationEffect(.degrees(45))
                            }
                        } else {
                            ZStack (alignment: .leading) {
                                
                                Text(text.isEmpty ? "Aa": "")
                                    .font(.system(size: 20))
                                    .foregroundColor(colorScheme == .dark ? .white : .gray)
                                    .padding(.horizontal, 10)
                                TextField("", text: $text, onCommit: {
                                    viewModel.sendMessage(text: text, toUserId: 2)
                                    text = ""
                                })
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .dark ? .white.opacity(0.6) : .gray.opacity(0.1))
                                .clipShape(Capsule())
                            }
                            .frame(maxWidth: .infinity)
                            if !text.isEmpty {
                                Button {
                                    viewModel.sendMessage(text: text, toUserId: 2)
                                    text = ""
                                    
                                } label: {
                                    Image(systemName: "paperplane.fill")
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color("Color1"))
                                        .frame(width: 32, height: 32)
                                        .rotationEffect(.degrees(45))
                                }
                            }
                        }
                        
                         
                           
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
        }
        
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}

struct MessageReceivedView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: MessengerViewModel
    var message: ContentMessage
    @State private var showTimeStamp = false
    var body: some View {
        HStack {
            HStack {
//                if message.image != "" {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(message.text)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(colorScheme == .dark ? .white.opacity(0.82) : .gray.opacity(0.1))
                            .cornerRadius(15)
                            .onTapGesture {
                                showTimeStamp.toggle()
                            }
                        if showTimeStamp {
                            
                            Text( message.timeStamp.timeIn24HourFormat())
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                        }
                    }
//                } else {
//                    Image(uiImage: viewModel.getImage(imageID: message.image))
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 300)
//                }
               
                Spacer(minLength: 0)
            }
            .frame(maxWidth: 320)
            Spacer()
        }
        .padding(.horizontal)
        
    }
}
struct MessageSendView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: MessengerViewModel
    var message: ContentMessage
    @State private var showTimeStamp = false
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Spacer(minLength: 0)
                
                    VStack(alignment: .leading, spacing: 2) {
                    Text(message.text)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background( Color("Color1"))
                        .cornerRadius(15)
                        .onTapGesture {
                            showTimeStamp.toggle()
                        }
                    if showTimeStamp {
                        
                        Text( message.timeStamp.timeIn24HourFormat())
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                }
                
                
            }
            .frame(maxWidth: 320)
            
        }
        .padding(.horizontal)
        
    }
}
struct ContentMessage: Identifiable, Hashable {
    var id: Int
    var image: String
    var text: String
    var timeStamp: Date
    var from: Int
    var to: Int
}


struct Account: Identifiable {
    var id: Int
    var name: String
    var image: UIImage
    var password: String
    var username: String
}
