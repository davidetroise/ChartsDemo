//
//  ContentView.swift
//  ChartsDemo
//
//  Created by Davide Troise with Swift 5.0
//  for the YouTube channel "Coding con Davide" https://bit.ly/3QJziJE
//

import SwiftUI
import Charts

enum ActivityType: String {
    case stretching
    case walking
    case running
    case biking
}

enum SurfaceType: String {
    case road
    case trail
    case none
}

struct Activity: Identifiable {
    let id = UUID()
    let type: ActivityType
    let duration: Int
    let surface: SurfaceType
}

struct ContentView: View {
    let activities: [Activity] = [
        .init(type: .walking, duration: 30, surface: .road),
        .init(type: .running, duration: 60, surface: .trail),
        .init(type: .biking, duration: 120, surface: .road),
        .init(type: .stretching, duration: 20, surface: .none),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Chart(activities) { activity in
                    BarMark(x: .value("Activity Type", activity.type.rawValue),
                            y: .value("Duration (min)", activity.duration))
                    .foregroundStyle(by: .value("Surface Type", activity.surface.rawValue))
                    
                    RuleMark(y: .value("Threshold", 100))
                    
                }
                .foregroundColor(.red)
                .frame(height: 200)
                .padding()
                
                Chart(activities) { activity in
                    LineMark(x: .value("Activity Type", activity.type.rawValue),
                             y: .value("Duration (min)", activity.duration))
                    .interpolationMethod(.monotone)
                    
                    AreaMark(x: .value("Activity Type", activity.type.rawValue),
                             y: .value("Duration (min)", activity.duration))
                    .interpolationMethod(.monotone)
                    .foregroundStyle(.blue.opacity(0.4).gradient)
                }
                .frame(height: 200)
                .padding()
            }
            .navigationTitle("Activities charts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
