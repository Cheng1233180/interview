import { HdNav } from "basic"

@Component
export struct RecommendedComp {
  build() {
    Column() {
      HdNav({ title: '推荐分享', showRightIcon: false })
      Text("RecommendedComp")
    }
    .width('100%')
    .height('100%')
  }
}