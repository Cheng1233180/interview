import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';

@Component
export struct Location {

  mapOptions?:mapCommon.MapOptions
  callback?:AsyncCallback<map.MapComponentController>
  mapController?:map.MapComponentController

  @Link
  currentLocationMessage: string

  aboutToAppear(): void {
    this.mapOptions = {
      position:{
        target: {
          latitude:39.9,
          longitude:116.4
        },
        zoom:10
      }
    }

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;
        // 调用地图的接口，显示当前位置
        this.getLocation()



      }
    };


  }

  async getLocation(){
    const result = await geoLocationManager.getCurrentLocation()
    AlertDialog.show({
      message:JSON.stringify(result,null,2)
    })
    const res=await geoLocationManager.getAddressesFromLocation({
      latitude:result.latitude,
      longitude:result.longitude
    })

    AlertDialog.show({
      message:JSON.stringify(res,null,2)
    })
    if (res.length) {
      this.currentLocationMessage=res[0].placeName as string
    }

    this.mapController?.setMyLocation(result)
    const cameraUpdate:map.CameraUpdate=map.newCameraPosition({
      target:{
        longitude:result.longitude,
        latitude:result.latitude,
      },
      zoom:15
    })
    this.mapController?.moveCamera(cameraUpdate)
    this.mapController?.addMarker({
      position: {
        latitude: result.latitude,
        longitude: result.longitude
      },
    title:"当前位置",
  snippet:this.currentLocationMessage,
      clickable:true,
    })

    this.mapController?.addCircle({
      radius:1000,
      center:{
        latitude:result.latitude,
        longitude:result.longitude
      },
      fillColor:0xFF00FFFFFF
    })



  }


  build() {
    Column() {

      if (canIUse('SystemCapability.Map.Core')){
        MapComponent({
          mapOptions:this.mapOptions,
          mapCallback:this.callback
        })
          .width("100%")
          .height("100%")
      }else {

      }



    }
    .width('100%')
    .height('100%')
  }
}