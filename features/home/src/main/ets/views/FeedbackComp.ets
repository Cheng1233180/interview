import { HdNav } from "basic"

@Component
export struct FeedbackComp {
  build() {
    Column() {
      HdNav({ title: '意见反馈', showRightIcon: false })
      Text("FeedbackComp")
    }
    .width('100%')
    .height('100%')
  }
}