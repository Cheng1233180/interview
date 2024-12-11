import { OptionalComp } from 'mine'

@Entry
@Component
export struct OptionalPage {
  build() {
    Column() {
      OptionalComp()
    }

  }
}