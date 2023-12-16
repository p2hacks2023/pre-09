//
//  ContentView.swift
//  FanReacter
//
//  Created by 古賀耀 on 2023/12/12.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var isActive: Bool = false
    @State var message = "電源を入れてみて"
    let audioEngine = AVAudioEngine()
    var body: some View {
        ZStack{
            Color.cyan
                .ignoresSafeArea()
            
            VStack {
                Image("Fan")
                    .resizable()
                    .padding(0.0)
                    .frame(width: 300.0, height: 300.0)
                    .imageScale(.medium)
                    .foregroundStyle(.tint)
                    .rotationEffect(.degrees(isActive ? 0 : 360))
                    .animation(
                        .linear(duration: 0.2).repeat(while: isActive, autoreverses: false),
                        value: isActive
                    )
                Text(message)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("電源")
                    .foregroundColor(Color.white)
                    .padding(.top, 100.0)
                Toggle(isOn: $isActive) {
                    
                }
                .labelsHidden()
            }
            .onChange(of: isActive)
            {
                newValue in
                message = isActive ? "マイクに向かって声を出してみて" : "電源を入れてみて"
                react()
            }
            .padding()
        }
    }//bodyここまで
    func react()
    {
        if isActive
        {
            let delay = AVAudioUnitDelay()
            delay.delayTime = 0.05
            audioEngine.attach(delay)
            
            let ＿format = audioEngine.inputNode.outputFormat(forBus: 0)
            audioEngine.mainMixerNode.outputVolume = 10.0
            
            //エコーバージョン
            //            audioEngine.connect(audioEngine.inputNode, to: delay, format: ＿format)
            //            audioEngine.connect(delay, to: audioEngine.mainMixerNode, format: ＿format)
            //エコーバージョンここまで
            
            //ノーマルバージョン
            audioEngine.connect(audioEngine.inputNode, to: audioEngine.mainMixerNode, format:audioEngine.inputNode.outputFormat(forBus: 0))
            //ノーマルバージョンここまで
            do {
                try audioEngine.start()
            } catch {
                print("cannot start audioEngine")
                print(error)
            }
        }
        else
        {
            if audioEngine.isRunning {
                audioEngine.stop()
                audioEngine.inputNode.removeTap(onBus: 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
