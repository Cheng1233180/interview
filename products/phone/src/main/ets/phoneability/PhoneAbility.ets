import { abilityAccessCtrl, AbilityConstant, common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { rpc } from '@kit.IPCKit';
import { logger } from 'basic';
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import { AAID, pushCommon, pushService } from '@kit.PushKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { notificationManager } from '@kit.NotificationKit';



class MyParcelable implements rpc.Parcelable {
  marshalling(dataOut: rpc.MessageSequence): boolean {
    return true
  }

  unmarshalling(dataIn: rpc.MessageSequence): boolean {
    return true
  }
}

export default class PhoneAbility extends UIAbility {




  // async myDeletePushToken() {
  //   try {
  //     await pushService.deleteToken();
  //     hilog.info(0x0000, 'testTag', 'Succeeded in deleting push tokenwwwwww');
  //   } catch (err) {
  //     let e: BusinessError = err as BusinessError;
  //     hilog.error(0x0000, 'testTag', 'Failed to delete push token: %{public}d %{public}snnnnnn', e.code, e.message);
  //   }
  // }
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    logger.info('Ability onCreate')

    const manager=abilityAccessCtrl.createAtManager()
    await manager.requestPermissionsFromUser(this.context,[
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION"
    ])




    // 获取消息中传递的data数据
    const data = want.parameters;
    hilog.info(0x0000, 'testTag', 'Succeeded in getting message data')


    // 根据实际业务场景对data进行处理


    try {
      const pushToken: string = await pushService.getToken();
      hilog.info(0x0000, 'testTag1', 'Succeeded in getting push tokenaaaaaaaaaacccccc'+pushToken);
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      hilog.error(0x0000, 'testTag1', 'Failed to get push token: %{public}d %{public}sooopppqqq', e.code, e.message);
    }
    // 上报Push Token并上报到您的服务端








    const profileId: string = 'hmheima9';
    try {
      // pushCommon.AppProfileType 应用内帐号类型，分为华为帐号和应用帐号。我这里选择后者，根据业务需求选择的。
      pushService.bindAppProfileId(pushCommon.AppProfileType.PROFILE_TYPE_APPLICATION_ACCOUNT, profileId, (err: BusinessError) => {
        if (err) {
          hilog.error(0x0000, 'testTag', 'Failed to bind app profile id: %{public}d %{public}s', err.code, err.message);
        } else {
          hilog.info(0x0000, 'testTag', 'Succeeded in binding app profile id.');
        }
      });
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      hilog.error(0x0000, 'testTag', 'Failed to bind app profile id: %{public}d %{public}s', e.code, e.message);
    }




    try {
      this.callee.on('clock_in', (data: rpc.MessageSequence) => {
        logger.info('clock_in', data.readString())
        return new MyParcelable()
      })
    } catch (e) {
      logger.error('call form', e.message)
    }

    emitter.emit({
      eventId: 10000
    }, {
      data: {
        activeIndex: want.parameters?.page === 'interview' ? 2 : 0
      }
    })

  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {

    // 获取消息中传递的data数据
    const data = want.parameters;
    hilog.info(0x0000, 'testTag', 'Succeeded in getting message dataaaaaa');

    logger.info('Ability onNewWant')
    // router form
    emitter.emit({
      eventId: 10000
    }, {
      data: {
        activeIndex: want.parameters?.page === 'interview' ? 2 : 0
      }
    })
  }


  onDestroy(): void {
    logger.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info('Ability onWindowStageCreate');


    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      logger.info('Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
      notificationManager.requestEnableNotification(this.context).then(() => {
        hilog.info(0x0000, 'testTag', `[ANS] requestEnableNotification success`);
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, 'testTag', `[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
      });
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    logger.info('Ability onBackground');
  }
}
