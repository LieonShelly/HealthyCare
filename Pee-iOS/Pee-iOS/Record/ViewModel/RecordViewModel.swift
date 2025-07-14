//
//  RecordViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/10.
//

import Combine
import SwiftData
import Foundation

final class RecordViewModel: ObservableObject {
    let repository: RecordRepository
    @Published var isEnable: Bool = false
    @Published var isLoading: Bool = false
    @Published var showLoading: Bool = false
    @Published var amoutInput: String = ""
    @Published var note: String = ""
    @Published var duration: String = ""
    @Published var color: ColorDegree = .normal
    @Published var presure: PresureDegree = .normal
    @Published var comfort: ComfortDegree = .normal
    @Published var date: Date = .now
    private var cancellables: Set<AnyCancellable> = .init()
    
    init( repository: RecordRepository) {
        self.repository = repository
        
        Publishers.CombineLatest($amoutInput.dropFirst().map { !$0.isEmpty }, $duration.dropFirst().map { !$0.isEmpty})
            .map { $0 && $1 }
            .assign(to: \.isEnable, on: self)
            .store(in: &cancellables)
    }
    
    deinit {
        print("deinit-RecordViewModel")
    }
    
    func update(_ record: RecordModel) {
        amoutInput = "\(record.amount)"
        note = record.note ?? ""
        duration = "\(record.duration)"
        color = record.color
        presure = record.presureDegress
        comfort = record.comfortDegress
        date = record.date
    }
    
    func fetch() async {
        await MainActor.run {
            isLoading = true
            showLoading = true
        }
        guard let _ = try? await self.repository.fetchRecords() else { return }
        await MainActor.run {
            isLoading = false
            showLoading = false
        }
    }
    
    func submit() async throws {
        guard let amount = Double(amoutInput) else {
            return
        }
        guard let duration = Double(duration) else {
            return
        }
        let record = RecordModel(
            date: date,
            amount: amount,
            duration: duration,
            color: color,
            comfortDegress: comfort,
            presureDegress: presure,
            note: note
        )
        try await repository.add(record: record)
    }
    
}

