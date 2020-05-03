//
//  TurnipsChartView.swift
//  ACHNBrowserUI
//
//  Created by Renaud JENNY on 02/05/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Backend

struct TurnipsChartView: View {
    typealias PredictionCurve = TurnipsChart.PredictionCurve
    static let verticalLinesCount: CGFloat = 9
    var predictions: TurnipPredictions
    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                TurnipsChartLegendView(predictions: predictions)
                    .frame(maxWidth: 40) // FIXME: should use something more dynamic
                ZStack {
                    TurnipsChartGrid(predictions: predictions)
                        .stroke()
                        .opacity(0.5)
                    TurnipsChartAverageCurve(predictions: predictions)
                        .stroke(lineWidth: 2)
                        .foregroundColor(PredictionCurve.average.color)
                    TurnipsChartMinBuyPriceCurve(predictions: predictions)
                        .stroke(style: StrokeStyle(dash: [Self.verticalLinesCount]))
                        .foregroundColor(PredictionCurve.minBuyPrice.color)
                    TurnipsChartMinMaxCurves(predictions: predictions)
                        .foregroundColor(PredictionCurve.minMax.color)
                        .opacity(0.25)
                }
            }
            .padding()
            .background(Color.dialogue)
            .navigationBarItems(trailing: closeButton)
            .navigationBarTitle("Turnips chart for the week", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    private var closeButton: some View {
        Button(action: { self.presentation.wrappedValue.dismiss() }) {
            Text("Close")
        }
    }
}

struct TurnipsChartView_Previews: PreviewProvider {
    static var previews: some View {
        TurnipsChartView(predictions: TurnipPredictions(
            minBuyPrice: 83,
            averagePrices: averagePrices,
            minMax: minMax)
        ).padding()
    }

    static let averagePrices = [89, 85, 88, 104, 110, 111, 111, 111, 106, 98, 82, 77]

    static let minMax = [[38, 142], [33, 142], [29, 202], [24, 602], [19, 602], [14, 602], [9, 602], [29, 602], [24, 602], [19, 602], [14, 202], [9, 201]]
}
