import { TextToVoice } from 'interview';

@Entry
@Component
struct OpqPage {
  @State message: string = '浏览器缓存, HTTP缓存分类\n' +
    '所谓的浏览器缓存机制其实指的是,当我们发送⼀个请求之后, 浏览器会将本次请求的信息进⾏缓存, 当下⼀次\n' +
    '请求的时候. 浏览器会根据这个资源的http头信息来判断是否命中强缓存, 如果命中了,则直接加载缓存中的资\n' +
    '源,并不会讲请求发送到服务器, 这种就属于强缓存. \n' +
    '如果没有命中强缓存, 则浏览器会将资源加载请求发送到服务器,服务器来判断浏览器本地缓存是否失效,若可\n' +
    '以使⽤，则服务器并不会返回资源信息，浏览器继续从缓存加载资源. 这种就属于协商缓存\n' +
    '浏览器怎么判断当前的缓存是否过期? ';

 read(){
   TextToVoice.start(this.message)
 }

  build() {
  Column(){
    Text(this.message)
    Button("点击阅读")
      .onClick(() => {
        this.read();
      })


  }
    .height('100%')
    .width('100%')
  }
}