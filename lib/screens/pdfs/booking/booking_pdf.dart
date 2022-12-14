import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import '../../../../constant.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/doc_data_services.dart';
import 'utils_pdf.dart';

class BookingPDF extends StatefulWidget {
  @override
  State<BookingPDF> createState() => _BookingPDFState();
}

class _BookingPDFState extends State<BookingPDF> {
  Future<Uint8List> generatePdf(
    PdfPageFormat format,
  ) async {
    int bookingId = await getBookId();
    String nameuser = await getbookingName();
    String emailuser = await getbookingEmail();
    String date = await getbookingDate();
    String passportNumber = await getbookingPassport();
    String phoneNumer = await getbookingPhone();
    String subject = await getbookingSubject();
    String description = await getbookingDescription();

    final doc = pw.Document(title: "Flutter School");
    final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );
    final footerImage = pw.MemoryImage(
      (await rootBundle.load('assets/footer.png')).buffer.asUint8List(),
    );
    final assImage = pw.MemoryImage(
      (await rootBundle.load('assets/doc_ass.png')).buffer.asUint8List(),
    );
    final font = await rootBundle.load('assets/RobotoRegular.ttf');
    final ttf = pw.Font.ttf(font);

    final _pageTheme = await myPageTheme(format);

    doc.addPage(
      pw.MultiPage(
        pageTheme: _pageTheme,
        header: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          logoImage,
          width: 350,
          height: 150,
          fit: pw.BoxFit.contain,
        ),
        footer: (final context) => pw.Image(
          footerImage,
          fit: pw.BoxFit.scaleDown,
        ),
        build: (final context) => [
          pw.Container(
            padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                pw.Center(
                  child: pw.Text("COMPROVATIVO DE AGENDAMENTO",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ),
                pw.SizedBox(height: 60),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(10),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('NOME: '),
                            pw.SizedBox(height: 10),
                            pw.Text('E-MAIL: '),
                            pw.SizedBox(height: 10),
                            pw.Text('TELEFONE: '),
                          ]),
                      pw.SizedBox(width: 20),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              nameuser,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              emailuser,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              phoneNumer,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ]),
                      pw.Spacer(),
                      pw.BarcodeWidget(
                        data: bookingId.toString(),
                        height: 100,
                        width: 100,
                        drawText: false,
                        barcode: pw.Barcode.qrCode(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Table(
              border: pw.TableBorder.all(width: 2.0),
              children: [
                pw.TableRow(children: [
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text("N?? PASSAPORTE")),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text("ACTO MIGRAT??RIO")),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text("DATA / AGENDAMENTO")),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text("TAXA A PAGAR")),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(passportNumber,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(subject,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(date,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text("15.000,00",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                ]),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Paragraph(
            margin: const pw.EdgeInsets.all(10),
            text:
                "Obs.: Pedimos aos utentes o escrupuloso cumprimento do hor??rio, comparecendo 15 minutos antes da hora agendada para acautelar eventuais constrangimentos ?? entrada. Deve levar consigo toda documenta????o, bem como o formul??rio digital devidamente preenchido.",
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(height: 20),
        ],
      ),
    );
    return doc.save();
  }

  Future<pw.PageTheme> myPageTheme(PdfPageFormat format) async {
    final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );

    return pw.PageTheme(
      margin: const pw.EdgeInsets.symmetric(
        horizontal: 1 * PdfPageFormat.cm,
        vertical: 0.5 * PdfPageFormat.cm,
      ),
      textDirection: pw.TextDirection.ltr,
      orientation: pw.PageOrientation.portrait,
      buildBackground: (final context) => pw.FullPage(
        ignoreMargins: false,
        child: pw.Watermark(
          angle: 0,
          child: pw.Opacity(
            opacity: 0.1,
            child: pw.SizedBox(
              width: 400,
              height: 400,
              child: pw.Image(
                alignment: pw.Alignment.center,
                logoImage,
                fit: pw.BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveAsFile(
    final BuildContext context,
    final LayoutCallback build,
    final PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    print('save as File ${file.path}...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  void showPrintedToast(final BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Docmunt printed successfully!")));
  }

  void showSharedToast(final BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Docmunt shared successfully!")));
  }

  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveAsFile)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visualizador de Documento"),
        backgroundColor: kColorPrimary,
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,
        canChangePageFormat: false,
        canDebug: false,
      ),
    );
  }
}
