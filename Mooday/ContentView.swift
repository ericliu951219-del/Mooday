import SwiftUI

struct MoodRecipe: Identifiable, Equatable {
    let id: String
    let mood: String
    let subtitle: String
    let symbolName: String
    let music: String
    let drink: String
    let activity: String
    let message: String
    let primaryColor: Color
    let secondaryColor: Color

    static let all: [MoodRecipe] = [
        MoodRecipe(
            id: "sunny",
            mood: "晴朗模式",
            subtitle: "今天適合把快樂調大聲",
            symbolName: "sun.max.fill",
            music: "輕快 City Pop",
            drink: "蜂蜜檸檬氣泡水",
            activity: "戴上耳機，到戶外散步 20 分鐘",
            message: "你不必等待好日子，今天就可以是。",
            primaryColor: .orange,
            secondaryColor: .yellow
        ),
        MoodRecipe(
            id: "recharge",
            mood: "安靜充電",
            subtitle: "暫時不用成為很厲害的人",
            symbolName: "moon.stars.fill",
            music: "雨聲與鋼琴",
            drink: "溫熱可可",
            activity: "關閉通知，留 30 分鐘給自己",
            message: "休息不是停下，而是溫柔地繼續。",
            primaryColor: .indigo,
            secondaryColor: .purple
        ),
        MoodRecipe(
            id: "brave",
            mood: "勇氣加滿",
            subtitle: "把猶豫留在昨天",
            symbolName: "flame.fill",
            music: "熱血搖滾",
            drink: "冰美式咖啡",
            activity: "完成一件拖延最久的小事",
            message: "先跨出一小步，勇氣才會跟上來。",
            primaryColor: .red,
            secondaryColor: .orange
        ),
        MoodRecipe(
            id: "inspired",
            mood: "靈感爆發",
            subtitle: "腦袋正在發送神奇訊號",
            symbolName: "lightbulb.fill",
            music: "Lo-fi 電子樂",
            drink: "葡萄柚氣泡飲",
            activity: "用 10 分鐘寫下所有奇怪點子",
            message: "先允許點子很荒謬，精彩才有機會出現。",
            primaryColor: .yellow,
            secondaryColor: .pink
        ),
        MoodRecipe(
            id: "healing",
            mood: "柔軟療癒",
            subtitle: "今天對自己好一點",
            symbolName: "leaf.fill",
            music: "木吉他民謠",
            drink: "熱桂花茶",
            activity: "整理桌面，再點一盞喜歡的燈",
            message: "你已經做得夠多，也值得被好好照顧。",
            primaryColor: .green,
            secondaryColor: .mint
        ),
        MoodRecipe(
            id: "adventure",
            mood: "微型冒險",
            subtitle: "替平凡的一天加一條支線",
            symbolName: "map.fill",
            music: "公路旅行歌單",
            drink: "水果冰茶",
            activity: "走一條沒走過的路，拍下三個新發現",
            message: "不用去很遠，陌生感就是旅程的起點。",
            primaryColor: .cyan,
            secondaryColor: .blue
        ),
        MoodRecipe(
            id: "slow",
            mood: "慢速生活",
            subtitle: "世界很快，你可以慢慢來",
            symbolName: "cloud.fill",
            music: "慵懶爵士",
            drink: "溫牛奶",
            activity: "放下手機，慢慢吃完一份點心",
            message: "把步調放慢，才能聽見生活的細節。",
            primaryColor: .blue,
            secondaryColor: .gray
        )
    ]
}

struct ContentView: View {
    @State private var selectedRecipe: MoodRecipe?
    @State private var isChoosing = false
    @State private var cardRotation = 0.0

    var body: some View {
        ZStack {
            MoodBackground(
                primaryColor: selectedRecipe?.primaryColor ?? Color(red: 0.46, green: 0.32, blue: 0.86),
                secondaryColor: selectedRecipe?.secondaryColor ?? Color(red: 1.00, green: 0.47, blue: 0.58)
            )

            ScrollView {
                VStack(spacing: 22) {
                    header

                    if let selectedRecipe {
                        MoodRecipeCard(recipe: selectedRecipe)
                            .id(selectedRecipe.id)
                            .transition(.scale(scale: 0.9).combined(with: .opacity))
                            .rotation3DEffect(
                                .degrees(cardRotation),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    } else {
                        EmptyMoodCard()
                            .rotation3DEffect(
                                .degrees(cardRotation),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }

                    randomButton
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
            }
            .scrollIndicators(.hidden)
        }
        .animation(.easeInOut(duration: 0.7), value: selectedRecipe)
    }

    private var header: some View {
        VStack(spacing: 10) {
            HStack(spacing: 7) {
                Image(systemName: "sparkles")
                    .font(.title2.weight(.semibold))

                Text("Mooday")
                    .font(.system(.largeTitle, design: .rounded, weight: .heavy))
                    .tracking(-1)
            }

            Text("MOOD + DAY")
                .font(.caption2.weight(.bold))
                .tracking(2.4)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white.opacity(0.16), in: .capsule)

            Text("每天，調一份剛剛好的心情")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.82))
        }
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
        .accessibilityElement(children: .combine)
    }

