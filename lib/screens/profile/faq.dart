import 'package:bucket_list_flutter/model/faq_response.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_search_field.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter_html/flutter_html.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  FaqResponse faqResponse = FaqResponse();
  final TextEditingController searchController = TextEditingController();
  List<Data> highPriorityFaqs = [];
  List<Data> lowPriorityFaqs = [];
  List<Data> filteredHighPriorityFaqs = [];
  List<Data> filteredLowPriorityFaqs = [];
  @override
  void initState() {
    _getFaqApi();
    super.initState();
  }

  Future<void> _getFaqApi() async {
    await BlocProvider.of<BucketListCubit>(context).faqCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      appBar: CustomAppBar(title: "FAQ'S"),
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.faqSuccess){
            faqResponse = state.responseData?.response as FaqResponse;
            // Split data into high and low priority
            highPriorityFaqs = faqResponse.data
                ?.where((item) => item.priority?.toLowerCase() == 'high')
                .toList() ?? [];

            lowPriorityFaqs = faqResponse.data
                ?.where((item) => item.priority?.toLowerCase() == 'low')
                .toList() ?? [];

            // Initialize filtered lists to full lists
            filteredHighPriorityFaqs = List.from(highPriorityFaqs);
            filteredLowPriorityFaqs = List.from(lowPriorityFaqs);
          }
          if (state.status == BucketListStatus.faqError){
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){
          if (state.status == BucketListStatus.faqLoading) {return  AppLoader();}
          if (state.status == BucketListStatus.faqError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getFaqApi,
              onRefresh: _getFaqApi,
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchField(
                    hintText: "Search...",
                    controller: searchController,
                    onChanged: filterFaqs,
                  ),
                  UiHelper.verticalSpace(height: 30),
                  largeText16(context, 'Popular topics',fontSize:18,fontWeight: FontWeight.w600),
                  UiHelper.verticalSpace(height: 16),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredHighPriorityFaqs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final faqData = filteredHighPriorityFaqs[index];
                      return Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          minTileHeight: 40,
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          expandedAlignment: Alignment.centerLeft,
                          title: mediumText14(context, faqData.question ?? '', textColor: textClr1, fontWeight: FontWeight.w500),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Html(data: faqData.answer ?? ''),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  UiHelper.verticalSpace(height: 30),
                  largeText16(context, 'Other topics',fontSize:18,fontWeight: FontWeight.w600),
                  UiHelper.verticalSpace(height: 16),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredLowPriorityFaqs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final faqData = filteredLowPriorityFaqs[index];
                      return Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          minTileHeight: 40,
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          expandedAlignment: Alignment.centerLeft,
                          title: mediumText14(context, faqData.question ?? '', textColor: textClr1, fontWeight: FontWeight.w500),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Html(data: faqData.answer ?? ''),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void filterFaqs(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredHighPriorityFaqs = highPriorityFaqs.where((faq) {
        return (faq.question ?? '').toLowerCase().contains(q) ||
            (faq.answer ?? '').toLowerCase().contains(q);
      }).toList();

      filteredLowPriorityFaqs = lowPriorityFaqs.where((faq) {
        return (faq.question ?? '').toLowerCase().contains(q) ||
            (faq.answer ?? '').toLowerCase().contains(q);
      }).toList();
    });
  }

}
