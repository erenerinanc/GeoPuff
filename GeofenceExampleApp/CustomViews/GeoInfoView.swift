//
//  GeoInfoView.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 6.05.2025.
//

import Foundation
import SwiftUI

public struct GeoInfoView: View {
    let iconImage: String
    let foregroundColor: Color
    let title: String
    let subtitle: String
    let actionHandler: () -> Void
    let backgroundColor: Color
    let notifiedLocation: String
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Image(systemName: iconImage)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 28))
                    .padding(.top, 4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .bold()

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()
                Button(action: {
                    withAnimation {
                        actionHandler()
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title3)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor.opacity(0.15))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(backgroundColor, lineWidth: 1)
            )
            .shadow(color: (backgroundColor).opacity(0.2), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.spring(), value: notifiedLocation)
        }
    }
    
}
