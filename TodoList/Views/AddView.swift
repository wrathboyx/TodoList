//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Bayu Faqih on 27/05/23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var textFieldText: String = ""
    
    // Dark Mode Textfield
    let colors = Color(UIColor.secondarySystemBackground)
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here ..", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(colors)
                    .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(10)
        }
        .navigationTitle("Add an Item 🖋️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    // MARK: FUNCTION SAVEBUTTON
    func saveButtonPressed() {
        
        if textIsAppropriate() {
            listViewModel.addItems(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // MARK: FUNCTION LOGIC
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your need todo item must be at least 3 characters 😋"
            showAlert.toggle()
            return false
        }
        
        return true
    }
    
    // MARK: FUNCTION ALERT
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
            
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
        }
        
    }
}
