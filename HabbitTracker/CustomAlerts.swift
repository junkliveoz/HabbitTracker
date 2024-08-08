//
//  CustomAlerts.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var onCancel: () -> Void
    var onConfirm: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    Button("Cancel") {
                        onCancel()
                    }
                    .foregroundColor(.red) // Customize cancel color here
                    .padding()
                    .background(Color.darkGray)
                    .cornerRadius(10)
                    
                    Button("Yes") {
                        onConfirm()
                    }
                    .foregroundColor(.green) // Customize confirm color here
                    .padding()
                    .background(Color.darkGray)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.7))
            .cornerRadius(15)
            .padding(40)
        }
    }
}
