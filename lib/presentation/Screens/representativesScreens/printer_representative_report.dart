import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../../data/reportsModel/representatives_report_data.dart';
import '../../../generated/assets.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class PrinterRepresentativeReportScreen extends StatelessWidget {
final  String day1, day2 ,representativeName;


const  PrinterRepresentativeReportScreen(
      {super.key,
      required this.representativeName,
      required this.day1,
      this.day2 = ""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<RepresentativesReportData>(builder: (context, report, _) {
      return PdfPreview(
        build: (format) => _generatePdf(report, day1, day2, representativeName),
      );
    }));
  }
}

Future<Uint8List> _generatePdf(RepresentativesReportData report, String day1,
    String day2, String labName) async {
  final pdf = pw.Document();
  pw.Font font = pw.Font.ttf(await rootBundle.load(Assets.fontsNeoSansArabicMedium));
  pdf.addPage(
    pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          return pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Center(
                  child: pw.Text(labName,
                      style: pw.TextStyle(
                          fontSize: 18,
                          font: font, color:PdfColor.fromInt(0x66197fff),
                          renderingMode: PdfTextRenderingMode.fill),
                      textDirection: pw.TextDirection.rtl),
                ),
              ]);
        },
        build: (pw.Context context) {
          return [
            pw.SizedBox(height: AppSize.s30),
            (day2.isNotEmpty)
                ? pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                        pw.Text(day1, style: const pw.TextStyle(fontSize: 20)),
                        pw.Text(day2, style: const pw.TextStyle(fontSize: 20)),
                      ])
                : pw.Center(
                    child:
                        pw.Text(day1, style: const pw.TextStyle(fontSize: 20)),
                  ),
            pw.SizedBox(height: AppSize.s20),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: <int, pw.TableColumnWidth>{
                  0: const pw.FixedColumnWidth(4.4 * PdfPageFormat.cm),
                  1: const pw.FixedColumnWidth(3.3 * PdfPageFormat.cm),
                  3: const pw.FixedColumnWidth(2.2 * PdfPageFormat.cm),
                },
                border: pw.TableBorder.all(),
                children: [
                  // Table header
                  pw.TableRow(
                    children: [
                      pw.SizedBox(height: 40,
                        child: pw.Center(
              child: pw.Text(AppStrings.price,
                  style: pw.TextStyle(
                      fontSize: 16,
                      font: font,
                      letterSpacing: 0,color:PdfColor.fromInt(0xff1976d2)
                  )),
                      )
                      ),
                      pw.Center(
                        child: pw.Text(AppStrings.analysisNumber,
                            style: pw.TextStyle(
                              fontSize: 16,
                              font: font,
                              letterSpacing: 0,color:PdfColor.fromInt(0xff1976d2)
                            )),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            vertical: .3 * PdfPageFormat.cm),
                        child: pw.Center(
                          child: pw.Text(AppStrings.labName,
                              style: pw.TextStyle(
                                fontSize: 16,
                                font: font,
                                letterSpacing: 0,color:PdfColor.fromInt(0xff1976d2)
                              )),
                        ),
                      ),
                      pw.Center(
                        child: pw.Text('M',
                            style: const pw.TextStyle(fontSize: 16,color:PdfColor.fromInt(0xff1976d2) )),
                      ),
                    ],
                  ),
                  // Table data
                  for (int index = 0;
                      index < report.representativesLabsReport.length;
                      index++)
                    pw.TableRow(
                      children: [
                        pw.Center(
                          child: pw.Text(
                              '${report.representativesLabsReport[index].analysisPrice}',
                              style: const pw.TextStyle(fontSize: 16)),
                        ),
                        pw.Center(
                          child: pw.Text(
                              '${report.representativesLabsReport[index].analysisQuantity}',
                              style: const pw.TextStyle(fontSize: 16)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: .3 * PdfPageFormat.cm,
                              vertical: .3 * PdfPageFormat.cm),
                          child: pw.Text(
                              '${report.representativesLabsReport[index].labName}',
                              style: pw.TextStyle(
                                fontSize: 16,
                                font: font,
                                letterSpacing: 0,
                              )),
                        ),
                        pw.Center(
                          child: pw.Text('${index + 1}',
                              style: const pw.TextStyle(fontSize: 16,color:PdfColor.fromInt(0xff1976d2))),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            pw.SizedBox(height: AppSize.s50),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.SizedBox(
                          width: AppSize.s100,
                          child: pw.Text("${AppStrings.charging} :",
                              style: pw.TextStyle(
                                fontSize: 20,
                                font: font,
                                letterSpacing: 0,
                              )),
                        ),
                        pw.SizedBox(
                          width: AppSize.s100,
                          child: pw.Text("${report.chargingValue}",
                              style: pw.TextStyle(
                                fontSize: 20,
                                font: font,
                                letterSpacing: 0,
                              )),
                        ),
                      ]
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                        children: [
                          pw.SizedBox(
                            width: AppSize.s100,
                            child: pw.Text("${AppStrings.transmission} :",
                                style: pw.TextStyle(
                                  fontSize: 20,
                                  font: font,
                                  letterSpacing: 0,
                                )),
                          ),
                          pw.SizedBox(
                            width: AppSize.s100,
                            child: pw.Text("${report.transValue}",
                                style: pw.TextStyle(
                                  fontSize: 20,
                                  font: font,
                                  letterSpacing: 0,
                                )),
                          ),
                        ]),

                  ]),
            ),
            pw.SizedBox(height: AppSize.s30),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Row(
                    children: [
                      pw.SizedBox(
                        width: AppSize.s160,
                        child: pw.Center(  child: pw.Text("${AppStrings.totalPrice} :",
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font,
                              letterSpacing: 0,color:PdfColor.fromInt(0xff1976d2)
                            )),
                      ),),
              pw.Text("${report.sum}",
                            style: pw.TextStyle(
                              fontSize: 20,
                              font: font,
                              letterSpacing: 0,color:PdfColor.fromInt(0xff1976d2)
                            )),
                    ])),
          ];
        },
        footer: (context) {
          final text = "page ${context.pageNumber} / ${context.pagesCount}";
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: pw.Text(text, style: const pw.TextStyle(fontSize: 16)));
        }),
  );

  return pdf.save();
}
