part of 'result_page_bloc.dart';

class ResultPageState extends Equatable {
  const ResultPageState({this.response, this.request = Request.initial});

  final Request? request;
  final TranscriptionResponse? response;

  @override
  List<Object?> get props => [request, response];
  ResultPageState copyWith(
      {Request? request, TranscriptionResponse? response}) {
    return ResultPageState(
      request: request ?? this.request,
      response: response ?? this.response,
    );
  }
}
