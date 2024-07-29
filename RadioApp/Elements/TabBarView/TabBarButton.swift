import SwiftUI

struct TabBarButton: View {
    // propertis
    let nameTab: String
    let tab: TabBarView.Tab
    @Binding var selectTab: TabBarView.Tab
    
    var body: some View {
        // castom button tab bar and color circle
        VStack {
            Button {
                selectTab = tab
            } label: {
                Text(nameTab)
                    .font(.system(size: 20))
                    .foregroundColor(selectTab == tab ? .white : .gray)
            }
            if selectTab == tab {
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color("RALightBlue"))
            } else {
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.clear)
            }
        }
    }
}
