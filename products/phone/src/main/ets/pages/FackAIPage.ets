import { FackAIComp } from "mine"
@Entry
@Component
export struct FackAIPage {
  build() {
    Column() {

      FackAIComp()
    }
    .width('100%')
    .height('100%')
  }
}