//
//  ListView.swift
//  CitySights App
//
//  Created by Anubhav Chaturvedi on 23/03/25.
//

import SwiftUI

struct ListView: View {
    
    @Environment(BusinessModel.self) var model
    
    var body: some View {
        List {
            ForEach (model.businesses) { b in
                
                VStack(spacing:20) {
                    HStack(spacing: 0) {
                        
                        if let imageUrl = b.imageUrl {
                            // Diplay the business image
                            AsyncImage(url: URL(string: imageUrl)!) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(6)
                                    .padding( .trailing, 16)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                        else {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.gray)
                                .padding( .trailing, 16)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(b.name ?? "Restaurant")
                                .font(Font.system(size: 15, weight: .bold))
                            
                            Text(TextHelper.distanceAwayText(meters: b.distance ?? 0))
                                .font(Font.system(size: 16))
                                .foregroundColor(Color(red: 67/255, green: 71/255, blue: 76/255,opacity: 1.0))
                            
                        }
                        Spacer()
                        
                        
                        
                        Image("regular_\(b.rating ?? 0)")
                        
                    }
                    Divider()
                    
                }
                .onTapGesture {
                    model.selectedBusiness = b
                }
            }
            .listRowSeparator(.hidden)
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
}

#Preview {
    ListView()
        .environment(BusinessModel())
}
