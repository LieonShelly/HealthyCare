//
//  HomeViewModel.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//

import Foundation

class HomeViewModel: ObservableObject {
    @MainActor @Published var times: Int = 0
    @MainActor @Published var amount: Int = 0
    @MainActor @Published var timesInNight: Int = 0
    @MainActor @Published var averageIntervals: String = "0分"
    @MainActor @Published var sinceLastTime: String = "0分"
    let frequencyViewModel: FrequencyViewModel
    
    private let service: UrineServiceful
    
    init(service: UrineServiceful) {
        self.service = service
        self.frequencyViewModel = FrequencyViewModel(service: service)
    }
    
    func fetchData() async throws {
//       try await inject()
        let amount =  try await service.todayAmountUseCase.execute()
        let times =  try await service.todayTimesUseCase.execute()
        let averageIntervals =  try await service.todayAverageIntervalUseCase.execute()
        let sinceLastTime = try await service.lastTimeUseCase.execute()
        try await frequencyViewModel.fetchData()
        await MainActor.run {
            self.amount = amount
            self.times = times
            self.averageIntervals = RecordFormatter.formattedDuration(averageIntervals)
            self.sinceLastTime = sinceLastTime.formattedDuration
        }
    }
    
    func inject() async throws {
        let repository = RecordRepository()
        let now = Date.startOfToday
        let calendar = Calendar.current
        for index in (0 ..< 7) {
            guard let today = calendar.date(byAdding: .day, value: -index, to: now) else { continue }
            
            for _ in 0 ..< Int.random(in: 10 ... 20) {
                let hours = Int.random(in: 0 ... 5)
                guard let date = calendar.date(byAdding: .hour, value: hours, to: today) else {
                    continue
                }
                let record = RecordModel(
                    date: date,
                    amount: Double.random(in: 20 ... 50),
                    duration:  Double.random(in: 20 ... 50),
                    color: .normal,
                    comfortDegress: .normal,
                    presureDegress: .normal,
                    note: "note"
                )
                try await repository.add(record: record)
            }
        }
    }
}
