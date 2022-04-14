//
//  ContentView.swift
//  Shared
//
//  Created by Jimmy Mendez on 4/13/22.
//

import SwiftUI


var cards = ["1","1","1","1","1","2","2","2","2","3","3","3","3","4","4","4","4","5","5","5","5","7","7","7","7","8","8","8","8","10","10","10","10","11","11","11","11","12","12","12","12","sorry","sorry","sorry","sorry"]

var num = 0
var card_string = "card_" + cards[0]

func shuffleCards () {
    cards = ["1","1","1","1","1","2","2","2","2","3","3","3","3","4","4","4","4","5","5","5","5","7","7","7","7","8","8","8","8","10","10","10","10","11","11","11","11","12","12","12","12","sorry","sorry","sorry","sorry"]
    cards.shuffle()
    card_string = "card_" + cards[0]
    num = 0
}

struct ContentView: View {
    //MARK: Variables
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    @State var showingPopup = false // 1
    
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    //MARK: Flip Card Function
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    //MARK: View Body
    var body: some View {
        ZStack {
            CardFront(width: width, height: height, degree: $frontDegree)
            CardBack(width: width, height: height, degree: $backDegree)
        }.onTapGesture {
            flipCard ()
        }
        Button(action: {
            if cards.count == 1{
                withAnimation{
                    showingPopup = true
                            }
            }
            else{
                cards.remove(at: 0)
                card_string = "card_" + cards[0]
                flipCard()
                flipCard()
            }
        }) {
            Text("Deal New Card")
        }
        Button(action: {
            shuffleCards()
            flipCard()
            flipCard()
        }) {
            Text("Shuffle Cards")
        }
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
