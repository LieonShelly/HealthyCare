//
//  RecordListView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import SwiftUI
import SwiftData

struct RecordListView: View {
//    @ObservedObject var viewModel: RecordListViewModel
    @Environment(\.modelContext) var modelContext
    
    @Query var list: [Record] = []
    
//    init(viewModel: RecordListViewModel) {
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPage.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(list, id: \.id) { record in
                            item(record)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .navigationTitle("排尿记录")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
    
    func item(_ record: Record) -> some View {
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
                Text("压力: 正常").font(.callout.weight(.medium)).foregroundStyle(.textThird)
                Spacer()
                Text("不适感: 正常").font(.callout.weight(.medium)).foregroundStyle(.textThird)
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
    }
    
}

import Foundation

extension Date {
    
    var hhmm: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
       return dateFormatter.string(from: self)
    }
}