    private var randomButton: some View {
        Button(action: chooseRecipe) {
            HStack(spacing: 10) {
                Image(systemName: isChoosing ? "sparkles" : "wand.and.stars")
                    .symbolEffect(.bounce, value: isChoosing)

                Text(buttonTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .background(.white, in: .rect(cornerRadius: 18))
            .foregroundStyle(Color(red: 0.13, green: 0.08, blue: 0.22))
            .shadow(color: .black.opacity(0.18), radius: 18, y: 8)
        }
        .buttonStyle(.plain)
        .disabled(isChoosing)
        .accessibilityHint("隨機抽出一份 Mooday 情緒提案，並以圖文顯示")
    }

    private var buttonTitle: LocalizedStringKey {
        if isChoosing {
            "Mooday 調配中…"
        } else if selectedRecipe == nil {
            "抽取今日 Mooday"
        } else {
            "換一種心情"
        }
    }

    private func chooseRecipe() {
        guard !isChoosing else { return }

        isChoosing = true

        withAnimation(.easeIn(duration: 0.22)) {
            cardRotation = 90
        }

        Task {
            try? await Task.sleep(for: .milliseconds(230))

            let choices = MoodRecipe.all.filter { $0 != selectedRecipe }
            selectedRecipe = choices.randomElement() ?? MoodRecipe.all.first
            cardRotation = -90

            withAnimation(.spring(duration: 0.55, bounce: 0.28)) {
                cardRotation = 0
            }

            try? await Task.sleep(for: .milliseconds(350))
            isChoosing = false
        }
    }
}

private struct MoodBackground: View {
    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    primaryColor.opacity(0.92),
                    secondaryColor.opacity(0.72),
                    Color(red: 0.10, green: 0.06, blue: 0.18)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(.white.opacity(0.10))
                .frame(width: 260, height: 260)
                .blur(radius: 2)
                .offset(x: 150, y: -270)

            Circle()
                .fill(secondaryColor.opacity(0.22))
                .frame(width: 320, height: 320)
                .blur(radius: 20)
                .offset(x: -170, y: 330)
        }
        .ignoresSafeArea()
    }
}

private struct EmptyMoodCard: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.46, green: 0.32, blue: 0.86),
                                Color(red: 1.00, green: 0.47, blue: 0.58)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 142, height: 142)

                Image(systemName: "face.smiling.inverse")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
            }
            .accessibilityHidden(true)

            Text("今天，是什麼心情？")
                .font(.title2.bold())

            Text("讓 Mooday 為你搭配今天的音樂、飲料、行動與一句話。")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 370)
        .padding(26)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 30))
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.2), radius: 24, y: 12)
        .accessibilityElement(children: .combine)
    }
}

private struct MoodRecipeCard: View {
    let recipe: MoodRecipe

    var body: some View {
        VStack(spacing: 0) {
            moodArtwork
            recipeDetails
        }
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 30))
        .clipShape(.rect(cornerRadius: 30))
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.22), radius: 26, y: 14)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(recipe.mood)。音樂：\(recipe.music)。飲料：\(recipe.drink)。今日行動：\(recipe.activity)。今日一句：\(recipe.message)"
        )
    }

    private var moodArtwork: some View {
        ZStack {
            LinearGradient(
                colors: [recipe.primaryColor, recipe.secondaryColor],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(.white.opacity(0.16))
                .frame(width: 200, height: 200)

            Circle()
                .stroke(.white.opacity(0.2), lineWidth: 2)
                .frame(width: 238, height: 238)

            Image(systemName: recipe.symbolName)
                .font(.system(size: 92, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.15), radius: 10, y: 6)
        }
        .frame(height: 245)
        .frame(maxWidth: .infinity)
        .accessibilityHidden(true)
    }

    private var recipeDetails: some View {
        VStack(alignment: .leading, spacing: 17) {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.mood)
                    .font(.largeTitle.bold())

                Text(recipe.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            RecipeInfoRow(
                icon: "music.note",
                title: "今日音樂",
                content: recipe.music,
                color: recipe.primaryColor
            )

            RecipeInfoRow(
                icon: "cup.and.saucer.fill",
                title: "今日飲料",
                content: recipe.drink,
                color: recipe.primaryColor
            )

            RecipeInfoRow(
                icon: "figure.walk",
                title: "今日行動",
                content: recipe.activity,
                color: recipe.primaryColor
            )

            Text("「\(recipe.message)」")
                .font(.headline)
                .italic()
                .foregroundStyle(recipe.primaryColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(recipe.primaryColor.opacity(0.12), in: .rect(cornerRadius: 16))
        }
        .padding(22)
        .foregroundStyle(.primary)
    }
}

private struct RecipeInfoRow: View {
    let icon: String
    let title: LocalizedStringKey
    let content: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.headline)
                .frame(width: 38, height: 38)
                .background(color.opacity(0.16), in: .circle)
                .foregroundStyle(color)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)

                Text(content)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#Preview {
    ContentView()
}
