import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ElectricalScreen extends StatelessWidget {
  final String pdfPath;

  ElectricalScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electrical Engineering Reference Books'),
        backgroundColor: Color.fromARGB(244, 7, 43, 63),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
        // Add any additional configurations here
      ),
    );
  }
}