import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool; // Thanks to @Binding, changes made inside this view propagate back to the data source
    
    var body: some View {
        Button {
            isSet.toggle();
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray);
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
