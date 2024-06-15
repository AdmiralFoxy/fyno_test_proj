//
//  ContentView.swift
//  Fyno TestProj
//
//  Created by Stanislav Avramenko on 12.06.2024.
//

import SwiftUI
import SwiftData
import CoreLocation
import MapKit


struct FontWithLineHeight: ViewModifier {
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize, weight: fontWeight))
            .lineSpacing(lineHeight - fontSize)
            .padding(.vertical, (lineHeight - fontSize) / 2)
    }
}

extension View {
    func fontWithLineHeight(fontSize: CGFloat, fontWeight: Font.Weight, lineHeight: CGFloat) -> some View {
        self.modifier(FontWithLineHeight(fontSize: fontSize, fontWeight: fontWeight, lineHeight: lineHeight))
    }
}








//struct GlobeView_Previews: PreviewProvider {
//    static var previews: some View {
//        GlobeView()
//    }
//}

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//#if os(macOS)
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//#endif
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    .onDelete(perform: deleteItems)
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
