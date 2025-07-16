//
//  HeatMapView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/15.
//

import SwiftUI

struct CalendarView: View {
    enum Constants {
        static let itemSize: CGSize = .init(width: 40, height: 40)
    }
    @StateObject var viewModel: CalendarViewModel = .init()
    
    var body: some View {
        GeometryReader { proxy in
            let spacing = (proxy.size.height - Constants.itemSize.height * 7) / 6
            VStack(spacing: spacing) {
               weekDay()
                    .frame(width: proxy.size.width, height: Constants.itemSize.height)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: .zero) {
                        ForEach(viewModel.monthList, id: \.id) { month in
                            moth(days: month.days)
                                .frame(width: proxy.size.width)
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
            }
            .background(.green)
        }
       
        
    }
    
    @ViewBuilder
    func moth(days: [CalendarDay]) -> some View {
        GeometryReader { proxy in
            let itemWidth: CGFloat = 40
            let horizontalSpacing = (proxy.size.width - 7 * itemWidth) / 6
            let columns = Array(repeating: GridItem(.fixed(itemWidth), spacing: horizontalSpacing), count: 7)
            LazyVGrid(
                columns: columns,
                spacing: horizontalSpacing,
                content: {
                    ForEach(days) { day in
                        Text("\(Calendar.current.component(.day, from: day.date))")
                            .frame(width: itemWidth, height: itemWidth)
                            .foregroundColor(day.isCurrentMonth ? .primary : .gray)
                            .background(day.isToday ? Color.blue : Color.red)
                    }
                })
            .background(.yellow)
        }
      
    }
    
    func weekDay() -> some View {
        GeometryReader { proxy in
            let itemW: CGFloat = 40
            let spacing = (proxy.size.width - 7 * itemW) / 6
            HStack(spacing: spacing) {
                ForEach(viewModel.weekdays, id: \.self) { day in
                    Text(day)
                       
                        .frame(width: itemW, height: itemW)
                        .background(.blue)
                }
            }
            .frame(height: 40)
            .background(.yellow)
        }
     
    }
}

#Preview(body: {
    HStack {
        CalendarView().frame(height: 360)
    }
    .padding()
})
