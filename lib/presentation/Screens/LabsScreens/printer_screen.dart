import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app_mahmoud/presentation/resources/values_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../../../data/reportsModel/lab_report_data.dart';
import '../../../generated/assets.dart';


class PrinterScreen extends StatelessWidget {
 final String day1  , day2 ,   sumQuantity  , sumPrice  , labName   ;

  const PrinterScreen({super.key, required this.labName, required this.day1, required this.sumQuantity, required this.sumPrice, this.day2 =""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(title)),
    body:Consumer<LabReportModel>(
        builder: (context, report, _){
        return PdfPreview(
        build: (format) =>  _generatePdf(report, day1, day2,sumQuantity ,sumPrice,labName ),
        );
      }
    )
    );
  }
}
Future<Uint8List> _generatePdf(LabReportModel report , String day1, String day2,String sumQuantity, String sumPrice, String labName) async {
  final pdf = pw.Document();
  // final font = await PdfGoogleFonts.cairoMedium();
  pw.Font font = pw.Font.ttf(await rootBundle.load(Assets.fontsNeoSansArabicMedium)) ;
  // var data = await rootBundle.load(Assets.fontsNeoSansArabicMedium);
  pdf.addPage(
    pw.MultiPage(
      pageFormat:PdfPageFormat.a4,
      header: (context){
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
        children :[
          pw.Center(child:   pw.Text(labName, style: pw.TextStyle(fontSize: 18,font : font ,letterSpacing: 0,
              renderingMode: PdfTextRenderingMode.fill ), textDirection: pw.TextDirection.rtl),),
        ]
        );
    },
      build:(pw.Context context)  {
       return  [
       pw.SizedBox(height: AppSize.s40),
              (day2.isNotEmpty) ?
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(day1, style: const pw.TextStyle(fontSize: 20)),
                      pw.Text(day2, style: const pw.TextStyle(fontSize: 20)),
                    ]
                  )
                  :
              pw.Center(child: pw.Text(day1, style: const pw.TextStyle(fontSize: 20)),),
              pw.SizedBox(height: AppSize.s20),
              pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: <int,  pw.TableColumnWidth>{
                  0: const pw.FixedColumnWidth(2.2 *PdfPageFormat.cm),
                  2: const pw.FixedColumnWidth(3.3 *PdfPageFormat.cm),
                  3: const pw.FixedColumnWidth(4.4 *PdfPageFormat.cm),
                },
                border: pw.TableBorder.all(),
                children: [
                  // Table header
                  pw.TableRow(
                    children: [
                      pw.Center(child: pw.Text('M' ,style: const pw.TextStyle(fontSize: 16)),),
                      pw.Padding(padding:const pw.EdgeInsets.symmetric(vertical:  .3 * PdfPageFormat.cm),
                        child: pw.Center(child: pw.Text('Test Name', style: const pw.TextStyle(fontSize: 18)),),),
                      pw.Center(child: pw.Text('Number' ,style: const pw.TextStyle(fontSize: 16)),),
                      pw.Center(child: pw.Text('Price' ,style: const pw.TextStyle(fontSize: 18)),),
                    ],
                  ),
                  // Table data
                  for(int index =0 ; index <report.labReportList.length ; index++)
                    pw.TableRow(
                      children: [
                        pw.Center(child: pw.Text('${index+1}',style: const pw.TextStyle(fontSize: 16)),),
                        pw.Padding(padding:const pw.EdgeInsets.symmetric(horizontal:  .3 * PdfPageFormat.cm,vertical:  .3 * PdfPageFormat.cm),
                        child:pw.Text('${report.labReportList[index].analysisName}',style: const pw.TextStyle(fontSize: 16)),
                        ),
                        pw.Center(child: pw.Text('${report.labReportList[index].analysisQuantity}',style: const pw.TextStyle(fontSize: 16)),),
                        pw.Center(child: pw.Text('${report.labReportList[index].analysisPrice}',style: const pw.TextStyle(fontSize: 16)),),
                      ],
                    ),
                  // Add more rows as needed
                ],
              ),
              pw.SizedBox(height: AppSize.s50),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                   pw.SizedBox(width:  AppSize.s140 ,child:    pw.Text("total Number :", style: const pw.TextStyle(fontSize: 20)),),
                   pw.SizedBox(width:  AppSize.s140 ,child:    pw.Text(sumQuantity, style: const pw.TextStyle(fontSize: 20)),),
                  ]
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
        pw.SizedBox(width:  AppSize.s140 ,child:   pw.Text("total Price   :", style: const pw.TextStyle(fontSize: 20)),),
        pw.SizedBox(width:  AppSize.s140 ,child:  pw.Text(sumPrice, style: const pw.TextStyle(fontSize: 20)),),
                  ]
              )
            ];
      },
      footer: (context){
        final text ="page ${context.pageNumber} / ${context.pagesCount}" ;
        return    pw.Container(
            alignment: pw.Alignment.centerRight,
            margin:const pw.EdgeInsets.only(top: 1* PdfPageFormat.cm),
            child: pw.Text(text,style: const pw.TextStyle(fontSize: 16)));
      }
    ),
  );

  return pdf.save();
}

