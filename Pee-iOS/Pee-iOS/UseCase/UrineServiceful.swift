//
//  UrineServiceful.swift
//  Pee-iOS
//
//  Created by Renjun Li on 2025/7/14.
//



import Foundation

protocol UrineServiceful {
    var todayAmountUseCase: TodayAmountUseCaseType { get }
    var todayTimesUseCase: TodayTimesUseCaseType { get }
    var todayAverageIntervalUseCase: TodayAverageIntervalUseCaseType { get }
    var lastTimeUseCase: SinceLastTimeUseCaseType { get }
}

class UrineService: UrineServiceful {
    let respository: RecordRepositoryType
    
    lazy var todayAmountUseCase: TodayAmountUseCaseType = {
        TodayAmountUseCase(repository: respository)
    }()
    
    lazy var todayTimesUseCase: any TodayTimesUseCaseType = {
        TodayTimesUseCase(repository: respository)
    }()
    
    lazy var todayAverageIntervalUseCase: any TodayAverageIntervalUseCaseType = {
        TodayAverageIntervalUseCase(repository: respository)
    }()
    
    lazy var lastTimeUseCase: SinceLastTimeUseCaseType = {
        SinceLastTimeUseCase(repository: respository)
    }()
    
    init(respository: RecordRepositoryType) {
        self.respository = respository
    }
}
