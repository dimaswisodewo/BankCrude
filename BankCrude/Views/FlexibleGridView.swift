//
//  FlexibleGridView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// A reusable grid component that arranges items in a standard multi-column layout.
/// Following SOLID principles, it decouples layout configuration from the content of the items.
public struct FlexibleGridView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    private let data: Data
    private let columnsCount: Int
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    private let content: (Data.Element) -> Content
    
    /// Initializes a new FlexibleGridView.
    /// - Parameters:
    ///   - data: The collection of data items to arrange in the grid.
    ///   - columnsCount: The number of columns in the grid.
    ///   - horizontalSpacing: Horizontal spacing between columns. Defaults to 16.
    ///   - verticalSpacing: Vertical spacing between rows. Defaults to 16.
    ///   - content: A ViewBuilder closure that receives a data item and returns its corresponding view.
    public init(
        _ data: Data,
        columnsCount: Int = 4,
        horizontalSpacing: CGFloat = 16,
        verticalSpacing: CGFloat = 16,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.columnsCount = columnsCount
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content
    }
    
    public var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: horizontalSpacing),
                count: columnsCount
            ),
            spacing: verticalSpacing
        ) {
            ForEach(data) { item in
                content(item)
            }
        }
    }
}
