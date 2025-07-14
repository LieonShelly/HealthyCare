//
//  RecordingView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/9.
//

import SwiftUI

struct RecordingView: View {
    @ObservedObject var viewModel: RecordViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coordinator: RecordCoordinator
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            Color.backgroundPage.ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 20) {
                    Section(content: {
                        amountView
                        timeView
                        colorView
                        presureView
                        feelView
                        noteView
                        confirmBtn
                    })
                }
            }
            .navigationTitle("添加记录")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    dateView
                }
            }
        }
        
        
    }
    
    
    var amountView: some View {
        VStack {
            HStack {
                Text("尿量").font(.body)
                TextField("ml", text: $viewModel.amoutInput)
                    .keyboardType(.numberPad)
                    .font(.body)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .padding(.horizontal, 20)
    }
    
    var timeView: some View {
        VStack {
            HStack {
                Text("持续时间").font(.body)
                TextField("s", text: $viewModel.duration)
                    .keyboardType(.numberPad)
                    .font(.body)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .padding(.horizontal, 20)
    }
    
    var colorView: some View {
        HStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("颜色").font(.body)
                    
                    Picker("", selection: $viewModel.color, content: {
                        Text("正常").tag(ColorDegree.normal)
                        Text("淡黄").tag(ColorDegree.light)
                        Text("黄色").tag(ColorDegree.medium)
                        Text("黄红").tag(ColorDegree.severe)
                    })
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
            }
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .padding(.horizontal, 20)
    }
    
    var presureView: some View {
        HStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("排尿压力").font(.body)
                    
                    Picker("", selection: $viewModel.presure, content: {
                        Text("无").tag(PresureDegree.normal)
                        Text("轻度").tag(PresureDegree.light)
                        Text("中度").tag(PresureDegree.medium)
                        Text("重度").tag(PresureDegree.severe)
                    })
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
            }
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .padding(.horizontal, 20)
    }
    
    var feelView: some View {
        HStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("排尿不适感").font(.body)
                    
                    Picker("", selection: $viewModel.comfort, content: {
                        Text("无").tag(ComfortDegree.normal)
                        Text("尿急").tag(ComfortDegree.light)
                        Text("微痛").tag(ComfortDegree.medium)
                        Text("灼热").tag(ComfortDegree.severe)
                        Text("残尿感").tag(ComfortDegree.extraSevere)
                    })
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
            }
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .padding(.horizontal, 20)
    }
    
    var noteView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("备注").font(.body)
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.backgroundPage)
                    .frame(height: 100)
                    .overlay {
                        TextEditor(text: $viewModel.note)
                            .scrollContentBackground(.hidden)
                            .padding(.horizontal, 12)
                    }
                
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backgroundCard)
        }
        .padding(.horizontal, 20)
    }
    
    var confirmBtn: some View {
        Button(action: {
            Task {
//                try? await viewModel.submit()
                coordinator.popToRoot()
            }
        }, label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appPrimary)
                .frame(height: 48)
                .padding(.horizontal, 20)
                .overlay {
                    Text("提交").font(.body.weight(.bold))
                        .foregroundStyle(.white)
                }
        })
    }
    
    @State var showDatePicker: Bool = false
    
    var dateView: some View {
        Text("\(viewModel.date.hhmm)")
            .font(.body)
            .foregroundStyle(.textPrimary)
            .onTapGesture {
                showDatePicker = true
            }
            .sheet(isPresented: $showDatePicker, content: {
                VStack {
                    DatePicker("",
                               selection: $viewModel.date,
                               in: ...Date.now,
                               displayedComponents: [.hourAndMinute, .date]
                    )
                    .tint(.appPrimary)
                    .datePickerStyle(.graphical)
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.appPrimary)
                            .frame(height: 48)
                            .padding(.horizontal, 20)
                            .overlay {
                                Text("确认").font(.body.weight(.bold))
                                    .foregroundStyle(.white)
                            }
                    })
                    
                }
                
            })
    }
}


//#Preview {
//    RecordingView()
//}



