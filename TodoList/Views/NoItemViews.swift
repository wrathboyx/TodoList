//
//  NoItemViews.swift
//  TodoList
//
//  Created by Bayu Faqih on 28/05/23.
//

import SwiftUI

struct NoItemViews: View {
    
    @State var animate: Bool = false
    let secondAccColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ScrollView {
            VStack (spacing: 10){
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .padding(.bottom, 20)
                
                NavigationLink(destination: AddView(), label: {
                    Text("Add something? 🤔")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondAccColor : Color.accentColor)
                        .cornerRadius(10)
                })
                // Animate Button
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: animate ? secondAccColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 40 : 20)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            // Landscape size
            .frame(maxWidth: 400)
            // Text Decoration
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: FUNCTION ANIMATE BUTTON
    func addAnimation() {
        guard !animate else { return }
        // Animasi bekerja ketika view dibuka pertama kali selama 1.5 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    // Durasi Animasi
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoItemViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemViews()
                .navigationTitle("Title")
        }
    }
}
