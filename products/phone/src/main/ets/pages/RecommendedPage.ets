import { RecommendedComp } from "mine"
@Entry
@Component
export struct RecommendedPage {
  build() {
    Column() {
      RecommendedComp()
    }
    .width('100%')
    .height('100%')
  }
}