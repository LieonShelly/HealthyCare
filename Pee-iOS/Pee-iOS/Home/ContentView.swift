//
//  ContentView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/9.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showRecording: Bool = false
    @State private var showList: Bool = false
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: RecordCoordinator
    
    init(viewModel: HomeViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path)  {
            ZStack(alignment: .bottom) {
                Color.backgroundPage.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: .zero) {
                        todayReview
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                }
                addBtn
            }
            .onAppear(perform: {
                Task.detached {
                    do {
                      try await viewModel.fetchData()
                    } catch {
                        
                    }
                }
            })
            .sheet(item: $coordinator.modal) { route in
                coordinator.view(for: route)
            }
            .navigationDestination(for: RecordRoute.self) { route in
                coordinator.view(for: route)
            }
        }
    }
    
    var todayReview: some View {
        Section(content: {
            LazyVGrid(
                columns: [.init(spacing: 20),  .init(spacing: 20)],
                alignment: .center,
                spacing: 20
            ) {
                cardView(iconName: "", title: "排尿次数", subTitle: "\(viewModel.times)次")
                cardView(iconName: "", title: "总尿量", subTitle: "\(viewModel.amount) ml")
                cardView(iconName: "", title: "夜间次数", subTitle: "NA次")
                cardView(iconName: "", title: "平均间隔", subTitle: "\(viewModel.averageIntervals)")
            }
        }, header: {
            VStack(spacing: .zero) {
                Text("今日概况")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(Color.textPrimary)
                    .onTapGesture {
                        coordinator.push(RecordRoute.recordList)
                    }

                Text("距离上次排尿: \(viewModel.sinceLastTime)")
                    .font(.callout)
                    .foregroundStyle(.textSecondary)
                    .padding(.top, 10)
            }
            .padding(.bottom, 20)
        })
    }
    
    var addBtn: some View {
        Button {
            coordinator.push(RecordRoute.recording(nil))
        } label: {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.appPrimary)
                .frame(width: 80, height: 80)
                .shadow(color: Color.appPrimary.opacity(0.5), radius: 10)
                .overlay {
                    Image(systemName: "plus")
                        .tint(.white)
                        .font(.largeTitle)
                        .scaleEffect(1.2)
                }
            
        }
    }
    
    private func cardView(iconName: String, title: String, subTitle: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.backgroundCard)
            .frame(height: 140)
            .overlay {
                VStack(alignment: .leading, spacing: .zero) {
                    // icon
                    HStack {
                        Image(systemName: "microbe.circle.fill")
                            .foregroundStyle(.textSecondary)
                            .font(.title)
                            .padding(.top, 20)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                    
                   
                    VStack(alignment: .leading, spacing: 10) {
                        Text(subTitle)
                            .foregroundStyle(.appPrimary)
                            .font(.title3.weight(.bold))
                        
                        
                        Text(title)
                            .foregroundStyle(.textSecondary)
                            .font(.callout.weight(.bold))
                    }
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
                }
            }
     

    }
}
//
//#Preview {
//    ContentView()
//}
