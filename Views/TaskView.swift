import SwiftUI

struct RoadmapItem: Identifiable {
    let id: Int
    let title: String
    let isCompleted: Bool
    let isCurrent: Bool
    let isLocked: Bool
    let hasLevelUpBadge: Bool
}

struct TaskView: View {
    let items: [RoadmapItem] = [
        RoadmapItem(id: 1, title: "İlk işlemini yap", isCompleted: true, isCurrent: false, isLocked: false, hasLevelUpBadge: false),
        RoadmapItem(id: 2, title: "İlk testini tamamla", isCompleted: true, isCurrent: false, isLocked: false, hasLevelUpBadge: true),
        RoadmapItem(id: 3, title: "2 indikatör öğren", isCompleted: false, isCurrent: true, isLocked: false, hasLevelUpBadge: false),
        RoadmapItem(id: 4, title: "3 hissede işlem yap", isCompleted: false, isCurrent: false, isLocked: true, hasLevelUpBadge: false),
        RoadmapItem(id: 5, title: "Chatbotu kullanarak 2 hisseyi analiz et", isCompleted: false, isCurrent: false, isLocked: true, hasLevelUpBadge: true),
        RoadmapItem(id: 6, title: "3 farklı sektörden hisse al", isCompleted: false, isCurrent: false, isLocked: true, hasLevelUpBadge: false)
    ]
    
    let lineHeight: CGFloat = 50
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("ROZET YOLU")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    VStack(spacing: 0) {
                        RoadmapNode(item: item)
                        
                        if item.id == 2 {
                            VStack(spacing: 0) {
                                DashedLine(isLocked: false)
                                    .stroke(style: StrokeStyle(lineWidth: 12, dash: [5, 5]))
                                    .frame(width: 2, height: lineHeight)
                                    .foregroundColor(.green)
                                
                                HStack {
                                    Spacer()
                                    BadgeView()
                                        .frame(width: 50, height: 50)
                                    Spacer()
                                }
                                
                                DashedLine(isLocked: true)
                                    .stroke(style: StrokeStyle(lineWidth: 12, dash: [5, 5]))
                                    .frame(width: 2, height: lineHeight)
                                    .foregroundColor(.gray)
                            }
                        } else if index < items.count - 1 {
                            DashedLine(isLocked: index > 0)
                                .stroke(style: StrokeStyle(lineWidth: 12, dash: [5, 5]))
                                .frame(width: 2, height: lineHeight)
                                .foregroundColor(index == 0 ? .green : .gray)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct RoadmapNode: View {
    let item: RoadmapItem
    
    var nodeColor: Color {
        if item.isCompleted {
            return .green
        } else if item.isCurrent {
            return .yellow
        }
        return .gray
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(item.isLocked ? Color.gray : Color.blue, lineWidth: 2)
                    .background(Circle().fill(nodeColor))
                    .frame(width: 40, height: 40)
                
                ZStack {
                    Text("\(item.id)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }
            }
            
            HStack {
                Text(item.title)
                    .padding(.leading, 8)
                    .foregroundColor(item.isLocked ? .gray : .black)
                
                Spacer()
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}

struct DashedLine: Shape {
    let isLocked: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct BadgeView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow.opacity(0.2))
                .frame(width: 70, height: 70)
                .overlay(
                    Circle()
                        .stroke(Color.yellow, lineWidth: 2)
                )
            
            ZStack {
                HStack(spacing: -2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 15))
                    Spacer()
                        .frame(width: 15)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 20))
                }
                .offset(y: 2)
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 15))
                    .offset(y: -2)
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
