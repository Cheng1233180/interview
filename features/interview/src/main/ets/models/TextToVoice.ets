import { textToSpeech } from "@kit.CoreSpeechKit";
import { util } from "@kit.ArkTS";

export class TextToVoice {

  static  ttsEngine: textToSpeech.TextToSpeechEngine;
  // static extraParam: Record<string, Object> = {"queueMode": 0, "speed": 1, "volume": 2, "pitch": 1, "languageContext": 'zh-CN', "audioType": "pcm", "soundChannel": 3, "playType":1};
  static initParamsInfo: textToSpeech.CreateEngineParams = {
    language: 'zh-CN',
    person: 0,
    online: 1,
    extraParams:{}
  };
  static speakParams: textToSpeech.SpeakParams={
    requestId:util.generateRandomUUID(),
    extraParams: {"speed": 1, "volume": 2, "pitch": 1, "languageContext": 'zh-CN', "audioType": "pcm" },
  }


  static  speakListener: textToSpeech.SpeakListener = {
    // 开始播报回调
    onStart(requestId: string, response: textToSpeech.StartResponse) {
      console.info(`onStart, requestId: ${requestId} response: ${JSON.stringify(response)}`);
    },
    // 合成完成及播报完成回调
    onComplete(requestId: string, response: textToSpeech.CompleteResponse) {
      console.info(`onComplete, requestId: ${requestId} response: ${JSON.stringify(response)}`);
    },
    // 停止播报回调
    onStop(requestId: string, response: textToSpeech.StopResponse) {
      console.info(`onStop, requestId: ${requestId} response: ${JSON.stringify(response)}`);
    },
    // 返回音频流
    onData(requestId: string, audio: ArrayBuffer, response: textToSpeech.SynthesisResponse) {
      console.info(`onData, requestId: ${requestId} sequence: ${JSON.stringify(response)} audio: ${JSON.stringify(audio)}`);
    },
    // 错误回调
    onError(requestId: string, errorCode: number, errorMessage: string) {
      console.error(`onError, requestId: ${requestId} errorCode: ${errorCode} errorMessage: ${errorMessage}`);
    }
  };
 static async  start(text:string){
   if (!TextToVoice.ttsEngine) {

     TextToVoice.ttsEngine = await textToSpeech.createEngine(TextToVoice.initParamsInfo);

   }
    // 开始合成


   TextToVoice.ttsEngine.setListener(TextToVoice.speakListener)

    TextToVoice.ttsEngine.speak(text, TextToVoice.speakParams);
    // 设置合成参数
    // let params: textToSpeech.SynthesisParams = {
    //   text: '你好，欢迎使用语音合成服务。',
    //   voice: 'xiaoyan',
    //   speed: 1.0,
    //   pitch: 1.0,
    //   volume: 1.0,
    //   engineType: textToSpeech.EngineType.CLOUD,
    //   format: textToSpeech.AudioFormat.PCM,
    //   sampleRate: 16000,
    //   voiceType: textToSpeech.VoiceType.MALE_1,
    //   aue: textToSpeech.AudioEncoding.LINEAR16,
    //   enablePunctuationPrediction: true,
    //   enableInverseTextNormalization: true,
    //   enableVoiceDetection: true,
    //   enableSpeakerDiarization: true,
    //   speakerDiarizationConfig: {
    //     speakerNumber: 2,
    //     maxSpeakerCount: 2,
    //     speakerSeparation: 1000,
    //     vadExtension: 200,
    //     vadThreshold: 100,
    //     vadMinVolume: 100,
    //     vadMaxVolume: 3000,
    //     vadSmoothing: 10,
    //     vadEnergyThreshold: 100,
    //     vadPostProcessingWindow: 200,
    //     vadPostProcessingThreshold: 0.1,
    //     vadPostProcessingAction: textToSpeech.VadPostProcessingAction.MASK
    //   }
    //   };

  }


}