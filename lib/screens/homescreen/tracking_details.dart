

import 'package:bucket_list_flutter/screens/reusable_widgets/time_rule.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/model/get_all_request_response.dart' as dfrGetAllReq;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class TrackingDetails extends StatefulWidget {
  final dfrGetAllReq.Data requestPartData;
  const TrackingDetails({super.key,required this.requestPartData });

  @override
  State<TrackingDetails> createState() => _TrackingDetailsState();
}

class _TrackingDetailsState extends State<TrackingDetails> {
  final Set<String> downloadedInvoiceIds = {};
  final Set<String> downloadingInvoiceIds = {};
  @override
  Widget build(BuildContext context) {
    final requestPartData = widget.requestPartData;
    final Color bucketColor = parseApiColor(requestPartData.bucketInfo?.color);
    return Scaffold(
      backgroundColor: backgroundclr,
      appBar: CustomAppBar(title: 'Request Tracking Details'),
      body: Padding(
        padding: const EdgeInsets.only(left:20,right: 20),
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.only(left: 20,right: 20,top: 18,bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color:Colors.black.withOpacity(0.25),
                offset: const Offset(1, 2),     // X: 1, Y: 2
                blurRadius: 5,                  // Blur: 5
                spreadRadius: 0,                // Spread: 0
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/metalbucket.png', height: 50,width: 50,color: bucketColor,),
                    UiHelper.horizontalSpace(width: 8),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText14(context,capsFirstChar(requestPartData.companyName??''),fontWeight: FontWeight.w500,maxLines: 1,overflow: TextOverflow.ellipsis),
                          UiHelper.verticalSpace(height: 6),
                          smallText12(context,capsFirstChar(requestPartData.bucketInfo?.category?.name??''),fontWeight: FontWeight.w400,fontSize:12),
                        ],
                      ),
                    ),
                  ],
                ),
                UiHelper.verticalSpace(height: 12),
                detailRow(context,"Request ID ", requestPartData.requestId??''),
                detailRow(context,"Status", requestPartData.isStatus??''),
                detailRow(context,"Service Provider", capsFirstChar(requestPartData.client?.name??'')),
                detailRow(context,"Requested Date", TimeRule.formatToDdMmmYy(requestPartData.requestedDate??'')),
                UiHelper.verticalSpace(height: 12),
                Divider(thickness: 0.5,color: textClr,),
                UiHelper.verticalSpace(height: 12),
                smallText12(context, 'Your Request',fontWeight: FontWeight.w500,textColor: blackColor),
                UiHelper.verticalSpace(height: 8),
                smallText12(context, requestPartData.bucketInfo?.description??'',
                fontSize: 10),
                UiHelper.verticalSpace(height: 12),
                Divider(thickness: 0.5,color: textClr,),
              /*  UiHelper.verticalSpace(height: 12),
                smallText12(context, 'Current Update from Client',fontWeight: FontWeight.w500,textColor: blackColor),
                UiHelper.verticalSpace(height: 8),
                Row(
                  children: [
                    Image.asset('assets/informationimg.png',height: 15,width: 15,),
                    UiHelper.horizontalSpace(width: 8),
                    smallText12(context, 'Client can share communication directly to the  below window',fontSize: 8,textColor: Color(0xff404040)),
                  ],
                ),
                UiHelper.verticalSpace(height: 18),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 12,right: 12,top: 14,bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: textClr, width: 0.5,
                        style: BorderStyle.solid),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // smallText12(context, 'ETA : 3 to 4 days ',fontSize: 10,textColor: Color(0xff404040)),
                      // UiHelper.verticalSpace(height: 3),
                      // smallText12(context, 'Driver Name',fontSize: 10,textColor: Color(0xff404040)),
                      // UiHelper.verticalSpace(height: 3),
                      // smallText12(context, 'Driver Number',fontSize: 10,textColor: Color(0xff404040)),
                      // UiHelper.verticalSpace(height: 3),
                      // smallText12(context, 'Vehicle Details',fontSize: 10,textColor: Color(0xff404040)),
                    ],
                  ),
                ),*/
                UiHelper.verticalSpace(height: 18),
                requestPartData.isStatus!="Completed"?
                const SizedBox():
                Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smallText12(context,'Invoice',fontWeight: FontWeight.w500,textColor: blackColor),
                    UiHelper.verticalSpace(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 18,right: 18,top: 15,bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: textClr, width: 0.5,
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/pdfgreen.png',height: 31,width: 24,),
                                  const SizedBox(width: 12,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      smallText12(context, 'Request ID',fontSize: 10,fontWeight: FontWeight.w500),
                                      UiHelper.verticalSpace(height: 3),
                                      smallText12(context, 'Pulvinar quisquesed molestie tellus',fontSize: 10,textColor: Color(0xff404040)),
                                    ],
                                  ),
                                ],
                              ),
                              MyInkWell(
                                  onTap: ()async{
                                    String pdfUrl = '$BASEURL/${requestPartData.invoices![0].invoice ?? ''}';
                                    if(downloadedInvoiceIds.contains(requestPartData.invoices![0].id??'')){
                                      UiHelper.toastMessage('Already downloaded');
                                      return;
                                    }
                                    if (defaultTargetPlatform == TargetPlatform.android) {
                                      await downloadPDF(pdfUrl,requestPartData.requestId??'',requestPartData.invoices![0].id??'');
                                    }
                                    print(requestPartData.invoices![0].invoice);
                                  },
                               //   child: Image.asset('assets/downarrow.png',height: 19.13,width: 19.13,)),
                                child: downloadingInvoiceIds.contains(requestPartData.invoices![0].id??'')
                                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2),):downloadedInvoiceIds.contains(requestPartData.invoices![0].id??'')
                                    ? Icon(Icons.check_circle, color: Colors.green) // or your custom asset
                                    : Image.asset('assets/downarrow.png', height: 19.13, width: 19.13),),
                                ],
                          ),
                        ],
                      ),
                    ),
                    UiHelper.verticalSpace(height: 14),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*downloadPDF(String pdfURL, String pdfName, String invoiceId) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      Dio dio = Dio();
      const downloadsFolderPath = '/storage/emulated/0/Download';
      final filePath = '$downloadsFolderPath/$pdfName.pdf';
      final File file = File(filePath);
      try {
        Response response = await dio.get(pdfURL,
            options: Options(responseType: ResponseType.bytes));
        if (defaultTargetPlatform == TargetPlatform.android) {
          await file.writeAsBytes(response.data);
          print('PDF downloaded successfully to $filePath');
          UiHelper.toastMessage('PDF downloaded successfully in download folder');
        } else {
          final directory = await getApplicationDocumentsDirectory();
          final filePath = '${directory.path}/$pdfName.pdf';
          // Write the downloaded PDF to a file.
          final file = File(filePath);
          await file.writeAsBytes(response.data);
          print('PDF Downloaded to: $filePath');
          setState(() {
          });
        }
      } catch (e) {
        setState(() {
        });
        UiHelper.toastMessage('Error downloading PDF: $e');
        print('Error downloading PDF: $e');
      }
    }else {
      UiHelper.toastMessage('Storage permission denied');
    }
  }*/
  downloadPDF(String pdfURL, String pdfName, String invoiceId) async {
    print('pdfURL:$pdfURL');
    print('pdfName:$pdfName');
    print('invoiceId:$invoiceId');
    Dio dio = Dio();
    const downloadsFolderPath = '/storage/emulated/0/Download';
    final filePath = '$downloadsFolderPath/$pdfName.pdf';
    final File file = File(filePath);
    setState(() {
      downloadingInvoiceIds.add(invoiceId);
    });
    try {
      Response response = await dio.get(pdfURL,
          options: Options(responseType: ResponseType.bytes));
      if (defaultTargetPlatform == TargetPlatform.android) {
        await file.writeAsBytes(response.data);
        print('PDF downloaded successfully to $filePath');
        setState(() {
          downloadedInvoiceIds.add(invoiceId); // <-- add here
          downloadingInvoiceIds.remove(invoiceId);
        });
        UiHelper.toastMessage('PDF downloaded successfully in download folder');
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$pdfName.pdf';
        // Write the downloaded PDF to a file.
        final file = File(filePath);
        await file.writeAsBytes(response.data);
        print('PDF Downloaded to: $filePath');
        setState(() {
          downloadingInvoiceIds.remove(invoiceId);
        });
      }
    } catch (e) {
      setState(() {
        downloadingInvoiceIds.remove(invoiceId);
      });
      UiHelper.toastMessage('Error downloading PDF: $e');
      print('Error downloading PDF: $e');
    }
    //  }
  }
}


Widget detailRow(BuildContext context,String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
            flex: 5,
            child: smallText12(context,title,fontWeight: FontWeight.w500, fontSize: 10, textColor: blackColor)),
        smallText12(context,'-',fontWeight: FontWeight.w500, fontSize: 10, textColor: blackColor),
        UiHelper.horizontalSpace(width: 18),
        Expanded(
          flex: 9,
            child: smallText12(context,value,fontWeight: FontWeight.w500, fontSize: 10, textColor: blackColor)),
      ],
    ),
  );
}