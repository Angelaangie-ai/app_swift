import SwiftUI

@main // identifies app's entry point
struct swift_demo_App: App {
    @StateObject private var modelData = ModelData();
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData);
        }
    }
}
