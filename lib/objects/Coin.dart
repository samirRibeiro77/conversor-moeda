class Coin {
  String _name;
  double _buy, _sell;

  Coin(this._name, this._buy, this._sell);

  double buyValue(amount)  => amount * _buy;

  double sellValue(amount) => amount * _sell;
}