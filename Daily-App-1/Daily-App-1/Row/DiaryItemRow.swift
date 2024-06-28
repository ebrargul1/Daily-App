import SwiftUI

struct DiaryItemRow: View {
    var item: Item
    var itemFormatter: DateFormatter
    var dateBackgroundColor: Color
    
    var body: some View {
        HStack {
            Text("\(item.timestamp!, formatter: itemFormatter)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(dateBackgroundColor)
                .padding(8)
                .background(dateBackgroundColor.opacity(0.2))
            Text(item.emoji ?? "").font(.headline)
            
            VStack(alignment: .leading) {
                Text(item.title ?? "").foregroundColor(.primary).font(.subheadline).bold()
                Text(item.detail ?? "").font(.subheadline).multilineTextAlignment(.leading).lineLimit(2)
            }
            Spacer()
            
          /*  if let firstImage = item.imageArray?.first?.imageContent, let uiImage = UIImage(data: firstImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 36, height: 36, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }*/
            
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(Color(UIColor.systemGray3))
                .padding(8)
        }
        .padding(4)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(8)
    }
}

struct RoundedCorners: Shape {
    var color: Color
    var topLeft: CGFloat
    var topRight: CGFloat
    var bottomLeft: CGFloat
    var bottomRight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height
        
        // Start at top left corner
        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(center: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(center: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(center: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)

        return path
    }
    
    func fill<S>(_ content: S) -> some View where S : ShapeStyle {
        self.fill(color)
    }
    
}
