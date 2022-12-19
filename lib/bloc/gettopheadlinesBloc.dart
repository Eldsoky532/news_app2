

import 'package:news_app/model/aritcals_response.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';

class GetTopHeadlinesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<AritcalResponse> _subject =
  BehaviorSubject<AritcalResponse>();

  getHeadlines() async {
    AritcalResponse response = await _repository.getTopHead();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<AritcalResponse> get subject => _subject;

}
final getTopHeadlinesBloc = GetTopHeadlinesBloc();