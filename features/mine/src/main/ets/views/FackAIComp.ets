import { HdNav } from "basic"

@Component
export struct FackAIComp {
  build() {
    Column() {
      HdNav({ title: '面通AI', showRightIcon: false })
      Text("FackAI")
    }
    .width('100%')
    .height('100%')
  }
}