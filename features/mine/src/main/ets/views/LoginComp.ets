import { promptAction, router } from "@kit.ArkUI"
import { authStore, hdHttp, HdResponse, HdUser, logger } from "basic"
import { BusinessError, emitter } from "@kit.BasicServicesKit"
import { authentication } from "@kit.AccountKit"
import { util } from "@kit.ArkTS"


interface LoginParams {
  username: string
  password: string
}

@Component
export struct LoginComp {
  // hmheima
  @State
  mobile: string = 'hmheima9'
  //Hmheima%123
  @State
  code: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false
  @StorageProp('topHeight')
  topHeight: number = 0



  login() {
    if (this.loading) return;
    if (!this.mobile) {
      return promptAction.showToast({ message: '请输入用户名' })
    }
    if (!this.code) {
      return promptAction.showToast({ message: '请输入密码' })
    }
    if (!this.isAgree) {
      return promptAction.showToast({ message: '请勾选已阅读并同意' })
    }
    this.loading = true
    // login request
    hdHttp.post<HdUser>('login', {
      username: this.mobile,
      password: this.code
    } as LoginParams).then(async (res: HdResponse<HdUser>) => {
      await authStore.setUser(res.data)
      promptAction.showToast({ message: '登录成功', duration: 1000 })
      emitter.emit({ eventId: 100401 })
      const params = router.getParams() as Record<string, string>
      // AlertDialog.show({
      //   message:JSON.stringify(params.return_path)
      // })
      if (params && params.return_path) {

        router.replaceUrl({
          url: params.return_path,
          params: params
        })
      } else {
        router.back()
      }
      this.loading = false
    })
  }

  // logina() {
  //   // 将token存储到本地
  //   authStore.context = getContext()
  //   authStore.setUser("eyJhbGciOiJIUzI1NiJ9.eyJjdXJyZW50VXNlciI6IntcInVzZXJuYW1lXCI6XCIzNTQyMzQ4NEBxcS5jb21cIixcInBhc3N3b3JkXCI6XCJcIixcIm5pY2tOYW1lXCI6XCLmiqTnkIblkZgxXCIsXCJlbWFpbFwiOlwiMzU0MjM0ODRAcXEuY29tXCIsXCJyZWFsTmFtZVwiOlwi5oqk55CG5ZGYMVwiLFwibW9iaWxlXCI6XCIxODIxMTAyMTg5NlwiLFwic2V4XCI6XCIwXCIsXCJkZXB0Tm9cIjpcIjEwMDAwMTAwNTAwMDAwMFwiLFwicG9zdE5vXCI6XCIxMDAwMDEwMDUwMDMwMDBcIixcImRhdGFTdGF0ZVwiOlwiMFwiLFwiYXZhdGFyXCI6XCJodHRwczovL3lqeS1vc3MtdmlkZW9zLm9zcy1hY2NlbGVyYXRlLmFsaXl1bmNzLmNvbS9ncnp4aHouanBnXCIsXCJpZFwiOjE2NzE0MDMyNTY1MTkwNzgyNzUsXCJjcmVhdGVUaW1lXCI6MTcxNTU2ODM5MDAwMCxcInVwZGF0ZVRpbWVcIjoxNzE1NTY4MzkwMDAwLFwiY3JlYXRlQnlcIjoxNjcxNDAzMjU2NTE5MDc4MTM4fSIsImV4cCI6MTQ2NzU2NTk0Nzd9.8PrMKBNrVVCfcI4DgICxp6oBQGqy46m3oglFQCiKtzw")
  //
  //   // 跳转到首页
  //   router.pushUrl({
  //     url: "pages/Index"
  //   })
  // }
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwIiwiaWF0IjoxNzMzMTExMDU4LCJleHAiOjE3MzMxMTQ2NTh9.cJLjKohlUe0fXzkB1ufWkUhs86fgw4OOukpOR0Iyz00
  // 华为登录方法
  handleLogin() {


    // 创建登录请求，并设置参数(创建授权)
    const loginRequest = new authentication.HuaweiIDProvider().createLoginWithHuaweiIDRequest();


    // 用户是否需要登录授权，该值为true且用户未登录或未授权时，会拉起用户登录或授权页面
    loginRequest.forceLogin = true;

    // 用于防跨站点请求伪造
    loginRequest.state = util.generateRandomUUID();

    // 执行登录请求
    try {
      const controller = new authentication.AuthenticationController(getContext(this));
      controller.executeRequest(loginRequest).then((response: authentication.LoginWithHuaweiIDResponse) => {
        const loginWithHuaweiIDResponse = response as authentication.LoginWithHuaweiIDResponse;
        const state = loginWithHuaweiIDResponse.state;
        if (state != undefined && loginRequest.state != state) {
          return;
        }


        const code = loginWithHuaweiIDResponse.data!.authorizationCode
        AlertDialog.show({
          message: code
        })
       console.log(code)

      }).catch((error: BusinessError) => {
        console.log(error.message)
      })
    } catch (error) {
      console.log(error.message)
    }
  }



