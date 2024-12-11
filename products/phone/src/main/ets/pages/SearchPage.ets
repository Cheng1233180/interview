import { SearchComp } from 'home'

@Entry
@Component
export struct SearchPage {
  build() {
    Column() {
      SearchComp()
    }

  }
}