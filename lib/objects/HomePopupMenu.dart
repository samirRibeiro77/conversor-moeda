class HomePopupMenu {
  List<String> _menus;

  HomePopupMenu.start() {
    this._menus = List<String>();
    this._menus.add("Cotações");
  }

  List<String> get menuList => _menus;
}