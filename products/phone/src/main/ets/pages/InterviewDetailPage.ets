import { InterviewDetailComp } from 'interview'

@Entry
@Component
struct InterviewDetailPage {
  @StorageProp('bottomHeight')
  bottomHeight: number = 0

  build() {
    Column() {
      InterviewDetailComp()
    }
    .padding({ bottom: this.bottomHeight })
  }
}