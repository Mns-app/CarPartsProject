import SwiftUI

struct LoginView: View {
    // Saved in UserDefaults
    @AppStorage("userName") private var userName = ""
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @State private var input = ""
    @FocusState private var isFocused: Bool

    private let brand = Color(red: 0.95, green: 0.04, blue: 0.20)

    // Validation: 3–40 characters, only letters, numbers, space, _ - .
    private var isValid: Bool {
        let text = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard text.count >= 3, text.count <= 40 else { return false }
        return text.allSatisfy {
            $0.isLetter || $0.isNumber || $0 == " " || $0 == "_" || $0 == "-" || $0 == "."
        }
    }

    private var showError: Bool { !input.isEmpty && !isValid }

    var body: some View {
        VStack(spacing: 18) {
            Spacer()

            Image(systemName: "wrench.and.screwdriver.fill")
                .font(.system(size: 72))
                .foregroundStyle(brand)

            Text("AutoSpares Local")
                .font(.largeTitle.bold())

            Text("Enter your name to start")
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 6) {
                TextField("Your Name or Student ID", text: $input)
                    .textContentType(.name)
                    .autocorrectionDisabled()
                    .submitLabel(.go)
                    .focused($isFocused)
                    .padding()
                    .background(Color(.secondarySystemBackground),
                                in: RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(showError ? Color.red : Color.clear, lineWidth: 1.5)
                    )
                    .onSubmit(signIn)

                if showError {
                    Label("Use 3–40 letters, numbers or spaces.", systemImage: "exclamationmark.circle")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            }

            Button(action: signIn) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(isValid ? brand : Color.gray.opacity(0.5),
                                in: RoundedRectangle(cornerRadius: 14))
            }
            .disabled(!isValid)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, 24)
        .onAppear { isFocused = false }
    }

    private func signIn() {
        guard isValid else { return }
        userName = input.trimmingCharacters(in: .whitespacesAndNewlines)   // saved to UserDefaults
        isLoggedIn = true                                                  // uuu - RootView reacts to this
    }
}

#Preview {
    LoginView()
}
