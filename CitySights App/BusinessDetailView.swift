//
//  BusinessDetailView.swift
//  CitySights App
//
//  Created by Ansh chaturvedi on 11/03/25.
//

import SwiftUI

struct BusinessDetailView: View {
    
    @Environment(BusinessModel.self) var model
    
    
    var body: some View {
        
        let business = model.selectedBusiness
        
        
        VStack(spacing: 0){
            ZStack(alignment: .trailing){
                
                if let imageUrl = business?.imageUrl {
                    
                    AsyncImage(url: URL(string: imageUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 164)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                }
                else {
                    Image("detail-placeholder-image")
                        .resizable()
                        .ignoresSafeArea(edges: .all)
                }
                
                VStack{
                    Spacer()
                    Image("yelp-attribution-image")
                        .frame(width: 72, height: 36)
                }
            }
            .frame( height: 164)
            
            if let isClosed = business?.isClosed {
                
                ZStack(alignment: .leading){
                    Rectangle()
                        .foregroundStyle(isClosed ? .red : .green)
                    Text(isClosed ? "Closed" :"Open")
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding(.horizontal)
                    
                } .frame( height: 36)
            }
            
            ScrollView(){
                VStack(alignment: .leading, spacing: 0) {
                    Text(business?.name ?? "")
                        .font(Font.system(size: 21, weight: .bold))
                        .padding(.bottom, 10)
                        .padding(.top, 16)
                    
                    Text("\(business?.location?.address1 ?? ""), \(business?.location?.city ?? "")")
                    Text("\(business?.location?.state ?? ""), \(business?.location?.zipCode ?? ""), \(business?.location?.country ?? "")")
                        .padding(.bottom, 10)
                    
                    
                    Image("regular_\(business?.rating ?? 0)")
                        .padding(.bottom, 16)
                    
                    Divider()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "phone")
                        
                        
                        
                       
                        
                        if let url = URL(string: "tel\(business?.phone ?? "")") {
                            Link(destination: url) {
                                Text(business?.phone ?? "")
                            }
                        }
                        else {
                            Text(business?.phone ?? "")
                        }
                        
                        
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.vertical, 12)
                    
                    Divider()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "phone")
                        
                        if let url = URL(string: "\(business?.url ?? "")") {
                            Link(destination: url) {
                                Text(business?.url ?? "")
                                    .lineLimit(1)
                            }
                        }
                        else {
                            Text(business?.url ?? "")
                                .lineLimit(1)
                        }
       
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.vertical, 12)
                    
                    Divider()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("\(business?.reviewCount ?? 0) reviews")
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    
                    Spacer()
                    
                }
            }.padding(.horizontal)
            
        }
    }
}

#Preview {
    BusinessDetailView()
}
