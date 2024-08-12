import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrafficNews extends StatefulWidget {
  const TrafficNews({super.key});

  @override
  State<TrafficNews> createState() => _TrafficNewsState();
}

class _TrafficNewsState extends State<TrafficNews> {
  final WebViewController _controller = WebViewController();
  String pageTitle = '';
  double progress = 0;

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (pgrs) {
            setState(() {
              progress = pgrs / 100;
            });
          },
          onPageStarted: (url) {
            setState(() {
              pageTitle = 'Loading...';
            });
          },
          onPageFinished: (url) {
            setState(() {
              pageTitle = "LONDON TRAFFIC UPDATES & ALERTS";
              progress = 0;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://nationalhighways.co.uk/travel-updates/travel-alerts/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.cached_rounded,
          color: AppColors.white,
        ),
        title: const Text(
          "Traffic Updates",
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: AppColors.buttonColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pageTitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (progress > 0 && progress < 1)
              LinearProgressIndicator(
                value: progress,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.blue.shade300,
              ),
            Expanded(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            Container(
              color: Colors.grey.shade900,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      if (await _controller.canGoBack()) {
                        _controller.goBack();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.reload();
                    },
                    icon: const Icon(Icons.replay_circle_filled_rounded,
                        color: AppColors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (await _controller.canGoForward()) {
                        _controller.goForward();
                      }
                    },
                    icon: const Icon(Icons.delete, color: AppColors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.clearCache();
                    },
                    icon:
                        const Icon(Icons.arrow_forward, color: AppColors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
