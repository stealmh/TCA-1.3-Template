//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.

import ComposableArchitecture
import SwiftUI

struct ___VARIABLE_sceneName___View: View {
    /// - Properties
    let store: StoreOf<___VARIABLE_sceneName___Feature>
    @ObservedObject var viewStore: ViewStore<___VARIABLE_sceneName___Feature.State, ___VARIABLE_sceneName___Feature.Action.ViewAction>
    /// - Initializer
    init(store: StoreOf<___VARIABLE_sceneName___Feature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 }, send: { .view($0) })
    }
}
//MARK: - View
extension ___VARIABLE_sceneName___View {
    var body: some View {
        VStack {
            Text("Hello World!")
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}
//MARK: - Configure View
extension ___VARIABLE_sceneName___View {
    
}
//MARK: - Preview
struct ___VARIABLE_sceneName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_sceneName___View(
            store: Store(
                initialState: .init(),
                reducer: { ___VARIABLE_sceneName___Feature() }
            )
        )
    }
}


