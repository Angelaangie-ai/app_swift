import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData;
    @State private var showFavoritesOnly = false;
    @State private var showMeatOnly = false;
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter {
            landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var filteredLandmarks1: [Landmark] {
        modelData.landmarks.filter {
            landmark in
            (!showMeatOnly || landmark.isMeat)
        }
    }

    
    var body: some View {
        NavigationView{
            List{ // Reading data from landmarks inited in ModelData retrieving data from json
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites")
                }
                ForEach(filteredLandmarks) {
                    landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark);
                        }
                }
                ForEach(filteredLandmarks1) {
                    landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark);
                        }
                }
            }
            .navigationTitle("Buy Fresh Buy Local")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
