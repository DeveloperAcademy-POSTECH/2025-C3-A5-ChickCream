//
//  DietListView.swift
//  HeeBob
//
//  Created by 임영택 on 5/30/25.
//

import SwiftUI

struct DietListView: View {
    @State var dietList = [Diet]()
    @State var selectedDiet: Diet?
    @State var showSheet: Bool = false
    
    var body: some View {
        List {
            ForEach(dietList) { diet in
                Button {
                    dietDidSelect(diet)
                } label: {
                    Text(diet.title)
                }
            }
        }
        .onAppear() {
            viewDidAppear()
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                Text(selectedDiet?.title ?? "N/A")
                
                if let selectedDiet = selectedDiet,
                   let imageData = getDietImageData(for: selectedDiet),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "questionmark.app.dashed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
            }
        }
    }
}

extension DietListView {
    private func viewDidAppear() {
        loadDietList()
    }
    
    private func dietDidSelect(_ diet: Diet) {
        print("\(diet.id) \(diet.title) selected")
        selectedDiet = diet
        showSheet.toggle()
    }
    
    private func loadDietList() {
        guard let rawDataPath = Bundle.main.url(forResource: "example", withExtension: "json") else {
            fatalError("로우데이터를 찾을 수 없습니다")
        }
        
        do {
            let rawData = try Data(contentsOf: rawDataPath)
            let serializer = JSONDecoder()
            dietList = try serializer.decode([Diet].self, from: rawData).sorted { $0.title < $1.title }
        } catch {
            print("error: \(error)")
        }
    }
    
    private func getDietImageData(for diet: Diet) -> Data? {
        guard let url = Bundle.main.url(forResource: diet.id.uuidString.lowercased(), withExtension: "jpg") else {
            print("cannot find image file \(diet.id.uuidString.lowercased()).jpg")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            print(data)
            return data
        } catch {
            print("error: \(error)")
            return nil
        }
    }
}

#Preview {
    DietListView()
}
