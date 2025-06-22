import 'package:bucket_list_flutter/model/faq_response.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_search_field.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  FaqResponse faqResponse = FaqResponse();
  final TextEditingController searchController = TextEditingController();
  final List otherTopicData = ['My Profile updates','Account information','Balance & transitions','Stocks / Investment account','Payment problem','Taxation queries','Query not listed'];

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
                    onChanged: (value) {
                      //  filterBuckets(value);
                    },
                  ),
                  UiHelper.verticalSpace(height: 30),
                  mediumText14(context, 'Popular topics',fontWeight: FontWeight.w500),
                  UiHelper.verticalSpace(height: 16),
                  ListView.builder(
                    itemCount: faqResponse.data?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      //  final bucket = state.buckketList!.data![index];
                      final faqData = faqResponse.data![index];

                      return ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        expandedAlignment:Alignment.centerLeft,
                        title: smallText12(context, faqData.question ?? '', textColor: textClr1),
                        children: [
                          smallText12(context, faqData.answer ?? '', textColor: textClr1)
                        ],
                      );

                      /*return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: smallText12(context, faqData.question??'', textColor: textClr1,),),
                              UiHelper.horizontalSpace(width: 8),
                              Image.asset('assets/arrowright.png',height: 25,width: 25,),
                            ],
                          ),
                          const SizedBox(height: 10,)
                        ],
                      );*/
                    },
                  ),
                  Divider(thickness: 0.5,color: textClr,),
                  UiHelper.verticalSpace(height: 6),
                  mediumText14(context, 'Other topics',fontWeight: FontWeight.w500),
                  UiHelper.verticalSpace(height: 16),
                  ListView.builder(
                    itemCount: otherTopicData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      //   final termsData = termsAndConditionsResponse.data![index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: smallText12(context, otherTopicData[index], textColor: textClr1,),
                              ),
                              UiHelper.horizontalSpace(width: 8),
                              Image.asset('assets/arrowright.png',height: 25,width: 25,),
                            ],
                          ),
                          const SizedBox(height: 6,)
                        ],
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
}
