
import 'package:bucket_list_flutter/model/terms_and_conditions_response.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsCondition extends StatefulWidget {
  final String title;
  const TermsCondition({super.key, required this.title});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  TermsAndConditionsResponse termsAndConditionsResponse = TermsAndConditionsResponse();
  List<Data> termsData = [];
  @override
  void initState() {
    _getTermsAndCondApi();
    super.initState();
  }

  Future<void> _getTermsAndCondApi() async {
    await BlocProvider.of<BucketListCubit>(context).termsAndConditionsCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      appBar: CustomAppBar(title: widget.title),
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.termsAndConditionsSuccess){
            termsAndConditionsResponse = state.responseData?.response as TermsAndConditionsResponse;
            termsData = termsAndConditionsResponse.data ?? [];
            if(widget.title == "Terms and Conditions"){
              termsData.removeAt(0);
            }else if(widget.title == "Privacy Policy"){
              termsData.removeAt(1);
            }
          }
          if (state.status == BucketListStatus.termsAndConditionsError){
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){



          if (state.status == BucketListStatus.termsAndConditionsLoading) {return  AppLoader();}
          if (state.status == BucketListStatus.termsAndConditionsError || state.status == BucketListStatus.getBucketCategoriesError || state.status == BucketListStatus.particularBucketCatError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getTermsAndCondApi,
              onRefresh: _getTermsAndCondApi,
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: termsAndConditionsResponse.data?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      //  final bucket = state.buckketList!.data![index];
                      final termsData = termsAndConditionsResponse.data![index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText14(context, termsData.type??'',fontSize:25,fontWeight: FontWeight.bold,),
                          Html(
                            data: termsData.content??'' ,//state.response?.data?[1].content??'',
                          ),
                          const SizedBox(height: 12,)
                        ],
                      );
                    },
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
