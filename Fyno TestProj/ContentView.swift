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



import SwiftUI
import SwiftData

@Model
final class UserProfile: Identifiable, Codable {
    @Attribute
    var id: UUID
    
    @Attribute
    var image: Data
    
    @Attribute
    var name: String
    
    @Attribute
    var bioInfo: String
    
    @Attribute
    var allCountries: [CountryName]
    
    init(id: UUID = UUID(), image: UIImage, name: String, bioInfo: String, allCountries: [CountryName]) {
        self.id = id
        self.image = image.pngData()!
        self.name = name
        self.bioInfo = bioInfo
        self.allCountries = allCountries
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case name
        case bioInfo = "bio_info"
        case allCountries = "all_countries"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.image = try container.decode(Data.self, forKey: .image)
        self.name = try container.decode(String.self, forKey: .name)
        self.bioInfo = try container.decode(String.self, forKey: .bioInfo)
        self.allCountries = try container.decode([CountryName].self, forKey: .allCountries)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .image)
        try container.encode(name, forKey: .name)
        try container.encode(bioInfo, forKey: .bioInfo)
        try container.encode(allCountries, forKey: .allCountries)
    }
    
    static let testUser = UserProfile(
        image: UIImage(named: "woman_test")!,
        name: "John Doe",
        bioInfo: "Globe-trotter, fearless adventurer, cultural enthusiast, storyteller",
        allCountries: []
    )
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
