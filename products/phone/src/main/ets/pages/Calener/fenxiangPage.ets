// import share from '@ohos.share';
//
// @Entry
// @Component
// struct Index {
//
//
//
//   build() {
//       Column({
//       justifyContent: FlexAlign.Center,
//       alignItems: HorizontalAlign.Center
//     }) {
//       Button({
//         type: ButtonType.Capsule,
//         value: '点击分享',
//         onClick: this.shareText.bind(this)
//       })
//     }
//   }
//
//   shareText() {
//     // 创建分享参数对象
//     let intentParams: share.IntentParams = {
//       action: share.Intent.ACTION_SEND,
//       extra: {
//         [share.Intent.EXTRA_TEXT]: '这是一段要分享的示例文本'
//       }
//     };
//     // 使用Share模块发起分享
//     share.ShareHelper.share(intentParams).then((result: number) => {
//       if (result === share.ShareHelper.SUCCESS) {
//         console.log('分享成功');
//       } else {
//         console.log('分享失败，错误码: ' + result);
//       }
//     }).catch((error) => {
//       console.error('分享出现异常: ', error);
//     });
//   }
// }