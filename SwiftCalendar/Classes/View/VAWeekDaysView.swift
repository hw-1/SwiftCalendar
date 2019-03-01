import UIKit

public enum VAWeekDaysSymbolsType {
    case short, veryShort ,veryShortStand
    
    func names(from calendar: Calendar) -> [String] {
        switch self {
        case .short:
            return calendar.shortWeekdaySymbols
        case .veryShort:
            return calendar.veryShortWeekdaySymbols
        case .veryShortStand:
            return calendar.shortStandaloneWeekdaySymbols
        }
    }
    
}

public struct VAWeekDaysViewAppearance {
    
    let symbolsType: VAWeekDaysSymbolsType
    let weekDayTextColor: UIColor
    let weekDayTextFont: UIFont
    let leftInset: CGFloat
    let rightInset: CGFloat
    let separatorBackgroundColor: UIColor
    let calendar: Calendar
    
    public init(
        symbolsType: VAWeekDaysSymbolsType = .veryShort,
        weekDayTextColor: UIColor = .black,
        weekDayTextFont: UIFont = UIFont.systemFont(ofSize: 15),
        leftInset: CGFloat = 10.0,
        rightInset: CGFloat = 10.0,
        separatorBackgroundColor: UIColor = .lightGray,
        calendar: Calendar = Calendar.current) {
        self.symbolsType = symbolsType
        self.weekDayTextColor = weekDayTextColor
        self.weekDayTextFont = weekDayTextFont
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.separatorBackgroundColor = separatorBackgroundColor
        self.calendar = calendar
    }
    
}

public class VAWeekDaysView: UIView {
    
    public var appearance = VAWeekDaysViewAppearance() {
        didSet {
            setupView()
        }
    }
    
    private let separatorView = UIView()
    private var dayLabels = [UILabel]()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = frame.width - (appearance.leftInset + appearance.rightInset)
        let dayWidth = width / CGFloat(dayLabels.count)
        
        dayLabels.enumerated().forEach { index, label in
            let x = index == 0 ? appearance.leftInset : dayLabels[index - 1].frame.maxX

            label.frame = CGRect(
                x: x,
                y: 0,
                width: dayWidth,
                height: self.frame.height
            )
        }
        
        let separatorHeight = 1 / UIScreen.main.scale
        let separatorY = frame.height - separatorHeight
        separatorView.frame = CGRect(
            x: appearance.leftInset,
            y: separatorY,
            width: width,
            height: separatorHeight
        )
    }
    
    private func setupView() {
        subviews.forEach { $0.removeFromSuperview() }
        dayLabels = []
        
        let names = getWeekdayNames()
        names.enumerated().forEach { index, name in
            let label = UILabel()
            label.text = name
            label.textAlignment = .center
            label.font = appearance.weekDayTextFont
            label.textColor = appearance.weekDayTextColor
            dayLabels.append(label)
            addSubview(label)
        }
        
        separatorView.backgroundColor = appearance.separatorBackgroundColor
        addSubview(separatorView)
        layoutSubviews()
    }
    
    private func getWeekdayNames() -> [String] {
        let symbols = appearance.symbolsType.names(from: appearance.calendar)
        
        var _symbols:[String] =  []
        symbols.enumerated().forEach { _, name  in
            let shortName = String(name.suffix(1))
            _symbols.append(shortName)
        }
            
        if appearance.calendar.firstWeekday == 1 {
            return _symbols
        } else {
            let allDaysWihoutFirst = Array(_symbols[appearance.calendar.firstWeekday - 1..<_symbols.count])
            return allDaysWihoutFirst + _symbols[0..<appearance.calendar.firstWeekday - 1]
        }
    }
    
}
