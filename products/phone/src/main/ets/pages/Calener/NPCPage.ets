import { abilityAccessCtrl, bundleManager, common } from '@kit.AbilityKit';


@Entry
@Component
struct NPCPage {
  @State message: string = 'Hello World';

  checkMicroPhonePermission(){

    const  manager=abilityAccessCtrl.createAtManager()

    const bundleInfo=bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)

    const status=manager.checkAccessTokenSync(bundleInfo.appInfo.accessTokenId,"ohos.permission.MICROPHONE")

    if (status === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
      (getContext() as common.UIAbilityContext).startAbility({
        bundleName: "com.huawei.hmos.settings",
        abilityName: "com.huawei.hmos.settings.MainAbility",
        uri: "application_info_entry",
        parameters:{
          pushParams:bundleInfo.name
        }
      })
    }else {
      AlertDialog.show({
        message : "权限申请成功！"
      })
    }

  }
  // releaseFinger(){
  //   // this.showVoiceCom=false
  //
  //   AudioCapture.stop()
  //
  //   this.endTime()
  //
  //   if (this.voiceState === VoiceRecordEnum.RecordIng) {
  //     if (this.duration < 1) {
  //       return promptAction.showToast({
  //         message:"内容是间不足一秒！"
  //       })
  //     }
  //     this.sendAudioMessage(this.audioFilePath,this.duration)
  //     this.audioFilePath=""
  //     this.duration=0
  //   }else if (this.voiceState===VoiceRecordEnum.Cancel){
  //
  //     this.duration=0
  //     this.audioFilePath=""
  //   }else if (this.voiceState===VoiceRecordEnum.Transfer){
  //     this.duration=0
  //     this.audioFilePath=""
  //   }
  //
  // }

  build() {

  Column(){
      Button("按住说话")
        .gesture(
          GestureGroup(
            GestureMode.Parallel,
            LongPressGesture()
              .onAction(()=>{
                this.checkMicroPhonePermission()
              })
              .onActionEnd(()=>{
                // this.releaseFinger()
                AlertDialog.show({
                  message:"请说话"
                })
              }),
          )
        )

  }
    .height('100%')
    .width('100%')
  }
}