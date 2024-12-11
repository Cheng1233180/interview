import { ClockedComp } from "mine"

@Entry
@Component
export struct ClockedPage {
  build() {
    Column() {
      ClockedComp()
    }

  }
}