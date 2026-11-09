import SwiftUI

struct SplashView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.04, blue: 0.20)
                .ignoresSafeArea()

            VStack(spacing: 14) {
                Image(systemName: "wrench.and.screwdriver.fill")
                    .font(.system(size: 84))
                    .foregroundStyle(.white)
                    .scaleEffect(animate ? 1 : 0.6)
                    .opacity(animate ? 1 : 0)

                Text("AutoSpares Local")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("Your Car Parts Manager")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .onAppear {
            withAnimation(.spring(duration: 0.8)) { animate = true }
        }
    }
}

#Preview {
    SplashView()
}
