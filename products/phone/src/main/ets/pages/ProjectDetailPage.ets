import { ProjectDetailComp } from "project"
import { themeManager } from "../common/manager"

@Entry
@Component
export struct ProjectDetailPage {


  onPageShow(): void {
    themeManager.settingStatusBarWhite()
  }
  onPageHide(): void {
    themeManager.settingStatusBarBlack()
  }

  build() {
    Column() {
      ProjectDetailComp()

    }

  }
}