//
//  ContentView.swift
//  Shared
//
//  Created by Jimmy Mendez on 4/13/22.
//

import SwiftUI


let cards_init = ["1","1","1","1","1","2","2","2","2","3","3","3","3","4","4","4","4","5","5","5","5","7","7","7","7","8","8","8","8","10","10","10","10","11","11","11","11","12","12","12","12","sorry","sorry","sorry","sorry"]

var cards = cards_init

var num = 0
var card_string = "card_" + cards[0]

func shuffleCards () {
    cards = cards_init
    cards.shuffle()
    card_string = "card_" + cards[0]
    num = 0
}

struct ContentView: View {
    //MARK: Variables
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = true
    @State var showingPopup = false // 1
    @State var isFlipped2 = true
    @State var count = 0
    
    
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    //MARK: Flip Card Function
    func flipCard () {
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
            isFlipped=false
        }else{
            isFlipped2 = !isFlipped2
            if !isFlipped2 {
                withAnimation{
                    frontDegree = 0
                }
            }
            else{
                withAnimation{
                    frontDegree = -360
                }
            }
        }
    }
    func resetCards () {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 0
            }
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
            frontDegree = 0
        }
        count = 0
    }
    //MARK: View Body
    var body: some View {
        ZStack {
            CardFront(width: width, height: height, degree: $frontDegree)
            CardBack(width: width, height: height, degree: $backDegree)
        }.onAppear { shuffleCards() }.onTapGesture {
            if count != 0{
                if cards.count == 1{
                    withAnimation{
                        showingPopup = true
                                }
                }
                else{
                    cards.remove(at: 0)
                    card_string = "card_" + cards[0]
                    flipCard()
                }
            }
            else{
                flipCard()
                count = 1
            }
        }
        Button(action: {
            isFlipped=true
            shuffleCards()
            resetCards()
        }) {
            Text("Shuffle Cards")
        }.foregroundColor(.white).padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .clipShape(Capsule())
        if $showingPopup.wrappedValue {
            ZStack {
                VStack {
                    Text("No cards left. Please shuffle deck")
                    Spacer()
                    Button(action: {
                        self.showingPopup = false
                    }, label: {
                        Text("Close")
                    })
                }.padding()
            }
            .frame(width: 300, height: 200)
            .cornerRadius(20).shadow(radius: 20)
        }
    }
}

struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View {
        Image(card_string)
                    .resizable()
                    .scaledToFit().rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View {
        Image("back")
                    .resizable()
                    .scaledToFit().rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
