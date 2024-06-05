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
- 사용하지 않는 Action을 명시적으로 표현해 사용하지 않음을 나타낼 수 있습니다.
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
    /// - Reduce core
    private func core(into state: inout State, action: Action) -> Effect<Action> {
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
        Reduce(self.core)
        // .ifLet(...)
        // .forEach(...)
        // ._printChanges()
        // .onChage(...)
        // ...etc
    }
}
//MARK: - FeatureAction Effect
private extension ___VARIABLE_sceneName___Feature {
    /// - View Effect
    func handleViewAction(_ action: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        }
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
#### 활용
binding과 Present 그리고 Stack에서도 활용 가능합니다.

1. binding
```swift
struct State: Equatable {
    @BindingState var text: String = ""
}
```
다음과 같은 BindingState가 있다고 하겠습니다. ViewAction 열거형을 통해 view에서만 작업하도록 설정합니다.
```swift
enum ViewAction: BindableAction, Equatable {
    case onAppear
    case binding(BindingAction<State>)
}
```
이후 Reducer body에 view의 Action을 연결시키면 끝입니다.
```swift
var body: some ReducerOf<Self> {
    BindingReducer(action: /Action.view)
    Reduce(self.core)
}
```
2. Presentation or Stack
```swift
struct Destination: Reducer {
    enum State: Equatable {
        case popup(PopupFeature.State)
    }
    enum Action: Equatable {
        case popup(PopupFeature.Action)
    }
    var body: some ReducerOf<Self> {
        Scope(state: /State.after7dayPopup, action: /Action.popup) {
            DStopDoubleButtonPopupFeature()
        }
    }
}
```
내부에 위치 할 Destination Reducer를 만드는 것 부터 시작합니다.

```swift
struct State: Equatable {
    @PresentationState var destination: Destination.State?
}

struct Action: FeatureAction, Equatable {
    case destination(PresentationAction<Destination.Action>)
}

func handleDestinationAction(
    _ action: PresentationAction<Destination.Action>,
    state: inout State
) -> Effect<Action> {
    switch action {
    case .presented(.popup(.delegate(...))):
        /// do something
        return .none
    case .presented, dismiss: return .none
    }
}
```
```swift
private func core(into state: inout State, action: Action) -> EffectOf<Self> {
    switch action {
        ...
        /// - Destination
    case .destination(let destinationAction):
        return handleDestinationAction(destinationAction, state: &state)
    }
}
```
Action에서의 destination의 Action과 동일하게 연결시켜주면 끝입니다.
```diff
-  .destination(.presented(.popup(...))):
+  .presented(.popup(...))):
```
액션을 잘게 쪼갠 결과 컴파일러가 유추하기 쉬워집니다.




