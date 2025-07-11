//
//  RecordingView.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/9.
//

import SwiftUI

struct RecordingView: View {
    @State private var note: String = ""
    
    var body: some View {
        NavigationStack {
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
                        Text("15:11")
                            .font(.body)
                            .foregroundStyle(.textPrimary)
                    }
                }
            }
          
        }
       
    }
    
    
    var amountView: some View {
        VStack {
            HStack {
                Text("尿量").font(.body)
                TextField("ml", text: .constant(""))
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
                TextField("s", text: .constant(""))
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
                  
                    Picker("", selection: .constant(0), content: {
                        Text("正常").tag(0)
                        Text("淡黄").tag(1)
                        Text("黄色").tag(2)
                        Text("黄红").tag(3)
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
                  
                    Picker("", selection: .constant(0), content: {
                        Text("无").tag(0)
                        Text("轻度").tag(1)
                        Text("中度").tag(2)
                        Text("重度").tag(3)
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
                  
                    Picker("", selection: .constant(0), content: {
                        Text("无").tag(0)
                        Text("尿急").tag(1)
                        Text("微痛").tag(2)
                        Text("灼热").tag(3)
                        Text("残尿感").tag(4)
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
                        TextEditor(text: $note)
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
        Button(action: {}, label: {
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
}


#Preview {
    RecordingView()
}



