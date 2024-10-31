import 'package:flutter/foundation.dart';

class FormStateProvider extends ChangeNotifier {
  Map<String, dynamic> _formData = {};

  Map<String, dynamic> get formData => _formData;

  dynamic getFieldValue(String key) => _formData[key];

  bool hasFieldValue(String key) =>
      _formData.containsKey(key) && _formData[key] != null;

  void updateFormData(String key, dynamic value) {
    _formData[key] = value;
    notifyListeners();
  }

  void clearFieldValue(String key) {
    _formData.remove(key);
    notifyListeners();
  }

  void clearNIDData() {
    _formData.remove('lastName');
    _formData.remove('firstName');
    _formData.remove('ammountToPay');
    _formData.remove('nidValidationMessage');
    _nidData = null;
    notifyListeners();
  }

  String? _nidValidationMessage;
  String? get nidValidationMessage => _nidValidationMessage;

  void setNIDValidationError(String message) {
    _nidValidationMessage = message;
    notifyListeners();
  }

  void clearNIDValidationError() {
    _nidValidationMessage = null;
    notifyListeners();
  }

  String? firstName;
  String? lastName;
  double? ammountToPay;

  String? _nidData;
  String? get nidData => _nidData;

  void setNIDData(String nid) {
    _nidData = nid;
    _formData['lastName'] = "Faid";
    _formData['firstName'] = "JABO";
    _formData['ammountToPay'] = "15000";
    _formData['nid'] = nid;
    firstName = 'John';
    lastName = 'Doe';
    ammountToPay = 15000;
    notifyListeners();
  }
}
