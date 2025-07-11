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
    @StateObject private var viewModel: RecordViewModel
    @Environment(\.modelContext) var context
    
    init() {
        self._viewModel = .init(wrappedValue: .init(repository: RecordRepository()))
    }
    
    var body: some View {
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
            Rectangle()
                .fill(.textPrimary)
                .frame(width: 50, height: 50)
                .rotationEffect(viewModel.isLoading ? .degrees(0) : .degrees(100))
                .opacity(viewModel.showLoading ? 1 : 0)
          
        }
        .animation(.easeInOut.repeatForever(autoreverses: true), value: viewModel.isLoading)
        .onAppear(perform: {
       
        })
        .task {
            await  viewModel.fetch(context: context)
        }
        .sheet(isPresented: $showRecording) {
            RecordListView()
        }
      
    }
    
    var todayReview: some View {
        Section(content: {
            LazyVGrid(
                columns: [.init(spacing: 20),  .init(spacing: 20)],
                alignment: .center,
                spacing: 20
            ) {
                cardView(iconName: "", title: "排尿次数", subTitle: "4次")
                cardView(iconName: "", title: "总尿量", subTitle: "500 ml")
                cardView(iconName: "", title: "夜间次数", subTitle: "4次")
                cardView(iconName: "", title: "平均间隔", subTitle: "1小时")
            }
        }, header: {
            VStack(spacing: .zero) {
                Text("今日概况")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(Color.textPrimary)

                Text("距离上次排尿: 1小时20分")
                    .font(.callout)
                    .foregroundStyle(.textSecondary)
                    .padding(.top, 10)
            }
            .padding(.bottom, 20)
        })
    }
    
    var addBtn: some View {
        Button {
            for _ in 0 ..< 10 {
                let record = Record(date: .now, amount: 200, duration: 20, color: 0, comfortDegress: 0, presureDegress: 0, note: "It's ok now")
                context.insert(record)
            }
            try? context.save()
            
            showRecording = true
           
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

#Preview {
    ContentView()
}

