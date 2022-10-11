import SwiftUI

struct ProfileHost: View {
    
    /**
     SwiftUI provides storage in the environment for values which can be accessed using @Environment property wrapper
     */
    @Environment(\.editMode) var editMode; // .editMode is a built-in function to let users edit contents of an object
    
    @EnvironmentObject var modelData: ModelData;
    
    @State private var draftProfile = Profile.default;
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack  {
                if (editMode?.wrappedValue == .active) {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile;
                        editMode?.animation().wrappedValue = .inactive;
                    }
                }
                Spacer();
                EditButton(); //The EditButton controls the same editMode environment value that you accessed above.
            }
            
            if (editMode?.wrappedValue == .inactive) {
                ProfileSummary(profile: modelData.profile);
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile;
                    }
                    .onDisappear {
                        modelData.profile = draftProfile;
                    }
            }
            
        }
        .padding();
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData());
    }
}
