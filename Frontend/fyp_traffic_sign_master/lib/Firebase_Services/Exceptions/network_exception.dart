class NoNetwork implements Exception {
  final String message;

  const NoNetwork([this.message = "ALERT ! No Internet Connection. Check Network"]);
  //bool get isNoInternetCon => message.contains('ALERT ! No Internet Connection');

  factory NoNetwork.code(e) {
    switch (e.code) {
      case 'no-internet-connection':
        return const NoNetwork('ALERT ! No Internet Connection.');
      default:
        return const NoNetwork();
    }
  }
}