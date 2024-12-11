import { AboutMyComp } from "mine"
@Entry
@Component
export struct AboutMyPage {

  build() {
    Column() {
      AboutMyComp()
    }
    .width('100%')
    .height('100%')
  }
}