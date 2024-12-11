import { authStore, themeManager } from "basic"
import { BootView } from "home"

@Entry
@Component
export struct BootPage {

  aboutToAppear(): void {
    themeManager.initThemeSetting()
    themeManager.enableFullScreen()
    authStore.initUser()

    getContext().getApplicationContext().getRunningProcessInformation()
  }
  build() {
    Column() {
      BootView()
    }

  }
}