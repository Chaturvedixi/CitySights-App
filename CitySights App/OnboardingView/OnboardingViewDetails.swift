//
//  OnboardingViewDetails.swift
//  CitySights App
//
//  Created by Anubhav Chaturvedi on 24/03/25.
//

import SwiftUI

struct OnboardingViewDetails: View {
    
    var bgColor: Color
    var headline: String
    var subheadline: String
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            
            Color(bgColor)
            VStack {
                
                Spacer()
                Spacer()
                
                Image("onboarding")
                    .resizable()
                    .frame(width: 300, height: 300)
                
                Text(headline)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.top, 32)
                
                Text(subheadline)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.top, 4)
                
                Spacer()
                
                Button {
                    // Todo
                    buttonAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(height: 50)
                        
                        Text("Countinue")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 80)
                
            }
            .foregroundStyle(.white)
            
        }
    }
}

#Preview {
    OnboardingViewDetails(bgColor:Color( red: 111/255, green: 154/255, blue: 189/255), headline: "Welcome to City Sights", subheadline: "City Sight helps you find the best of the city") {
        // Nothing
    }
}
