//
//  Meditation.swift
//  CLC_CalmingApp
//
//  Created by Tiger Coder on 12/9/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import Foundation

enum SessionError: Error {
    case invalidState(String);
}

struct FinishedSession {
    var date: Date;
    var duration: Double;
    var endedManually: Bool;
}

class Session {
    var timerDuration: Double;
    var timerDoneListener: () -> Void;
    var timer: Timer?;
    // The following three will be used in getFinishedSession
    var startTime: Date?;
    var finalDuration: Double?;
    var endedManually: Bool?;

    init(timerDuration: Double, timerDoneListener: @escaping () -> Void) {
        self.timerDuration = timerDuration;
        self.timerDoneListener = timerDoneListener;
        startTime = nil;
        timer = nil;
    }

    func start() {
        timer = Timer(timeInterval: timerDuration,
                target: self,
                selector: #selector(onTimerDone),
                userInfo: nil,
                repeats: false);
        startTime = Date();
    }

    func end() throws {
        timer?.invalidate();
        endedManually = true;
        if startTime != nil {
            calculateDuration();
        } else {
            throw SessionError.invalidState("end method called before start method");
        }
    }

    @objc func onTimerDone() {
        endedManually = false;
        calculateDuration();
        timerDoneListener();
    }

    private func calculateDuration() {
        if let date = startTime {
            finalDuration = Date().timeIntervalSince(date);
        } else {
            // This should never happen because it is checked for in end()
            // and won't be called automatically unless start() is called

            // throw SessionError.invalidState("calculateDuration method called before start method");
        }
    }

    func getFinishedSession() throws -> FinishedSession {
        if startTime != nil && finalDuration != nil && endedManually != nil {
            return FinishedSession(date: startTime!, duration: finalDuration!, endedManually: endedManually!);
        } else {
            throw SessionError.invalidState("getFinishedSession method called before session ended");
        }
    }
}
