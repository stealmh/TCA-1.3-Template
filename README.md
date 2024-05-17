# TCA-1.3-Template

1.0.0 ~ 1.3 버전에서 최적화 된 TCA Template 입니다.

#### 주의사항
```swift
public protocol FeatureAction {
    associatedtype ViewAction
    associatedtype InnerAction
    associatedtype AsyncAction
    associatedtype ScopeAction
    associatedtype DelegateAction
    
    static func view(_: ViewAction) -> Self
    static func inner(_: InnerAction) -> Self
    static func async(_: AsyncAction) -> Self
    static func scope(_: ScopeAction) -> Self
    static func delegate(_: DelegateAction) -> Self
}
```
사용 전 해당 프로토콜을 생성해주어야 합니다.
#### Feature
```swift
import ComposableArchitecture

struct ___VARIABLE_sceneName___Feature: Reducer {
    /// - State
    struct State: Equatable {
    }
    /// - Action
    enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case async(AsyncAction)
        case scope(ScopeAction)
        case delegate(DelegateAction)
        
        enum ViewAction: Equatable { case onAppear }
        enum InnerAction: Equatable { case doNothing }
        enum AsyncAction: Equatable { case doNothing }
        enum ScopeAction: Equatable { case doNothing }
        enum DelegateAction: Equatable { case doNothing }
    }
    /// - if No Child, Can Used
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            /// - View
        case .view(let viewAction):
            return handleViewAction(viewAction, state: &state)
            /// - Inner
        case .inner(let innerAction):
            return handleInnerAction(innerAction, state: &state)
            /// - Async
        case .async(let asyncAction):
            return handleAsyncAction(asyncAction, state: &state)
            /// - Scope
        case .scope(let scopeAction):
            return handleScopeAction(scopeAction, state: &state)
            /// - Delegate
        case .delegate(let delegateAction):
            return handleDelegateAction(delegateAction, state: &state)
        }
    }
    /// - Reducer body
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                /// - View
            case .view(let viewAction):
                return handleViewAction(viewAction, state: &state)
                /// - Inner
            case .inner(let innerAction):
                return handleInnerAction(innerAction, state: &state)
                /// - Async
            case .async(let asyncAction):
                return handleAsyncAction(asyncAction, state: &state)
                /// - Scope
            case .scope(let scopeAction):
                return handleScopeAction(scopeAction, state: &state)
                /// - Delegate
            case .delegate(let delegateAction):
                return handleDelegateAction(delegateAction, state: &state)
            }
        }
    }
}
//MARK: - FeatureAction Effect
private extension ___VARIABLE_sceneName___Feature {
    /// - View Effect
    func handleViewAction(_ action: Action.ViewAction, state: inout State) -> Effect<Action> {
        return .none
    }
    /// - Inner Effect
    func handleInnerAction(_ action: Action.InnerAction, state: inout State) -> Effect<Action> {
        return .none
    }
    /// - Async Effect
    func handleAsyncAction(_ action: Action.AsyncAction, state: inout State) -> Effect<Action> {
        return .none
    }
    /// - Scope Effect
    func handleScopeAction(_ action: Action.ScopeAction, state: inout State) -> Effect<Action> {
        return .none
    }
    /// - Delegate Effect
    func handleDelegateAction(_ action: Action.DelegateAction, state: inout State) -> Effect<Action> {
        return .none
    }
}

```
#### View
- ViewAction만 send할 수 있습니다.
```swift
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
```
