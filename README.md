Mooday ✨

> 每天，調一份剛剛好的心情。

Mooday 是使用 SwiftUI 製作的隨機心情 App，名稱結合 Mood（心情）與 Day（一天）。透過隨機抽取，為使用者搭配音樂、飲料、活動與一句鼓勵的話，替日常增加一點靈感。

## 功能特色

- 七種心情配方：晴朗模式、安靜充電、勇氣加滿、靈感爆發、柔軟療癒、微型冒險與慢速生活。
- 用系統圖示與文字呈現心情、音樂、飲料、活動及鼓勵語句。
- 避免連續抽到相同配方。
- 配方專屬漸層配色與卡片翻轉動畫。
- 支援捲動閱讀與 VoiceOver 輔助使用標籤。

## 使用方式

1. 開啟 App，點選「抽取今日 Mooday」。
2. 等待翻牌動畫，查看抽中的心情配方。
3. 點選「換一種心情」，再次隨機抽取。

## 程式重點

### 資料結構

使用 `struct MoodRecipe` 定義配方，包含名稱、圖示、音樂、飲料、活動、鼓勵文字與顏色，並將七筆資料儲存在 `[MoodRecipe]` 陣列中。

### 隨機抽取

```swift
let choices = MoodRecipe.all.filter {
    $0 != selectedRecipe
}
selectedRecipe = choices.randomElement() ?? MoodRecipe.all.first
```

先使用 `filter` 排除目前結果，再透過 `randomElement()` 抽取，避免連續重複。`??` 提供未取得結果時的備用值。

### 狀態管理與動畫

```swift
@State private var selectedRecipe: MoodRecipe?
@State private var isChoosing = false
@State private var cardRotation = 0.0
```

三個狀態分別管理抽取結果、抽取中的操作限制與卡片旋轉角度。搭配 `withAnimation`、`rotation3DEffect` 與非同步等待，呈現翻牌效果；抽取期間暫時停用按鈕，避免重複觸發。

## 專案結構

```text
Mooday/
├── Mooday.xcodeproj/       # Xcode 專案設定
└── Mooday/
    ├── MyApp.swift         # App 進入點
    ├── ContentView.swift   # 配方資料、主要畫面與抽取邏輯
    └── Assets.xcassets/    # 資源目錄
```

## 開啟專案

1. 使用 Xcode 開啟 `Mooday.xcodeproj`。
2. 選擇 `Mooday` Scheme 與執行裝置。
3. 按下 Run（⌘R）執行。

目前專案設定的 iOS 最低部署版本為 27.0，執行時需具備相容的 Xcode 與 SDK；若使用其他環境，請先確認部署設定。

## 目前限制與未來規劃

目前音樂為文字建議，沒有播放功能；抽取結果也不會永久儲存。未來可加入收藏、歷史紀錄、卡片分享與音樂連結。
