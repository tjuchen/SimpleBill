//
//  SearchBillView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation
import SwiftUI
import CoreData

struct SearchBillView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var searchText = ""
    @State private var searchBillDataModel = Array<BillCellViewModel>()
    @State private var refreshing: Bool = true
    
    var fetchRequest: NSFetchRequest<Bill>
    init() {
        self.fetchRequest = NSFetchRequest<Bill>(entityName:"Bill")
        self.fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Bill.timestamp, ascending: false)]
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .onChange(of: searchText) { newValue in
                    searchBillDataModel = searchBillData(text: searchText)
                }
            List {
                ForEach(searchBillDataModel) { item in
                    BillCellView(model: item, destinationView: AnyView(BillDetailView(refreshing: $refreshing, originModel: item)), delete: deleteBillCell)
                        .listRowSeparator(.visible, edges: .all)
                }
            }
        }
        .navigationBarTitle(Text("搜索"), displayMode: .inline)
        .onAppear {
            searchBillDataModel = searchBillData(text: searchText)
        }
    }
}

extension SearchBillView {
    private func deleteBillCell(model: BillCellViewModel) {
        deleteOneBill(model: model)
        searchBillDataModel = searchBillData(text: searchText)
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
            self.text = searchText
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
