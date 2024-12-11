import { FeedbackComp } from 'home'

@Entry
@Component
struct FeedbackPage {


  build() {
    Column(){
      FeedbackComp()
    }
    .height('100%')
    .width('100%')
  }
}