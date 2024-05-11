import 'package:vocabinary/utils/filter/folder_list.dart';

import '../../models/data/folder.dart';

class FolderDecorator extends FolderList {
  final FolderList _folderList;

  FolderDecorator(this._folderList) : super(_folderList.folders);

  @override
  List<FolderModel> get folders => _folderList.folders;

  @override
  set folders(List<FolderModel> newFolders) {
    _folderList.folders = newFolders;
  }
}