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
        SimpleEntry(date: Date(), location: "여의도", nowWeather: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), location: "여의도", nowWeather: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        //위젯의 업데이트 주기 : 3시간 (api와 동일)
        let currentDate = Date()
        let threeHoursLater = Calendar.current.date(byAdding: .hour, value: 3, to: currentDate)!

        let entry = SimpleEntry(date: threeHoursLater, location: "내 도시", nowWeather: "")
        
        let timeline = Timeline(entries: [entry], policy: .after(threeHoursLater))
        completion(timeline)
    }
}


//엔트리
struct SimpleEntry: TimelineEntry {
    let date: Date
    let location: String
    let nowWeather: String
}


//뷰
struct myWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            //1. 지역 / 날짜 / 요일
            Text("\(getFormattedDate(entry.date)) \(entry.location)")
                .font(.caption)
                .fontWeight(.regular)
                .foregroundColor(.white)
            
            //2. 날씨와 온도
            Text("\(nowWeather) \(nowtempurture)ºC")
                .font(.title3)
                .fontWeight(.regular)
                .foregroundColor(.white)
            
            //3. 아이콘
            Image("cloudColorOff") // 날씨에 따라 가변하도록 변경 예정
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
        }
        
        .padding(.all, 10)
        .background(Image("widgetBG"))
    }
}//View

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
        .configurationDisplayName("우산 챙겨")
        .description(".")
        .supportedFamilies([.systemSmall, .systemMedium]) //지원하는 위젯 크기
    }
}

#Preview(as: .systemSmall) {
    myWidget()
} timeline: {
    SimpleEntry(date: .now, location: "서울", nowWeather: "")
    SimpleEntry(date: .now, location: "부산2", nowWeather: "")
}
