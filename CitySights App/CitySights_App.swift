//
//  CitySights_AppApp.swift
//  CitySights App
//
//  Created by Ansh chaturvedi on 10/03/25.
//

import SwiftUI

@main
struct CitySights_App: App {
    
    @State var model = BusinessModel()
    @AppStorage("Onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // On dismiss
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environment(model)
                }
                .onAppear {
                    // If no onboarding is needed, still get location
                    if needsOnboarding == false && model.locationAuthStatus == .notDetermined {
                        model.getUserLcoation()
                    }
                }
        }
    }
}
