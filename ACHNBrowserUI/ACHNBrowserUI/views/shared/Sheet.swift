//
//  Sheet.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 08/05/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Backend

struct Sheet: View {
    enum SheetType: Identifiable {
        case safari(URL), share(content: [Any])
        case about
        case rearrange(viewModel: DashboardViewModel)
        case userListForm(editingList: UserList?)
        case turnipsForm(subManager: SubscriptionManager)
        case subscription(source: SubscribeView.Source, subManager: SubscriptionManager)
        case settings(subManager: SubscriptionManager, collection: UserCollection)
        case designForm(editingDesign: Design?)
        case choreForm(chore: Chore?)

        var id: String {
            switch self {
            case .safari(let url):
                return url.absoluteString
            case .share:
                return "share"
            case .about:
                return "about"
            case .rearrange:
                return "rearrange"
            case .settings:
                return "about"
            case .turnipsForm:
                return "turnipsForm"
            case .subscription:
                return "sub"
            case .userListForm:
                return "userListForm"
            case .designForm:
                return "designForm"
            case .choreForm:
                return "choreForm"
            }
        }
    }
    
    let sheetType: SheetType
    
    private func make() -> some View {
        switch sheetType {
        case .safari(let url):
            return AnyView(SafariView(url: url))
        case .share(let content):
            return AnyView(ActivityControllerView(activityItems: content,
                                                  applicationActivities: nil))
        case .about:
            return AnyView(AboutView())
        case .settings(let subManager, let collection):
            return AnyView(SettingsView()
                .environmentObject(subManager)
                .environmentObject(collection))
        case .turnipsForm(let subManager):
            return AnyView(NavigationView {
                TurnipsFormView().environmentObject(subManager)
            }.navigationViewStyle(StackNavigationViewStyle()))
        case .subscription(let source, let subManager):
            return AnyView(SubscribeView(source: source).environmentObject(subManager))
        case .userListForm(let list):
            return AnyView(UserListFormView(editingList: list))
        case .designForm(let design):
            let viewModel = DesignFormViewModel(design: design)
            return AnyView(DesignFormView(viewModel: viewModel))
        case .rearrange(let viewModel):
            return AnyView(NavigationView {
                TodaySectionEditView(viewModel: viewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle()))
        case .choreForm(let chore):
            let viewModel = ChoreFormViewModel(chore: chore)
            return AnyView(ChoreFormView(viewModel: viewModel))
        }
    }

    var body: some View {
        make()
    }
}
