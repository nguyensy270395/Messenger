//
//  Messenger.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 18/05/2022.
//

import SwiftUI

struct MessengerView: View {
    @State var text = ""
    var body: some View {
        VStack(spacing: 0) {
            Group {
                HStack {
                    Image(systemName: "chevron.left")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Color1"))
                        .frame(width: 27, height: 27)
                        .padding(.trailing, 10)
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
                    
                    Image(systemName: "phone.fill")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Color1"))
                        .frame(width: 28, height: 28)
                        .padding(.trailing, 12)
                    Image(systemName: "video.fill")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Color1"))
                        .frame(width: 35, height: 35)
                        
                }
                .frame(height: 65)
                .padding(.horizontal)
                .background(.white)
            }
            
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading) {
                    MessageView(message: ContentMessage(id: UUID(), text: "A class is mutable, so when you change the rate inside the class, you still have the same instance.", timeStamp: Date(), from: UUID(), to: UUID()))
                    MessageView(message: ContentMessage(id: UUID(), text: "A class is mutable", timeStamp: Date(), from: UUID(), to: UUID()))
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                    
                
                
            }
            Group {
                HStack(spacing: 20){
                    Image(systemName: "camera.fill")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Color1"))
                        .frame(width: 35, height: 35)
                    Image(systemName: "photo")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("Color1"))
                        .frame(width: 35, height: 35)

                    ZStack (alignment: .leading) {
                        TextField("", text: $text)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.gray.opacity(0.1))
                            .clipShape(Capsule())
                        Text(text.isEmpty ? "Aa": "")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        
                            
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
        
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}

struct MessageView: View {
    var message: ContentMessage
    @State private var showTimeStamp = false
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(message.text)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.gray.opacity(0.1))
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
                Spacer(minLength: 0)
            }
            .frame(maxWidth: 320)
            Spacer()
        }
        .padding(.horizontal)
       
    }
}
struct ContentMessage: Identifiable {
    var id: UUID
    var text: String
    var timeStamp: Date
    var from: UUID
    var to: UUID
}


struct Account: Identifiable {
    var id: UUID
    var name: String
    var password: String
    var username: String
}
