import { pushService } from "@kit.PushKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { http } from "@kit.NetworkKit";
import { promptAction } from "@kit.ArkUI";
import { JSON } from "@kit.ArkTS";
import { notificationManager } from "@kit.NotificationKit";

@Entry
@Component
export struct news {

  @State
  pushToken :string = ""
  @State
  isLoadings :boolean = false
  authorization:string="Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ijg1MzU0ZTUzYjhkYTRkNDJiNzRkMDhkN2U4Y2Q4NmNiIn0.eyJpc3MiOiIxMTI4MTA1MzMiLCJhdWQiOiJodHRwczovL29hdXRoLWxvZ2luLmNsb3VkLmh1YXdlaS5jb20vb2F1dGgyL3YzL3Rva2VuIiwiaWF0IjoxNzM0MjYwNTMwLCJleHAiOjE3MzQyNjQxMzB9.AA0SMhk4IbtqVK1eYmk3aP_3P5JsD9fYFAprbZirifGunV-9VxZtJ1IYqgjJAH2ZALXP3B4iGM4WV-MbnTUac8LbCWIgv6FkmCB4zi3MuSkFKmaxvA8CPIMivdYZ0au3xmyA12HXGBY8oUw_91Z74rbV04r4sz01Pk7NBQf5mvrdGV75fzFkJ26OAtGl0ZcQwliSucVbG7zVNhcy3n5Lh3BSUhVgCPIrSe6n4hyrkYjEI-bLORZ0Cyx9OpBO9FMQA8kPyCF5JvvN47DGriV7vIOxQ0y7kLjSM2Lgbv7EOn9XrNLvs6q2Ryrsbz51YWoscidT8OWumuPYGKPDZi-2IKfQRTQqYbl3WvdlpPHA-VDWi3dAfW5HEF5YQSeeS_LG22TjC2QXsZT7T7iwANK4wzAiqDnI-4M_DJnP3lq2M4a4MTAPosK_zgEDZWMGogexQj3teLrBRvmdi-jmpAbWXHwR5Kl43j98gODbKLfC43J9BYrMEGwJPT0gtUKCEslgbSHw-coRV8MsBwX64uMwW7Y7i3P_Lwej0nUWiRjF4I3lBYSus3qsVckjGa76WaC4wafycjYObjoKrg87FG9DHKgkUnFemX11BiAWLtrSJWEuGaM62EyuWJ--VgzxWiuMoKWgR9wWohpqhKeFCFLYP8fvPOOh_r-C1BtFUwDrOSc"



  async aboutToAppear(): Promise<void> {
    try {

      const pushToken:string=await pushService.getToken()
      console.log('getToken succeed Token '+pushToken)

      const now=new Date()
      const timeStamp=now.getTime()

      console.log('getToken succeed Time'+Math.floor(timeStamp/1000))
      console.log('getToken succeed Time'+(Math.floor(timeStamp/1000)+3600))
      this.pushToken=pushToken
    } catch (err) {
      const e:BusinessError=err as BusinessError
      console.error('getToken failed '+JSON.stringify(e))
    }
  }

  async requestNotification() {
    try {
      console.info("requestNotification:请求通知授权开始。");
      // 查询通知是否授权
      const notificationEnabled: boolean = await notificationManager.isNotificationEnabled();
      console.info("reguestNotification:" + (notificationEnabled ? '已' : '未') + "授权");
      if (!notificationEnabled) {
        // 请求通知授权
        await notificationManager.requestEnableNotification();
      }
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error("reguestNotification failed. Cause:" + JSON.stringify(e));
    }
  }

  build() {
    Column() {
      Button("发送消息")
        .type(ButtonType.Normal)
        .borderRadius(8)
        .onClick(async ()=>{
          try {
            this.isLoadings = true
            const url= "https://push-api.cloud.huawei.com/v3/461323198429144777/messages:send";
            const HTTP = http.createHttp();
            const response: http.HttpResponse = await HTTP.request(url, {
              header: {
                "Content-Type": "application/json",
                "Authorization": this.authorization,
                "push-type": 0
              },
              method: http.RequestMethod.POST,
              extraData: {
                "payload": {
                  "notification": {
                    "category": "MARKETING",
                    "title": "普通通知标题",
                    "body": "普通通知内容",
                    "clickAction": {
                      "actionType": 1,
                      'data': { "testKey": "testValue" },
                      "notifyId": 12345,
                    }
                  }
                },
                "target": {
                  "token": [this.pushToken]
                },
                "pushOptions": {
                  "textMessage": true,
                  "ttl":86400
                }
              }
            })
            if (response.responseCode === 200) {
              const result=response.result as string
              const data=JSON.parse(result) as ResultData
              promptAction.showToast({
              message:data.msg+"222222"
            })

            }
            } catch (err) {
            const e:BusinessError=err as BusinessError
            promptAction.showToast({
              message:"111111"
            })

            console.error('getToken failed '+JSON.stringify(e))
          } finally {
            this.isLoadings = false
          }
          })

    }
    .width('100%')
    .height('100%')
  }
}

 export interface ResultData{
  'code':string
   'msg':string
   'requestId':string
 }

