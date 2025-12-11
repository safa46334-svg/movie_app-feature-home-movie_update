import '../../data/repository_impl/profile_repository.dart';

class GetWatchlistUsecase {
  final ProfileRepository repo;
  GetWatchlistUsecase(this.repo);
  call() => repo.getWatchlist();
}