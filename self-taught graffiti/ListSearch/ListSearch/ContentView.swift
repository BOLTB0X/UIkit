//
//  ContentView.swift
//  ListSearch
//
//  Created by KyungHeon Lee on 2023/02/13.
//

import SwiftUI

// data model
struct SomeView: View {
  var name: String
  
  var body: some View {
    Text(name)
  }
}

struct SomeData: Identifiable {
  var name: String
  var id: String {
      self.name
      
  }
}

struct ContentView: View {
    @State var searchQueryString = ""
    var datas = (0...100).map(String.init).map(SomeData.init)
    
    var filteredDatas: [SomeData] {
        if searchQueryString.isEmpty {
            return datas
        } else {
            return datas.filter { $0.name.localizedStandardContains(searchQueryString)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredDatas) { data in
                NavigationLink {
                    SomeView(name: data.name)
                } label: {
                    Text(data.name)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Search Test")
        }
        .searchable(
            text: $searchQueryString,
            placement: .navigationBarDrawer,
            prompt: "검색"
        )
//        .onSubmit(of: .search) {
//          print("검색 완료: \(searchQueryString)")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
