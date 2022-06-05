import '../Remote/api.dart';

class ParcelService {
  Future<dynamic> getParcelTypes() async {
    var response = await CallApi().getData('productTypes');
    return response['data'];
  }
}
