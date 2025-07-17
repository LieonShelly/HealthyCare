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
            VStack {
                monthView
                heatMap
            }
        }
    }
    
    var monthView: some View {
        HStack(spacing: 4) {
            ForEach(viewModel.months, id: \.label) { month in
                HStack {
                    Text(month.label)
                        .font(.caption)
                    Spacer()
                }
                .frame(width: CGFloat(month.columnCount) * 12.0 + CGFloat(month.columnCount - 1) * 4.0)
                .background(.red)
            }
        }
    }
    
    var heatMap: some View {
        HStack(alignment: .top, spacing: 4) {
            ForEach(viewModel.columns, id: \.id) { column in
                VStack(spacing: 4) {
                    ForEach(1 ... 7, id: \.self) { row in
                        if let day = column.weekDays.first(where: { viewModel.calendar.component(.weekday, from: $0.date) == row}) {
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
