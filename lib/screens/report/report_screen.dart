import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/profile_controller.dart';
import 'package:tmwes/models/record_migraine_model.dart';
import 'package:tmwes/models/user_model.dart';
import 'package:tmwes/screens/profile/edit_profile_screen.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';
import 'package:tmwes/services/record_migraine_db.dart';

class Report extends StatefulWidget {
  final int timeRange;
  const Report({Key? key, required this.timeRange});
  @override
  State<Report> createState() => _ReportState(timeRange: timeRange);
}

class _ReportState extends State<Report> {
  int timeRange;
  _ReportState({required this.timeRange});

  final pdf = pw.Document();

  late int age;
  var checkRecord = true;
  static late List<RecordMigraineModel> records;
  static late UserModel userData;
  static late DateTime startTime;
  static late DateTime endTime;
  @override
  void initState() {
    setState(() {
      getMigraineRecords();
      getUserData();
    });
    super.initState();
  }

  getUserData() async {
    userData = await ProfileController.instance.getUserData();
    age = DateTime.now().year - userData.dateOfBirth.year;
  }

  getMigraineRecords() async {
    checkRecord = true;
    endTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int day = 0;
    if (timeRange == 1) {
      day = 30;
    } else if (timeRange == 2) {
      day = 60;
    } else if (timeRange == 3) {
      day = 90;
    }
    startTime = endTime.subtract(Duration(days: day));
    records = await RecordMigraineDb.instance
        .getMigraineRecordsforReport(startTime, endTime);
    if (records.isEmpty) {
      print("no records.");
      checkRecord = false;
    }
    //!debug purpose
    for (var doc in records) {
      final event = doc;
      print("\nRecords: ${event.mRecordDate}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        title: Text('Report',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.apply(color: Colors.white)),
      ),
      body: PdfPreview(
        // maxPageWidth: 1000,
        // useActions: false,
        // canChangePageFormat: true,
        canChangeOrientation: false,
        // pageFormats:pageformat,
        canDebug: false,

        build: (format) => generateDocument(
          format,
        ),
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final ByteData image = await rootBundle.load('assets/images/logo.png');
    Uint8List logoData = (image).buffer.asUint8List();

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 10,
            marginLeft: 10,
            marginRight: 10,
            marginTop: 10,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        footer: (pw.Context context) {
          return pw.Column(children: [
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.RichText(
                  text: const pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        text:
                            'The TMWES app aims to foster improved collaboration between individuals and their \ncare teams while providing clear and user-friendly doctor reports. \nWe value your feedback on how we can enhance this report. \nPlease share your insights with us at ',
                        style: pw.TextStyle(
                            fontSize: 13, color: PdfColors.grey900),
                      ),
                      pw.TextSpan(
                        text: 'tmwes1111@gmail.com',
                        style: pw.TextStyle(
                            decoration: pw.TextDecoration.underline,
                            fontSize: 13,
                            color: PdfColors.blue900),
                      ),
                      pw.TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            )
          ]);
        },
        build: (context) {
          const rowsPerPage = 8;
          final totalRows = records.length;
          final totalPages = (totalRows / rowsPerPage).ceil();

          final pages = <pw.Widget>[];

          for (var currentPage = 0; currentPage < totalPages; currentPage++) {
            final startIndex = currentPage * rowsPerPage;
            final endIndex = (startIndex + rowsPerPage).clamp(0, totalRows);
            final pageRows = records.sublist(startIndex, endIndex);

            pages.add(
              pw.Column(children: [
                pw.Header(
                  level: 0,
                  child: pw.Column(children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(
                            pw.MemoryImage(logoData),
                            width: 60,
                            height: 60,
                          ),
                          pw.Text(
                            '  Migraine Report',
                            style: pw.TextStyle(
                                fontSize: 28, fontWeight: pw.FontWeight.bold),
                          ),
                        ]),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                ' ${userData.fullName}',
                                style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.Row(children: [
                                pw.Text(' Time Period: ',
                                    style: pw.TextStyle(
                                        fontSize: 18,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    '${formatRecordDate(startTime)} - ${formatRecordDate(endTime)}',
                                    style: pw.TextStyle(
                                      fontSize: 18,
                                      fontWeight: pw.FontWeight.bold,
                                    )),
                              ]),
                              pw.Text(
                                ' Age: $age',
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ]),
                        pw.Table(
                            border: pw.TableBorder.all(
                                color: PdfColors.blueGrey700),
                            defaultVerticalAlignment:
                                pw.TableCellVerticalAlignment.middle,
                            children: [
                              pw.TableRow(
                                  decoration: const pw.BoxDecoration(
                                      color: PdfColors.blueGrey300),
                                  children: [
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: pw.Column(children: [
                                        pw.Text(
                                          'Number of Attack',
                                          style: pw.TextStyle(
                                              fontSize: 15,
                                              fontWeight: pw.FontWeight.bold),
                                        )
                                      ]),
                                    )
                                  ]),
                              pw.TableRow(children: [
                                pw.Center(
                                  child: pw.Text(
                                    '${records.length}',
                                    style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                ),
                              ]),
                            ]),
                      ],
                    ),
                  ]),
                ),
                pw.Center(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        //!checking the record
                        checkRecord
                            ? pw.Padding(
                                padding: const pw.EdgeInsets.all(5),
                                child: pw.Table(
                                    border: pw.TableBorder.all(
                                        color: PdfColors.blueGrey700),
                                    defaultVerticalAlignment:
                                        pw.TableCellVerticalAlignment.middle,
                                    children: [
                                      pw.TableRow(
                                        decoration: const pw.BoxDecoration(
                                            color: PdfColors.blueGrey300),
                                        children: [
                                          pw.Column(children: [
                                            pw.Text(
                                              'Time',
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            )
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              'Pain Level',
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            )
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              'Pain Position',
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            )
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              'Trigger(s)',
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            )
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              'Medicine(s)',
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            )
                                          ]),
                                        ],
                                      ),
                                      ...pageRows
                                          .map((record) =>
                                              pw.TableRow(children: [
                                                pw.Column(
                                                  children: [
                                                    pw.Text(
                                                      'Start Time: \n${DateFormat('d/M/y H:m').format(record.mRecordDate)}',
                                                      style: const pw.TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    pw.Text(
                                                      '\n\nDuration: \n${record.hour}h ${record.minutes}m',
                                                      style: const pw.TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                                pw.Column(
                                                  children: [
                                                    pw.Text(
                                                      record.painLevel != null
                                                          ? record.painLevel!
                                                          : 'N/A',
                                                      style: const pw.TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                pw.Column(
                                                  children: [
                                                    pw.Text(
                                                      record.painPosition !=
                                                              null
                                                          ? record.painPosition!
                                                              .join(', ')
                                                          : 'N/A',
                                                      style: const pw.TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                pw.Column(
                                                  children: [
                                                    pw.Text(
                                                      record.triggers != null
                                                          ? record.triggers!
                                                              .join(', ')
                                                          : 'N/A',
                                                      style: const pw.TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                                pw.Column(
                                                  children: [
                                                    pw.Text(
                                                      record.medicine != null
                                                          ? record.medicine!
                                                              .join(', ')
                                                          : 'N/A',
                                                      style: const pw.TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ]))
                                          .toList(),
                                    ]))
                            : pw.Text('No Record.',
                                style: const pw.TextStyle(fontSize: 14)),

                        pw.SizedBox(height: 10),
                      ]),
                ),
              ]),
            );
          }
          return pages;
        },
      ),
    );
    return doc.save();
  }
}
