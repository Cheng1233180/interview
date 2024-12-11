import { WordComp } from "mine"

@Entry
@Component
export struct WordPage {
  build() {
    Column() {
      WordComp()
    }
    .width('100%')
    .height('100%')
  }
}