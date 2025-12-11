import '../../data/models/watchlist_model.dart';
import '../../data/repository_impl/profile_repository.dart';

class AddToWatchlistUsecase {
  final ProfileRepository repo;
  AddToWatchlistUsecase(this.repo);
  call(WatchlistItem movie) => repo.addWatchlist(movie);
}