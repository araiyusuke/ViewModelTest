
import SwiftUI
import Combine


extension ViewModel {
    enum Action {
        case tapCreateAccountButton
        case onAppear
    }
}


class ViewModel: ObservableObject {

    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
    private let actionSubject = PassthroughSubject<Action, Never>()

    init() {
        actionSubject
              .sink(receiveValue: { actionType in
                  switch actionType {
                  case .tapCreateAccountButton:
                      self.count += 1
                  case .onAppear:
                      print("onAppear")
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
        ZStack {
            Text(viewModel.count.description)
                .padding()
                .onTapGesture {
                    viewModel.send(.tapCreateAccountButton)
                    #if DEVELOP
                        print("DEVELOP")
                    #else
                        print("OTHER")
                    #endif
                }

        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        .onAppear {
//            viewModel.send(.onAppear)
        }
    }
}
