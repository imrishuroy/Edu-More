import 'dart:async';
import 'dart:io';
import '/services/url_to_file_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewPdf extends StatefulWidget {
  final String? pdfUrl;

  const ViewPdf({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  // PDFDocument? _doc;

  File? _file;

  @override
  void initState() {
    super.initState();
    _getPdf();
  }

  bool _isLoading = false;

  Future<void> _getPdf() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (widget.pdfUrl != null) {
        _file = await UrlToImageService.urlToFile(widget.pdfUrl!);
        //_doc = await PDFDocument.fromURL(widget.pdfUrl!);

      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('pdf error ${error.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    if (_file != null) {
      //final image = pw.MemoryImage(_file!.readAsBytesSync());
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.amber),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  PDFView(
                    filePath: _file?.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    pageSnap: true,
                    defaultPage: currentPage!,
                    fitPolicy: FitPolicy.BOTH,
                    preventLinkNavigation:
                        false, // if set to true the link is handled in flutter
                    onRender: (_pages) {
                      setState(() {
                        pages = _pages;
                        isReady = true;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = '$page: ${error.toString()}';
                      });
                      print('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onLinkHandler: (String? uri) {
                      print('goto uri: $uri');
                    },
                    onPageChanged: (int? page, int? total) {
                      //   print('page change: $page/$total');
                      setState(() {
                        currentPage = page;
                      });
                    },
                  ),
                  errorMessage.isEmpty
                      ? !isReady
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container()
                      : Center(
                          child: Text(errorMessage),
                        )
                ],
              ),
        // floatingActionButton: FutureBuilder<PDFViewController>(
        //   future: _controller.future,
        //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
        //     if (snapshot.hasData) {
        //       return FloatingActionButton.extended(
        //         label: Text("Go to ${pages! ~/ 2}"),
        //         onPressed: () async {
        //           await snapshot.data!.setPage(pages! ~/ 2);
        //         },
        //       );
        //     }

        //     return Container();
        //   },
        // ),
      );
    }
    return const SizedBox(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
