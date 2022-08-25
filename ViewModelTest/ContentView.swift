
import SwiftUI
import Combine


extension ViewModel {
    enum Action {
        case onAppear
        case onCommitInputName
        case onInputComplete
    }
}


class ViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var isLogin = false
    var cancellables = Set<AnyCancellable>()
    private let actionSubject = PassthroughSubject<Action, Never>()
    
    init() {
        actionSubject
            .sink(receiveValue: { actionType in
                switch actionType {
                case .onAppear:
                    print("onAppear")
                case .onCommitInputName:
                    print(self.name)
                case .onInputComplete:
                    if self.name == "test" && self.password == "test" {
                        self.isLogin = true
                    } else {
                        self.isLogin = false
                    }
                }
            })
            .store(in: &cancellables)
    }
    func send(_ action: Action) {
        actionSubject.send(action)
    }
}

extension ViewModel {
    struct State {
        fileprivate(set) var providerTypes: [String]
    }
}

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        Group {
            if viewModel.isLogin {
                memberInfo
            } else {
                loginForm
                
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
    
    var memberInfo: some View {
        Text("ようこそ、\(viewModel.name)さん!")
    }
    
    var loginForm: some View {
        VStack {
            
            Spacer()
            
            TextField(
                "あなたの名前",
                text: $viewModel.name,
                onEditingChanged: { begin in
                },
                onCommit: {
                    viewModel.send(.onCommitInputName)
                }
            )
            .onReceive(Just($viewModel.name)) { name in
                print(name)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
            
            SecureField("8〜16文字のパスワードを入力してください。", text: $viewModel.password, onCommit: {
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.alphabet)
            
            Spacer()
            
            Button(action: {
                viewModel.send(.onInputComplete)
            }){
                Text("ログイン")
            }
            Spacer()
            
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
}
