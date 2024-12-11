// import { LoginComp } from "mine"
// import { PrivacySettings, PRIVACY_SETTINGS } from "../common/constants/PrivacySettings"
// import { LockPage } from "./Privacy/Auth/AuthPatternLockPage"
// import { SettingsPage } from "./Privacy/Auth/AuthPatternLockSettingsPage"
// import { AlertDialog } from "@ohos.arkui.advanced.Dialog"
//
// @Entry
// @Component
// export struct LoginPage {
//
//   @StorageLink(PRIVACY_SETTINGS)
//   @Watch('onPrivacySettingsChange')
//   privacySettings: PrivacySettings = {}
//
//   aboutToAppear(): void {
//     this.togglePrivacyEntry()
//   }
//
//   onPrivacySettingsChange(){
//     this.togglePrivacyEntry()
//   }
//   togglePrivacyEntry(){
//
//   }
//   @Builder
//   TabItemBuilder(q: opq, index: number) {
//     Row() {
//       Stack({ alignContent: Alignment.Bottom }) {
//         Text(q.name)
//           .fontSize(15)
//           .height(43)
//           .fontColor(q.id===this.activeInex? "#ff0053fd" : "#fffa0000")
//       }
//       .padding({ left: index === 0 ? 16 : 0, })
//     }
//     .onClick(()=>{
//       this.activeInex=q.id
//     })
//   }
//   @State
//   activeInex:number=1
//   @State
//   question:opq[]=[
//     {
//       id:1,
//       name:'账号密码登录',
//     },
//     {
//       id:2,
//       name:'第三方登录',
//    },
//     {
//       id: 3,
//       name: '扫码登录',
//     }
//   ]
//
//   build() {
//     Scroll() {
//       Column(){
//         Tabs({index:this.activeInex}){
//           ForEach(this.question,(item:opq,index:number)=>{
//             TabContent(){
//               if (index === 1) {
//                 LoginComp()
//               }else if (index === 2) {
//                 if (this.privacySettings.patternPassword) {
//                   LockPage()
//                 }else {
//                   SettingsPage()
//                 }
//               }
//               else if (index === 3) {
//                 //扫码登录
//
//               }
//             }
//             .tabBar(this.TabItemBuilder(item,index))
//           })
//         }
//         .scrollable(false)
//       }
//     }
//   }
// }
//
//
// export interface opq{
//   id:number
//   name:string
//   itemClick?:() => void
// }


import { LoginComp } from 'mine'
import { PrivacySettings, PRIVACY_SETTINGS } from '../common/constants/PrivacySettings'
import { LockPage } from './Privacy/Auth/AuthPatternLockPage'
import { SettingsPage } from './Privacy/Auth/AuthPatternLockSettingsPage'


@Entry
@Component
struct LoginPage {

  @Provide("flag")
  flag: boolean=true

    @StorageLink(PRIVACY_SETTINGS)
    // @Watch('onPrivacySettingsChange')
    privacySettings: PrivacySettings = {}



  build() {
    Column() {
      if (this.flag){
        LoginComp()
      }else {
        if (this.privacySettings.patternPassword) {
          LockPage()
        }else {
          SettingsPage()
        }
      }
    }
  }
}
