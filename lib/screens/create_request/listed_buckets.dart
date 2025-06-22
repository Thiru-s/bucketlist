import 'package:bucket_list_flutter/model/get_all_bucket_response.dart';
import 'package:bucket_list_flutter/model/get_all_bucket_response.dart' as dfrAllBucket;
import 'package:bucket_list_flutter/model/get_bucket_category_response.dart';
import 'package:bucket_list_flutter/screens/create_request/my_bucket.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/bucket_color_reuse.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/bucket_info_dialog.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_search_field.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/empty_list_found.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ListedBuckets extends StatefulWidget {
  final Map<String, dynamic> requestDetails;
  const ListedBuckets({super.key, required this.requestDetails});

  @override
  State<ListedBuckets> createState() => _ListedBucketsState();
}

class _ListedBucketsState extends State<ListedBuckets> {
  final TextEditingController searchController = TextEditingController();
  GetAllBucketResponse getAllBucketResponse = GetAllBucketResponse();
  GetBucketCategoryResponse getBucketCategoryResponse = GetBucketCategoryResponse();

  bool isCategorySelected = false;
  List<dfrAllBucket.Data> displayedBuckets = [];
  List<dfrAllBucket.Data> allBuckets = [];

  List<String> selectedBucketIds = [];


  String? selectedCategoryId;

  @override
  void initState() {
    _getAllBucketApi();
    super.initState();
  }

