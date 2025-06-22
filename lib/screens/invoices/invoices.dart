import 'dart:io';

import 'package:bucket_list_flutter/model/get_invoice_list_response.dart';
import 'package:bucket_list_flutter/model/get_invoice_list_response.dart' as dfrInvoices;
import 'package:bucket_list_flutter/screens/reusable_widgets/common_decoration.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_search_field.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/empty_list_found.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/time_rule.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class Invoices extends StatefulWidget {
  final TabController controller;
  const Invoices({super.key,required this.controller});

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  final TextEditingController searchController = TextEditingController();
  bool showLoader = true;
  GetInvoiceListResponse getInvoiceListResponse = GetInvoiceListResponse();
  List<dfrInvoices.Data> allInvoice = [];
  List<dfrInvoices.Data> filteredInvoice = [];
  final groupedInvoices = <String, List<dfrInvoices.Data>>{};
  final Set<String> downloadedInvoiceIds = {};
  final Set<String> downloadingInvoiceIds = {};


  @override
  void initState() {
    _getAllRequestApi();
    super.initState();
  }

  Future<void> _getAllRequestApi() async {
    await BlocProvider.of<BucketListCubit>(context).getInvoiceListCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      appBar: CustomAppBar(title: 'Invoices',
        onBackPressed: () {
          widget.controller.animateTo(0); // Switch to Home tab
        },),
      body: SafeArea(
        child: BlocConsumer<BucketListCubit,BucketListState>(
          listener: (context,state) async {
            print("state.status:${state.status}");
            if (state.status == BucketListStatus.getInvoiceListSuccess){
              showLoader = false;
              getInvoiceListResponse = state.responseData?.response as GetInvoiceListResponse;
              allInvoice = getInvoiceListResponse.data ?? [];
              filteredInvoice = allInvoice;

              // Group invoices
              groupedInvoices.clear();
              for (var invoice in filteredInvoice) {
                final createdAt = invoice.createdAt ?? '';
                final label = TimeRule.formatInvoiceDate(createdAt);
                groupedInvoices.putIfAbsent(label, () => []).add(invoice);
              }
              // ✅ Check which invoices are already downloaded - later use
           //   await checkDownloadedInvoices(allInvoice);
            }

            if (state.status == BucketListStatus.getInvoiceListSuccess){
              showLoader = false;
            }
          },
          builder: (context,state){
            if (state.status == BucketListStatus.getInvoiceListLoading || showLoader) return AppLoader();
            if (state.status == BucketListStatus.getInvoiceListError) {
              return CustomErrorWidget(
                errorMessage: state.errorData?.message ?? state.error,
                statusCode: state.errorData?.code,
                onRetry: _getAllRequestApi,
                onRefresh: _getAllRequestApi,
              );
            }
            return RefreshIndicator(
              color:textClr,
              onRefresh: _getAllRequestApi,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: allInvoice.isEmpty?
                EmptyListFound(message:"There is no invoice",topHeight: 80,):
              Column(
                  children: [
                    CustomSearchField(
                      hintText: "Search...",
                      controller: searchController,
                      borderColor: textClr,
                      fieldColor: backgroundclr,
                      showBoxShadow:false,
                      onChanged: (value) {
                        setState(() {
                          final query = value.toLowerCase();
                          filteredInvoice = allInvoice.where((invoice) {
                            final requestId = invoice.requestInfo?.requestId?.toLowerCase() ?? '';
                            final workScope = invoice.requestInfo?.workScope?.toLowerCase() ?? '';
                            return requestId.contains(query) || workScope.contains(query);
                          }).toList();

                          // 💡 Update grouping after filtering
                          groupedInvoices.clear();
                          for (var invoice in filteredInvoice) {
                            final createdAt = invoice.createdAt ?? '';
                            final label = TimeRule.formatInvoiceDate(createdAt);
                            groupedInvoices.putIfAbsent(label, () => []).add(invoice);
                          }
                        });
                      },

                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: groupedInvoices.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UiHelper.verticalSpace(height: 30),
                                smallText12(
                                  context,
                                  entry.key,
                                  textColor: const Color(0xff404040),
                                  fontWeight: FontWeight.w500,
                                ),
                                UiHelper.verticalSpace(height: 10),
                                ...entry.value.map((invoiceData) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                        decoration: commonCardDecoration(),
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset('assets/pdfimg.png', height: 31, width: 24),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  smallText12(
                                                    context,
                                                    invoiceData.requestInfo?.requestId ?? '',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  UiHelper.verticalSpace(height: 4),
                                                  smallText12(
                                                    context,
                                                    invoiceData.requestInfo?.workScope ?? '',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 10,
                                                    textColor: const Color(0xff222222),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            MyInkWell(
                                                onTap: ()async{
                                                  String pdfUrl = '$BASEURL/${invoiceData.invoice ?? ''}';
                                                  if(downloadedInvoiceIds.contains(invoiceData.id.toString())){
                                                    UiHelper.toastMessage('Already downloaded');
                                                  }else{
                                                    if (defaultTargetPlatform == TargetPlatform.android) {
                                                      await downloadPDF(pdfUrl,invoiceData.requestInfo?.requestId??'',invoiceData.id??'',);
                                                    }
                                                  }

                                                //  _flutterDownload.downloadMedia(context,pdfUrl);
                                                },
                                              child: downloadingInvoiceIds.contains(invoiceData.id.toString())
                                                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2),):downloadedInvoiceIds.contains(invoiceData.id.toString())
                                                  ? Icon(Icons.check_circle, color: Colors.green) // or your custom asset
                                                  : Image.asset('assets/downarrow.png', height: 19.13, width: 19.13),),

                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  );
                                }),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

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

  Future<void> checkDownloadedInvoices(List<dfrInvoices.Data> invoices) async {
    const downloadsFolderPath = '/storage/emulated/0/Download';
    for (var invoice in invoices) {
      final invoiceId = invoice.id?.toString() ?? '';
      final pdfName = invoice.requestInfo?.requestId ?? '';
      final filePath = '$downloadsFolderPath/$pdfName.pdf';
      final file = File(filePath);
      if (await file.exists()) {
        downloadedInvoiceIds.add(invoiceId);
      }
    }
    setState(() {}); // Update the UI after checking
  }

}
