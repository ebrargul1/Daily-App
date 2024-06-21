//
//  CalendarView.swift
//  DailyApp
//
//  Created by Ebrar Gül on 21.06.2024.
//

import SwiftUI
import FSCalendar // Doğru import burada

struct CalendarView: UIViewRepresentable {
    
    @Binding var appThemeColor: Color
    @Binding var selectedDate: Date
    @Binding var actionInput: Int?
    @Binding var items: [Item]

    func makeUIView(context: Context) -> FSCalendar {
        let coordinator = context.coordinator
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        calendar.dataSource = coordinator
        calendar.delegate = coordinator
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        let appColor = UIColor(appThemeColor)
        let appearance = uiView.appearance
        
        appearance.borderRadius = 4.0
        appearance.titlePlaceholderColor = UIColor.systemGray
        appearance.subtitlePlaceholderColor = appColor
        appearance.titleDefaultColor = UIColor.label
        appearance.eventSelectionColor = appColor
        
        appearance.todayColor = appColor.withAlphaComponent(0.25)
        appearance.titleTodayColor = appColor
        
        appearance.selectionColor = appColor
        
        appearance.eventDefaultColor = appColor
        appearance.subtitleTodayColor = appColor
        
        appearance.headerTitleColor = appColor
        appearance.subtitleDefaultColor = appColor
        
        appearance.weekdayTextColor = appColor
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDataSource, FSCalendarDelegate {
        
        var control: CalendarView
        
        init(_ control: CalendarView) {
            self.control = control
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
            let items = control.$items.wrappedValue
            if items.first(where: { item in
                item.timestamp!.startOfDay == date.startOfDay
            }) != nil{
                return 1
            }
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
            return ""
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            debugPrint("calendar didSelect => \(date)")
            if date < Date() {
                let generator = UIImpactFeedbackGenerator(style: .soft)
                generator.impactOccurred()
                control.selectedDate = date
                control.actionInput = 1
            } else {
                control.actionInput = 0
            }
        }
    }
}
