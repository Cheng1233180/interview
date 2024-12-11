import { hdHttp } from "basic"
import { InterviewItemModel, InterviewListParams } from "../models/InterviewItemModel"

interface PageResult {
  total: number
  pageTotal: number
  rows: InterviewItemModel[]
}

export class InterviewService {
  static findInterviewList(params: InterviewListParams) {
    return hdHttp.get<PageResult>('question/list', params)
  }
}