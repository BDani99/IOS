//
//  CounterView.swift
//  Intern
//
//  Created by Zoltan Vinkler on 23/05/2023.
//

import SwiftUI

struct CounterView: View {
    @State var count = 0
    var body: some View {
        VStack {
            Text("Counter: " + String(count))
                .font(.largeTitle)
                .padding(.bottom, 10.0)
            HStack{
                
                Button(action: {
                    count += 1
    
                }){
                    if count != 100{ Image(systemName: "plus.circle")
                            .padding(.all,20)
                            .background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                    }else{
                        Image(systemName: "plus.circle").padding(.all, 20).background(Color.gray).foregroundColor(Color.white).cornerRadius(10)                    }
                    
                }
                
                .disabled(count == 100)
                
                Button(action: {
                    count -= 1
                }){
                    if count != 0{
                        Image(systemName: "minus.circle").padding(.all, 20).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                    }else{
                        Image(systemName: "minus.circle").padding(.all, 20).background(Color.gray).foregroundColor(Color.white).cornerRadius(10)                    }
                }
                
                .disabled(count == 0)
                
            }
            
            }
    }
}
            
struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
