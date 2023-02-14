//
// This source file is part of the CS342 2023 PAWS Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PAWSContacts
import PAWSMockDataStorageProvider
import PAWSSchedule
import PAWSNotificationScreen
import PAWSSharedContext
import SwiftUI


struct HomeView: View {
    enum Tabs: String {
        case notifications
        case contact
        case mockUpload
    }
    
    
    @AppStorage(StorageKeys.homeTabSelection) var selectedTab = Tabs.notifications
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            //            ScheduleView()
            //                .tag(Tabs.schedule)
            //                .tabItem {
            //                    Label("SCHEDULE_TAB_TITLE", systemImage: "square.and.arrow.up")
            //                }
            NotificationScreen()
                .tag(Tabs.notifications)
                .tabItem {
                    Label("NOTIFICATIONS_TAB_TITLE", systemImage: "bell.fill")
                }
            Contacts()
                .tag(Tabs.contact)
                .tabItem {
                    Label("CONTACTS_TAB_TITLE", systemImage: "person.fill")
                }
            MockUploadList()
                .tag(Tabs.mockUpload)
                .tabItem {
                    Label("MOCK_UPLOAD_TAB_TITLE", systemImage: "server.rack")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
