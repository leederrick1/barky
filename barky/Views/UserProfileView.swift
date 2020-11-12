//
//  UserProfileView.swift
//  barky
//
//  Created by Derrick Lee on 11/12/20.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    @ObservedObject var profile: User = user

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image("\(profile.userImage)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding()
                        .shadow(radius: 10)
                        .clipped()
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(profile.firstName), \(profile.lastName)")
                        Text("\(profile.city), \(profile.state)")
                        if profile.morning && profile.afterNoon && profile.night {
                            Text("Availability: All day")
                        }
                        else {
                            if profile.morning && profile.afterNoon {
                                Text("Availability: Morning and afternoon")
                            }
                            if profile.morning && profile.night {
                                Text("Availability: Morning and night")
                            }
                            if profile.afterNoon && profile.night {
                                Text("Availability: Afternoon and night")
                            }
                            else {
                                if profile.morning && !profile.afterNoon && !profile.night {
                                    Text("Availability: Morning")
                                }
                                if profile.afterNoon && !profile.morning && !profile.night {
                                    Text("Availability: Afternoon")
                                }
                                if profile.night && !profile.afterNoon && !profile.morning {
                                    Text("Availability: Night")
                                }
                            }
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 200, height: 100))
                    .shadow(radius: 1)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 350, height: 100)
                .padding([.top, .trailing])
                .navigationBarItems(trailing: HStack { AddButton(destination: EditView(profile: profile)) })
                .groupBoxStyle(/*@START_MENU_TOKEN@*/DefaultGroupBoxStyle()/*@END_MENU_TOKEN@*/)
                Spacer()
                ScrollView {
                    LazyVStack {
                        ForEach(profile.listOfDogs, id: \.id) { dog in
                            NavigationLink(destination: detailedViewSimple(dog:dog)) {
                                SmallDogCard(dog:dog)
                            }.padding(0)
                        }
                    }
                } // .border(Color.yellow)
                .padding(.top)
            }.padding(.trailing)
                .navigationBarTitle("Profile")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        // .border(Color.black)
    }
}

struct EditView: View {
    @ObservedObject var profile: User
    var body: some View {
        // removed Form{} wrapper around the stacks. it just made things look funnyS
        NavigationView {
            VStack(alignment: .leading, spacing: 5) {
                ScrollView {
                    Text("First Name")
                        .font(.callout)
                        .bold()
                    TextField("\(profile.firstName)", text: $profile.firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Last Name")
                        .font(.callout)
                        .bold()
                    TextField("\(user.lastName)", text: $profile.lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("City")
                        .font(.callout)
                        .bold()
                    TextField("\(profile.city)", text: $profile.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("State")
                        .font(.callout)
                        .bold()
                    TextField("\(profile.state)", text: $profile.state).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                VStack {
                    Group {
                        Toggle(isOn: $profile.morning) {
                            Text("Morning")
                        }
                        Toggle(isOn: $profile.afterNoon) {
                            Text("Afternoon")
                        }
                        Toggle(isOn: $profile.night) {
                            Text("Night")
                        }
                    }
                }
                Spacer()
                List {
                    ForEach(profile.listOfDogs, id: \.id) { dog in
                        NavigationLink(destination: EditDog(dog: dog)) {
                            Text(dog.name)
                        }
                    }

                    .onDelete(perform: delete)
                    .onTapGesture(perform: {
                        print("Pressed")
                        // NavigationLink(destination: EditDog(dog:user.listOfDogsp[$0])){}

                        // ForEach(profile.listOfDogs, id: \.id) { dog in
                        // NavigationLink(destination: EditDog(dog:dog)){}
                        // }
                    })
                }
                Spacer()
                    .navigationBarTitle(Text("Edit Profile"))
                    .navigationBarHidden(true)
            }
        }
    }

    func addRow() {
        // add row function needs to be able to append a dog object. default is
        let defaultDog = Dog(image: "dog", name: "Dog name", breed: "a good dog", gender: "F", temperament: "good", size: "6' ", weight: 12, description: "very good dog")
        profile.listOfDogs.append(defaultDog)
    }

    func delete(at offsets: IndexSet) {
        profile.listOfDogs.remove(atOffsets: offsets)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserProfileView()
        }
    }
}

// Work around to get a button to navigationBarItem and navigationLink to work together
// https://stackoverflow.com/questions/57024263/how-to-navigate-to-a-new-view-from-navigationbar-button-click-in-swiftui

struct AddButton<Destination: View>: View {
    var destination: Destination

    var body: some View {
        NavigationLink(destination: self.destination) { Image(systemName: "pencil") }
            .padding(.top)
    }
}

struct EditDog: View {
    @ObservedObject var dog: Dog
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                TextField("\(dog.name)", text: $dog.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("\(dog.breed)", text: $dog.breed)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("\(dog.gender)", text: $dog.gender)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("\(dog.temperament)", text: $dog.temperament)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("\(dog.size)", text: $dog.size)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    // TextField("\(dog.weight)", text: Int($dog.weight))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("\(dog.description)", text: $dog.description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.bottom)
        }.navigationTitle("Edit \(dog.name)")
    }
}
