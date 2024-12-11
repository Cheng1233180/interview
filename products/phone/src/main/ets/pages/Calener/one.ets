import { systemShare } from '@kit.ShareKit';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { image } from '@kit.ImageKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export default struct Index {
  private async share() {
    // 生成应用图标缩略图
    const contextFaker: Context = getContext(this);
    let thumbnailPath = contextFaker.filesDir + '/exampleImage.jpg'; // 仅为示例 请替换正确的文件路径
    const imageSourceApi: image.ImageSource = image.createImageSource(thumbnailPath);
    let opts: image.InitializationOptions = { size: { height: 6, width: 6 } }
    const pixelMap: image.PixelMap = await imageSourceApi.createPixelMap(opts);
    const imagePackerApi: image.ImagePacker = image.createImagePacker();
    const buffer: ArrayBuffer = await imagePackerApi.packing(pixelMap, {
      // 当前只支持'image/jpeg','image/webp'和'image/png'类型图片.
      format: 'image/jpeg',
      // JPEG编码中设定输出图片质量的参数,取值范围为0-100.
      // 建议适当压缩,图片过大无法拉起分享.
      quality: 30
    });
    // 构造ShareData，需配置一条有效数据信息
    let shareData: systemShare.SharedData = new systemShare.SharedData({
      utd: utd.UniformDataType.HYPERLINK,
      // App Linking链接 仅为示例
      content: 'https://sharekitdemo.drcn.agconnect.link/ZB3p',
      title: '应用名称', // 不传title时 显示链接
      description: '应用描述', // 不传则不显示描述内容
      thumbnail: new Uint8Array(buffer) // 推荐传入应用图标 不传则显示默认html图标
    });
    // 进行分享面板显示
    let controller: systemShare.ShareController = new systemShare.ShareController(shareData);
    let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    controller.show(context, {
      previewMode: systemShare.SharePreviewMode.DEFAULT,
      selectionMode: systemShare.SelectionMode.SINGLE
    }).then(() => {
      console.info('ShareController show success.');
    }).catch((error: BusinessError) => {
      console.error(`ShareController show error. code: ${error.code}, message: ${error.message}`);
    });
  }

  build() {
    Button('分享')
      .onClick(() => this.share())
  }
}