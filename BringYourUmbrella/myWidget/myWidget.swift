//
//  myWidget.swift
//  myWidget
//
//  Created by t2023-m0114 on 5/16/24.
//

import WidgetKit
import SwiftUI

var nowWeather: String = "흐림"
var nowtempurture: String = "20"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), location: "지역", nowWeather: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), location: "나의 지역", nowWeather: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        //위젯의 업데이트 주기 : 3시간 (api와 동일)
        let currentDate = Date()
        let threeHoursLater = Calendar.current.date(byAdding: .hour, value: 3, to: currentDate)!

        let entry = SimpleEntry(date: threeHoursLater, location: "나의 도시", nowWeather: "😀")
        let timeline = Timeline(entries: [entry], policy: .after(threeHoursLater))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let location: String
    let nowWeather: String
}

struct myWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            //1. 현재지역 / 날짜 / 요일
            Text("\(entry.location) \(getFormattedDate(entry.date))")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            //2. 날씨와 온도
            Text("\(nowWeather) \(nowtempurture)ºC")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            //3. 아이콘
            Image("cloudColorOff") // 날씨에 따라 가변하도록 변경 예정
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
        
        .padding(.all, 10)
        //.background(Color(red: 103/255, green: 198/255, blue: 227/255))
        .background(Image("widgetBG"))
    }
}

// 날짜 / 요일 데이터 가져오기
func getFormattedDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M / d E"
    return dateFormatter.string(from: date)
}

struct myWidget: Widget {
    let kind: String = "BringYourUmbrella.myWidget" //위젯을 식별하는 문자열

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                myWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                myWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("BringYourUmbrella Widget")
        .description("Bring Your Umbrella Widget로 이동합니다.")
        .supportedFamilies([.systemSmall, .systemMedium]) //지원하는 위젯 크기
    }
}

#Preview(as: .systemSmall) {
    myWidget()
} timeline: {
    SimpleEntry(date: .now, location: "서울", nowWeather: "")
    SimpleEntry(date: .now, location: "부산2", nowWeather: "")
}
