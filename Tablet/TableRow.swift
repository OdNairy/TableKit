//
//    Copyright (c) 2015 Max Sokolov https://twitter.com/max_sokolov
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public protocol RowConfigurable {

    func configure(cell: UITableViewCell)
}

public protocol RowActionable {

    func invoke(action: TableRowActionType, cell: UITableViewCell?, path: NSIndexPath) -> Any?
}

public protocol Row: RowConfigurable, RowActionable {

    var reusableIdentifier: String { get }
    var estimatedHeight: CGFloat { get }
    var defaultHeight: CGFloat { get }
}

public class TableRow<ItemType, CellType: ConfigurableCell where CellType.T == ItemType, CellType: UITableViewCell>: Row {

    public let item: ItemType
    private var actions = [RowAction]()

    public var reusableIdentifier: String {
        return CellType.reusableIdentifier()
    }
    
    public var estimatedHeight: CGFloat {
        return CellType.estimatedHeight()
    }

    public var defaultHeight: CGFloat {
        return CellType.defaultHeight() ?? UITableViewAutomaticDimension
    }
    
    public init(item: ItemType, actions: [TableRowAction<ItemType, CellType>]? = nil) {
        self.item = item
    }
    
    // MARK: - RowConfigurable -
    
    public func configure(cell: UITableViewCell) {
        (cell as? CellType)?.configure(item)
    }
    
    // MARK: - RowActionable -

    public func invoke(action: TableRowActionType, cell: UITableViewCell?, path: NSIndexPath) -> Any? {
        
        return nil
    }
    
    // MARK: - actions -
    
    public func action(action: TableRowAction<ItemType, CellType>) -> Self {
        
        return self
    }
}