import { Location } from './Location';

@Entry
@Component
struct MapPage {
  @State
  isShow: boolean = false;

@State
currentLocationMessage: string=""


  @Builder
getopen() {
  Stack({alignContent:Alignment.Top}){
    Location({currentLocationMessage:this.currentLocationMessage})
    Row(){
      Text('取消')
        .fontColor("#ff000000")
        .fontWeight(500)
        .onClick(() => {
           this.isShow = false;
           this.currentLocationMessage = "";
        })
      Button("发送")
        .type(ButtonType.Normal)
        .borderRadius(4)
        .backgroundColor(Color.Green)
        .height(30)
        .width(60)
        .onClick(() => {
          this.isShow = false;
        })
    } .border({
      width: 1,
    })
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left:20,
      right:20
    })
    .margin({top:50})
    .height(60)
  }

  .width('100%')
  .height('100%')
}


  build() {
    Column()
    {
      Button("发送位置")
        .onClick(() => {
          this.isShow = true;
        })
        .bindContentCover($$this.isShow, this.getopen(),{
          modalTransition:ModalTransition.NONE
        })
      Row(){
        if (this.currentLocationMessage){
          Row(){
            Location({currentLocationMessage:this.currentLocationMessage})
          }
          .width("60%")
          .height("100%")
        }

      }
      .width("100%")
      .height(200)
      .backgroundColor("#ffc62727")
      .margin({
        top:20,
      })
      .justifyContent(FlexAlign.End)

    }
    .height('100%')
    .width('100%')
  }
}