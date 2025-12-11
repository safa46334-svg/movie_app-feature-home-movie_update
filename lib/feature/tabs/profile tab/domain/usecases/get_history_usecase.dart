import '../../data/repository_impl/profile_repository.dart';

class GetHistoryUsecase {
  final ProfileRepository repo;
  GetHistoryUsecase(this.repo);
  call() => repo.getHistory();
}