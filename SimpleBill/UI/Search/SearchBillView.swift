//
//  SearchBillView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation
import SwiftUI

struct SearchBillView: View {
    @State private var searchText = ""
    @State private var searchBillDataModel = Array<BillCellViewModel>()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List(searchBillDataModel) {
                BillCellView(model: $0, modify: modifyBillCell, delete: deleteBillCell)
                    .listRowSeparator(.visible, edges: .all)
            }
        }
        .navigationBarTitle(Text("搜索"), displayMode: .inline)
        .onAppear {
            searchBillDataModel = searchBillData()
        }
    }
}

extension SearchBillView {
    private func deleteBillCell(model: BillCellViewModel) {
        searchBillDataModel.remove(at: model.index)
        searchBillDataModel = searchBillData()
    }
    
    private func modifyBillCell(model: BillCellViewModel) {
        
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "搜索账单"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
