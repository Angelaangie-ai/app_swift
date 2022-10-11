
import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        // AnyTransition.slide makes the graph move in and out from different sides
        // AnyTransition.move makes the graph moe in and out from the same side
        // AnyTransition.move(edge: .trailing);
        
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = true

    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    /**
                        withAnimation function animates all the views affected by showDetail
                     */
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .padding()
                        .scaleEffect(showDetail ? 1.3 : 1)
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade);
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: ModelData().hikes[0])
                .padding()
            Spacer()
        }
    }
}
