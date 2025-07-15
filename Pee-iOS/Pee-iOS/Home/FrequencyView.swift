//
//  FrequencyView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/15.
//

import SwiftUI
import Charts

struct FrequencyView: View {
    @State var selectedDate: Date?
    @State var frequencies: [Frequency] = []
    @ObservedObject private var viewModel: FrequencyViewModel
    
    init(viewModel: FrequencyViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        frequencyView
    }
    
    var frequencyView: some View {
        Chart(frequencies, id: \.date) { frequency in
            BarMark(
                x: .value("Date", frequency.date),
                y: .value("Times", frequency.times),
                width: 30,
                height: 30
            )
            .foregroundStyle(selectedDate == frequency.date ? Color.appPrimary.gradient : Color.appPrimary.opacity(0.8).gradient)
            .annotation(position: .top) {
                Text("\(frequency.times)")
                    .font(.caption)
                    .foregroundStyle(Color.textPrimary)
                    .frame(height: 30)
                    .opacity(selectedDate == frequency.date ? 1 : 0)
                    .animation(.easeInOut, value: selectedDate)
            }
        }
        .chartXAxis(content: {
            AxisMarks(values: viewModel.frequencies.map { $0.date }) { value in
                AxisValueLabel {
                    if let date = value.as(Date.self) {
                        VStack {
                            Text(date.week)
                            Text(date.MDotD)
                        }
                    }
                }
            }
        })
        .chartOverlay(content: { proxy in
            Rectangle()
                .fill(.clear)
                .contentShape(.rect)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            let location = value.location
                            if let date: Date = proxy.value(atX: location.x),
                               let nearest = viewModel.frequencies.min(
                                by: { abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date)) }
                               ), nearest.times > 0 {
                                selectedDate = nearest.date
                            } else {
                                selectedDate = nil
                            }
                        })
                )
        })
        .frame(height: 200)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .onChange(of: viewModel.frequencies) { _, newValue in
            if frequencies.count != newValue.count {
                frequencies = newValue
            } else {
                for index in newValue.indices {
                    withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                        frequencies[index].times = newValue[index].times
                    }
                }
            }
        }
    }
}
