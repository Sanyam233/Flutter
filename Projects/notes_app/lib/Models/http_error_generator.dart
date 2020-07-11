class HttpErrorGenerator implements Exception{

  final String errorMessage;

  HttpErrorGenerator({this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }



}