  build() {
    Navigation() {
      Column() {
        Column() {
          Image($r('app.media.icon'))
            .width(120)
            .aspectRatio(1)
          Text('面试通')
            .fontSize(28)
            .margin({ bottom: 15 })
          Text('搞定企业面试真题，就用面试通')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
        }

        Column({ space: 15 }) {
          TextInput({ placeholder: '请输入用户名', text: $$this.mobile })
            .customStyle()
          TextInput({ placeholder: '请输入密码', text: $$this.code })
            .type(InputType.Password)
            .showPasswordIcon(false)
            .customStyle()
          Row() {
            Checkbox()
              .shape(CheckBoxShape.ROUNDED_SQUARE)
              .selectedColor('#fa711d')
              .size({ width: 14, height: 14 })
              .select(this.isAgree)
              .onChange((val) => {
                this.isAgree = val
              })
            Text('已阅读并同意')
              .fontSize(14)
              .fontColor($r('app.color.common_gray_01'))
              .padding({ right: 4 })
            Text('用户协议')
              .fontSize(14)
              .padding({ right: 4 })
            Text('和')
              .fontSize(14)
              .fontColor($r('app.color.common_gray_01'))
              .padding({ right: 4 })
            Text('隐私政策')
              .fontSize(14)
          }.width('100%')

          Row() {
            Column() {
              Text('忘记密码')
                .fontSize(14)
                .fontColor($r('app.color.common_gray_01'))
                .onClick(() => {
                  promptAction.showToast({ message: '忘记密码功能暂未开放' })
                })
            }

            Column() {
                  Text('注册')
                    .fontSize(14)
                    .fontColor($r('app.color.common_gray_01'))
                    .onClick(() => {
                      promptAction.showToast({ message: '注册功能暂未开放' })
                    })
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width("100%")
          Button({ type: ButtonType.Normal }) {
            Row() {
              if (this.loading) {
                LoadingProgress()
                  .color($r('app.color.white'))
                  .width(24)
                  .height(24)
                  .margin({ right: 10 })
              }
              Text('立即登录')
                .fontColor($r('app.color.white'))
            }
          }
          .width('100%')
          .backgroundColor('none')
          .borderRadius(4)
          .height(44)
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#fc9c1c', 0], ['#fa711d', 1]]
          })
          .stateEffect(false)
          .onClick(() => {
            this.login()
          })
        }
        .padding({ left: 20, right: 20, top: 30 })


       Button('华为登录')
         .backgroundColor("#cc136e02")
         .fontSize(15)
         .width('95%')
         .height(50)
         .margin({top:30})
         .onClick(()=>{
           promptAction.showToast({
             message:'111111'
           })
           this.handleLogin()

         })


      }
      .width('100%')
      .height('100%')
      .padding($r('app.float.common_gutter'))
    }
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
    .margin({ top: this.topHeight })
  }
}

@Extend(TextInput)
function customStyle() {
  .placeholderColor('#C3C3C5')
  .caretColor('#fa711d')
  .height(44)
  .borderRadius(0)
  .backgroundColor($r('app.color.white'))
  .border({ width: { bottom: $r('app.float.common_border_width') }, color: $r('app.color.common_gray_border') })
}