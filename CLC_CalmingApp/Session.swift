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
}

class Session {
    var timerDuration: Double;
    var onSessionEnd: () -> Void;
    var date: Date?;
    var finalDuration: Double?;
    var timer: Timer?;

    init(timerDuration: Double, selector: @escaping () -> Void) {
        self.timerDuration = timerDuration;
        onSessionEnd = selector;
        date = nil;
        timer = nil;
    }

    func start() {
        timer = Timer(timeInterval: TimeInterval(timerDuration),
                target: self,
                selector: #selector(sessionOver),
                userInfo: nil,
                repeats: false);
        date = Date();
    }

    func end() throws {
        timer?.invalidate();
        if date != nil {
            try sessionOver();
        } else {
            throw SessionError.invalidState("end method called before start method");
        }
    }

    @objc func sessionOver() throws {
        if let date = date {
            finalDuration = Date().timeIntervalSince(date);
            onSessionEnd();
        } else {
            throw SessionError.invalidState("timerDone method called before start method");
        }
    }

    func getFinishedSession() throws -> FinishedSession {
        if date != nil && finalDuration != nil {
            return FinishedSession(date: date!, duration: finalDuration!);
        } else {
            throw SessionError.invalidState("getFinishedSession method called before session ended");
        }
    }
}