  Future<void> _getAllBucketApi() async {
    selectedCategoryId = null;
    await BlocProvider.of<BucketListCubit>(context).getAllBucketCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
    //  appBar: CustomAppBar(title: 'Listed Buckets'),
      appBar: CustomAppBar(title: 'Listed Buckets',
          actionWidget:Stack(
            children: [
              MyInkWell(
              onTap: () async {
                print(widget.requestDetails);
                if(selectedBucketIds.isEmpty){
                UiHelper.toastMessage('Please select bucket');
                }else{
                final updatedRequestDetails = {
                ...widget.requestDetails,
                "bucketInfo": allBuckets
                    .where((bucket) => selectedBucketIds.contains(bucket.id))
                    .toList(),
                };
                print("updatedRequestDetails:$updatedRequestDetails");
                final updatedSelectedBuckets = await Navigator.push(
                     context, MaterialPageRoute(
                    builder: (context) => MyBucket(updatedRequestDetails: updatedRequestDetails),),);

                // Update selectedBucketIds after coming back
                if (updatedSelectedBuckets != null && updatedSelectedBuckets is List<dfrAllBucket.Data>) {
                setState(() {
                    selectedBucketIds = updatedSelectedBuckets.map((e) => e.id ?? '').toList();
                    });
                  }
                }
              },
                child: Container(
                    margin: EdgeInsets.only(top: 4,right: 4),
                    child: Image.asset('assets/myBucket.png', width: 28, height: 28)),
              ),
              Positioned(
                top: 0,right: 0,
                child: Container(
                  width: 15, height: 15,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: buttonColor,
                      border: Border.all(color:whiteColor, width: 1,),
                  ),
                  child: Center(child: smallText12(context, '${selectedBucketIds.length}',fontSize: 8,textColor:whiteColor,fontWeight: FontWeight.w500)),
                ),
              )
            ],
          )),
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.getAllBucketSuccess){
            getAllBucketResponse = state.responseData?.response as GetAllBucketResponse;
            allBuckets = getAllBucketResponse.data ?? [];
            displayedBuckets = allBuckets;
            BlocProvider.of<BucketListCubit>(context).getBucketCategoriesCall();
          }
          if (state.status == BucketListStatus.getBucketCategoriesSuccess){
            getBucketCategoryResponse = state.responseData?.response as GetBucketCategoryResponse;
          }
          if (state.status == BucketListStatus.particularBucketCatSuccess){
            getAllBucketResponse = state.responseData?.response as GetAllBucketResponse;
            displayedBuckets = getAllBucketResponse.data ?? [];
            Loader.hide();
          }
          if (state.status == BucketListStatus.particularBucketCatError){
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            Loader.hide();
          }
        },
        builder: (context,state){
          if (state.status == BucketListStatus.getAllBucketLoading || state.status == BucketListStatus.getBucketCategoriesLoading
          ) {
            return  AppLoader();
          }
          if (state.status == BucketListStatus.getAllBucketError || state.status == BucketListStatus.getBucketCategoriesError || state.status == BucketListStatus.particularBucketCatError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getAllBucketApi,
              onRefresh: _getAllBucketApi,
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
                      filterBuckets(value);
                    },
                  ),
                  UiHelper.verticalSpace(height: 18),
                  getBucketCategoryResponse.data!.isEmpty?const SizedBox():
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 10,
                    children: getBucketCategoryResponse.data?.map((category) {
                      final label = category.name ?? '';
                      final Color bucketColor = parseApiColor(category.color);
                      return MyInkWell(
                          onTap: ()async{
                            setState(() {
                              selectedCategoryId = category.id;
                              searchController.clear();
                            });
                            BlocProvider.of<BucketListCubit>(context).particularBucketCatCall(category.id??'');
                            loader(context);
                          },
                          child: BucketColorReuse(label: label, dotColor: bucketColor, isSelected: selectedCategoryId == category.id,));
                    }).toList() ?? [],
                  ),
                  UiHelper.verticalSpace(height: 14),
                  MyInkWell(
                    onTap: ()async{
                      setState(() {
                        selectedCategoryId = 'msa'; // or any unique string
                      });
                      BlocProvider.of<BucketListCubit>(context).particularBucketCatCall(selectedCategoryId??'');
                      loader(context);
                    },
                    child: BucketColorReuse(
                      label: "Signed MSAs",
                      dotColor: textClr,
                      isSelected: selectedCategoryId == 'msa',
                    ),
                  ),
                  UiHelper.verticalSpace(height: 25),
                  // getAllBucketResponse.data!.isEmpty?
                  displayedBuckets.isEmpty?
                  const EmptyListFound(message: 'There is no Bucket list',topHeight: 60,):
                  ListView.builder(
                    //   itemCount: getAllBucketResponse.data?.length,
                    padding: EdgeInsets.zero,
                    itemCount: displayedBuckets.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      //  final bucketData = getAllBucketResponse.data![index];
                      final bucketData = displayedBuckets[index];
                      final Color bucketColor = parseApiColor(bucketData.color);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyInkWell(
                            onTap: () async {
                              setState(() {
                                if (selectedBucketIds.contains(bucketData.id)) {
                                  selectedBucketIds.remove(bucketData.id); // Unselect
                                } else {
                                  selectedBucketIds.add(bucketData.id!); // Select
                                }
                              });
                              print('selectedBucketIds:$selectedBucketIds');
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: selectedBucketIds.contains(bucketData.id)
                                      ? textClr
                                      : Colors.transparent,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:Colors.black.withOpacity(0.15),
                                    offset: const Offset(1, 2),     // X: 1, Y: 2
                                    blurRadius: 5,                  // Blur: 5
                                    spreadRadius: 0,                // Spread: 0
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/bucket.png', height: 50,width: 50,color:bucketColor,),
                                  UiHelper.horizontalSpace(width: 8),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        smallText12(context,capsFirstChar(bucketData.name??''),fontWeight: FontWeight.w500,fontSize:12,textColor: Color(0xff404040)),
                                        UiHelper.verticalSpace(height: 5),
                                        smallText12(context,capsFirstChar(bucketData.description??''),fontWeight: FontWeight.w400,fontSize:10,textColor: Color(0xff404040),maxLines: 2,overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                  UiHelper.horizontalSpace(width: 18),
                                  MyInkWell(
                                      onTap: ()async{
                                        final result = await showDialog<bool>(
                                          context: context,
                                          builder: (context) =>  BucketInfoDialog(
                                            name: bucketData.name??'',
                                            category: bucketData.category?.name??'',
                                            price: bucketData.price??'',
                                            clientName:bucketData.client?.name??'',
                                            clientCompanyName:bucketData.client?.companyName??'',
                                            description:bucketData.description??'',
                                            iconColor: Colors.green,
                                            iconAsset: "assets/bucketlist.png",
                                          ),
                                        );
                                      },
                                      child: Image.asset('assets/informationimg.png', height: 25.5,width: 25.5,)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,)
                        ],
                      );
                    },
                  ),
                  UiHelper.verticalSpace(height: 5),
                  getAllBucketResponse.data!.isEmpty?const SizedBox():
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: brownButton(context: context, labelText: 'next_txt',
                        onTap: () async {
                          print(widget.requestDetails);
                          if(selectedBucketIds.isEmpty){
                            UiHelper.toastMessage('Please select bucket');
                          }else{
                            final updatedRequestDetails = {
                              ...widget.requestDetails,
                              "bucketInfo": allBuckets
                                  .where((bucket) => selectedBucketIds.contains(bucket.id))
                                  .toList(),
                            };
                            print("updatedRequestDetails:$updatedRequestDetails");
                            final updatedSelectedBuckets = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyBucket(updatedRequestDetails: updatedRequestDetails),
                              ),
                            );

                            // Update selectedBucketIds after coming back
                            if (updatedSelectedBuckets != null && updatedSelectedBuckets is List<dfrAllBucket.Data>) {
                              setState(() {
                                selectedBucketIds = updatedSelectedBuckets.map((e) => e.id ?? '').toList();
                              });
                            }
                          }
                        }
                    ),
                  ),
                  UiHelper.verticalSpace(height: 60),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void filterBuckets(String query) {
    final allBuckets = getAllBucketResponse.data ?? [];

    if (query.isEmpty) {
      setState(() {
        displayedBuckets = allBuckets;
      });
    } else {
      final filtered = allBuckets.where((bucket) {
        final name = bucket.name?.toLowerCase() ?? '';
        final description = bucket.description?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) || description.contains(query.toLowerCase());
      }).toList();

      setState(() {
        displayedBuckets = filtered;
      });
    }
  }


}
