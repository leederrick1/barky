//
//  Dog.swift
//  barky
//
//  Created by Derrick Lee on 11/12/20.
//

import Foundation
class Dog : Identifiable, ObservableObject{
    @Published var id = UUID()
    @Published var image: String
    @Published var name: String
    @Published var breed: String
    @Published var gender: String
    @Published var temperament: String
    @Published var size: String
    @Published var weight: Int
    @Published var description: String
    
    init (image: String, name: String, breed: String, gender: String, temperament: String, size: String , weight: Int , description: String){
        self.image = image
        self.name = name
        self.breed = breed
        self.gender = gender
        self.temperament = temperament
        self.size = size
        self.weight = weight
        self.description = description
        
    }
}
