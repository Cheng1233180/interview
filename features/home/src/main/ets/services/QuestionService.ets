import { hdHttp } from "basic"
import { QuestionTypeModel } from "../models/QuestionTypeModel"
import { QuestionItemModel, QuestionListParams } from "../models/QuestionItemModel"


interface PageResult {
  total: number
  pageTotal: number
  rows: QuestionItemModel[]
}

export class QuestionService {
  static findQuestionTypeList() {
    return hdHttp.get<QuestionTypeModel[]>('question/type')
  }

  static findQuestionList(params: QuestionListParams) {
    return hdHttp.get<PageResult>('question/list', params)
  }
}