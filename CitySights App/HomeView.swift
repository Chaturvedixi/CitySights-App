//
//  ContentView.swift
//  CitySights App
//
//  Created by Ansh chaturvedi on 10/03/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(BusinessModel.self) var model
    @State var selectedTab = 0
    
    @State var query: String = ""
    @FocusState var queryBoxFocused: Bool
    
    @State var showOptions = true
    @State var popularOn = false
    @State var dealsOn = false
    @State var categorySelection = "restaurants"
    
 
    
    var body: some View {
        
        @Bindable var model = model
        
        VStack {
            HStack {
                TextField("What're you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($queryBoxFocused)
                    .onTapGesture {
                        withAnimation {
                            showOptions = true
                        }
                    }
                    
                Button {
                    withAnimation {
                        showOptions = false
                        queryBoxFocused = false
                    }

                    // Perform a search
                    model.getBusinesses(query: query,
                                        options: getOptionsString(),
                                        category: categorySelection)
                } label: {
                    Text("GO")
                        .padding(.horizontal)
                        .frame(height: 34)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    
                }
            }
            .padding(.horizontal)
            
            //Query options. Show if textbox is focused
            if queryBoxFocused {
                VStack {
                    Toggle("Popular", isOn: $popularOn)
                    Toggle("Deals", isOn: $dealsOn)
                    
                    HStack{
                        Text("Category")
                        Spacer()
                        Picker("Category", selection: $categorySelection) {
                            Text("Restaurants")
                                .tag("restaurants")
                            Text("Arts")
                                .tag("arts")
                        }
                    }
                }
                .padding(.horizontal, 40)
                .transition(.scale)
            }
            
            // Show Picker
            Picker("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                
                Text("Map")
                    .tag(1)
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            
            // Show map or list
            if model.locationAuthStatus == .denied {
                Spacer()
                Text("Please enable location access in settings to search nearby businesses.")
                    .padding()
                Button("Open App Privacy Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            else if selectedTab == 1 {
                MapView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            queryBoxFocused = false
                        }
                    }
            } else {
                ListView()
                    .onTapGesture {
                        withAnimation {
                            showOptions = false
                            queryBoxFocused = false
                        }
                    }
            }
        }
        .sheet(item: $model.selectedBusiness) { item in
            BusinessDetailView()
        }
    }
    
    func getOptionsString() -> String {
        
        var optionsArray = [String]()
        
        if popularOn {
            optionsArray.append("hot_and_new")
        }
        
        if dealsOn {
            optionsArray.append("deals")
        }
        return optionsArray.joined(separator: ",")
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
