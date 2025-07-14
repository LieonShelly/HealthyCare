//
//  RecordListView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import SwiftUI
import SwiftData

struct RecordListView: View {
    @ObservedObject var viewModel: RecordListViewModel
    @State var lastErrorMessage: String = ""
    @State var showError: Bool = false
    @EnvironmentObject var coordinator: RecordCoordinator
    
    init(viewModel: RecordListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.backgroundPage.ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.list, id: \.id) { record in
                        item(record)
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear(perform: {
            })
            .task {
                do {
                    try await viewModel.fetch()
                } catch {
                    lastErrorMessage = error.localizedDescription
                }
            }
            .navigationTitle("排尿记录")
            .navigationBarTitleDisplayMode(.large)
            .alert("Error", isPresented: $showError, actions: {
                Button("CLose", role: .cancel) {}
            }, message: {
                Text(lastErrorMessage)
            })
        }
    }
    
    func item(_ record: RecordModel) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            
            Text(record.date.hhmm)
                .font(.body)
                .foregroundStyle(.appPrimary)
                .padding(.bottom, 20)
            
            HStack(spacing: .zero) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.appPrimary)
                    .frame(width: 3, height: 50)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("持续时间：\(record.duration)").font(.title3.weight(.semibold))
                    Text("尿量：\(record.amount) ml").font(.body.weight(.semibold)).foregroundStyle(.textSecondary)
                }
                .padding(.leading, 12)
            }
            HStack {
                Text("压力: \(record.presureDegress.desc)").font(.callout.weight(.medium)).foregroundStyle(.textThird)
                Spacer()
                Text("不适感: \(record.comfortDegress.desc)").font(.callout.weight(.medium)).foregroundStyle(.textThird)
                Spacer()
                Button(action: {}) {
                    Text("更多")
                        .font(.callout.weight(.medium))
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.lightGreen)
                                .frame(width: 60, height: 30)
                        }
                }
                .padding(.trailing, 12)
            }
            .padding(.top, 20)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        )
        .onTapGesture {
            coordinator.push(RecordRoute.recording(record))
        }
    }
    
}
