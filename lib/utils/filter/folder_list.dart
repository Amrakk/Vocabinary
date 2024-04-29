import '../../models/data/folder.dart';

class FolderList {
  List<FolderModel> _folders;

  FolderList(this._folders);

  List<FolderModel> get folders => _folders;

  set folders(List<FolderModel> newFolders) {
    _folders = newFolders;
  }
}
