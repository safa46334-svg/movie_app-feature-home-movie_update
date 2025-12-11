
import '../../data/models/history_model.dart';
import '../../data/repository_impl/profile_repository.dart';

class AddToHistoryUsecase {
  final ProfileRepository repo;
  AddToHistoryUsecase(this.repo);
  call(HistoryItem movie) => repo.addHistory(movie);
}