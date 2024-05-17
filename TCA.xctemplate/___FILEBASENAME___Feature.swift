//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.

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
