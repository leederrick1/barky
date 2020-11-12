//
//  HomeView.swift
//  barky
//
//  Created by Derrick Lee on 11/12/20.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var profile: User = user
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(userArr, id:\.id) { prf in
                    ForEach(prf.listOfDogs, id: \.id) { dog in
                        NavigationLink(destination: detailedView(dog: dog,profile: prf)) {
                            LargeDogCard(dog: dog)
                        }.padding(0)
                    }
                    }
                }
            }
            .navigationBarTitle("Home")
        }
    }
}
