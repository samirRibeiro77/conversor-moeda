class Coin {
  double _buy, _sell;

  Coin(this._buy, this._sell);

  double buyValue(amount)  => amount * _buy;

  double sellValue(amount) => amount * _sell;
}