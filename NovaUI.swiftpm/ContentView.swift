import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Page View") {
                    PageViewPreview()
                }
                NavigationLink("Map View") {
                    MapPreviewView()
                }
                NavigationLink("Birthdate Picker") {
                    BirthdatePicker.PreviewView()
                }
            }
        }
    }
}
