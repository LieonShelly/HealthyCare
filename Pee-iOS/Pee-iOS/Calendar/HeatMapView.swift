//
//  HeatMapView 2.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/16.
//

import SwiftUI

struct HeatMapView: View {
    enum Constants {
        static let spacing: CGFloat = 50
    }
    @StateObject var viewModel: HeatMapViewModel = .init()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators:  false) {
            HStack(alignment: .top, spacing: 4) {
                ForEach(viewModel.columns.indices, id: \.self) { colIndex in
                    VStack(spacing: 4) {
                        ForEach(0..<7, id: \.self) { row in
                            let column = viewModel.columns[colIndex]
                            if let day = column.first(where: { Calendar.current.component(.weekday, from: $0.date) == (row + 1)}) {
                                Rectangle()
                                    .fill(color(for: day.level))
                                    .frame(width: 12, height: 12)
                            } else {
                                Color.clear
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func color(for level: Int) -> Color {
        switch level {
        case 1: return .green.opacity(0.3)
        case 2: return .green.opacity(0.5)
        case 3: return .green.opacity(0.7)
        case 4: return .green
        default: return .gray.opacity(0.2)
        }
    }
}

#Preview {
    HeatMapView()
        .padding()
}
