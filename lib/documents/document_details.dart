import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../models/Document.dart';

class DocumentDetail extends StatefulWidget {
  final Document document;
  const DocumentDetail({super.key, required this.document});

  @override
  
  State<DocumentDetail> createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text(widget.document.file_name),
        backgroundColor: const Color.fromARGB(244, 7, 43, 63),
      ),
      body: SfPdfViewer.network(
        widget.document.file_path,
      ),
    );
  }
}