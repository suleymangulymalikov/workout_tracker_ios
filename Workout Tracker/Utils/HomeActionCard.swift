//
//  HomeActionCard.swift
//  Workout Tracker
//
//  Created by stud on 03/11/2025.
//
import SwiftUI

struct HomeActionCard: View {
    let title: String
    let color: Color
    let icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color.opacity(0.15))
            .frame(height: 200)
            .overlay(
                
                
                VStack(spacing: 10){
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                        .frame(height: 60)
                        .frame(width: 60)
                        .overlay(
                            Image(systemName: icon)
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                            
                        )
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)
                }
            )
    }
}


#Preview {
    MainTabView()
}

