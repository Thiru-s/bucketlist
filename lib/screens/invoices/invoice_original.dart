import 'package:bucket_list_flutter/model/get_invoice_list_response.dart';
import 'package:bucket_list_flutter/model/get_invoice_list_response.dart' as dfrInvoices;
import 'package:bucket_list_flutter/screens/reusable_widgets/common_decoration.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_search_field.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/time_rule.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

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
          listener: (context,state){
            print("state.status:${state.status}");
            if (state.status == BucketListStatus.getInvoiceListSuccess){
              showLoader = false;
              getInvoiceListResponse = state.responseData?.response as GetInvoiceListResponse;
              allInvoice = getInvoiceListResponse.data ?? [];
              filteredInvoice = allInvoice; // Initialize with all data
              for (var invoice in filteredInvoice) {
                final createdAt = invoice.createdAt ?? ''; // Assuming `createdAt` is in the model
                final label = TimeRule.formatInvoiceDate(createdAt);
                groupedInvoices.putIfAbsent(label, () => []).add(invoice);
              }
              print('groupedInvoices:$groupedInvoices');
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
                child: Column(
                  children: [
                    CustomSearchField(
                      hintText: "Search...",
                      controller: searchController,
                      borderColor: textClr,
                      fieldColor: backgroundclr,
                      showBoxShadow:false,
                      onChanged: (value) {
                        setState(() {
                          filteredInvoice = allInvoice.where((invoice) {
                            final query = value.toLowerCase();
                            final requestId = invoice.requestInfo?.requestId?.toLowerCase() ?? '';
                            final workScope = invoice.requestInfo?.workScope?.toLowerCase() ?? '';
                            return requestId.contains(query) || workScope.contains(query);
                          }).toList();
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
                                            Image.asset('assets/downarrow.png', height: 19.13, width: 19.13),
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
                        /* child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UiHelper.verticalSpace(height: 15),
                            smallText12(context, 'Today',textColor: Color(0xff404040),fontWeight: FontWeight.w500),
                            UiHelper.verticalSpace(height: 10),
                            ListView.builder(
                              padding: EdgeInsets.only(left: 1,right: 1),
                              itemCount: filteredInvoice.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final invoiceData = filteredInvoice[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:  EdgeInsets.only(left:16,right:16,top: 14,bottom: 14),
                                      decoration: commonCardDecoration(),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset('assets/pdfimg.png',height: 31,width: 24,),
                                          const SizedBox(width: 8,),
                                          Expanded( // add this
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min, // set it to min
                                              children: <Widget>[
                                                smallText12(context, invoiceData.requestInfo?.requestId??'',fontWeight: FontWeight.w500),
                                                UiHelper.verticalSpace(height: 4),
                                                smallText12(context,invoiceData.requestInfo?.workScope??'',maxLines:2,overflow:TextOverflow.ellipsis,
                                                    fontSize: 10,textColor: Color(0xff222222)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 6,),
                                          Image.asset('assets/downarrow.png',height: 19.13,width: 19.13,),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12,)
                                  ],
                                );
                              },
                            ),
                            UiHelper.verticalSpace(height: 15),
                          ],
                        ),*/
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
}
