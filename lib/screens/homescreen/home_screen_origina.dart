import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: largeText16(context,  'Bucket App',fontSize: 20,fontWeight: FontWeight.bold),
        content: mediumText14(context,  'Do you want to exit the app?'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child:largeText16(context, "No",fontWeight: FontWeight.w600),
                /* child: Text(
                  ,
                  style: TextStyle(color: Colors.black, fontSize: 5.w),
                ),*/
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child:largeText16(context, "Yes",textColor: Colors.red,fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: backgroundclr,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 85,left: 20,right: 20,bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              UiHelper.verticalSpace(height: 20),
              _buildCreateRequestSection(),
              UiHelper.verticalSpace(height: 18),
              _buildTrackAndBillingSection(),
              UiHelper.verticalSpace(height: 18),
              mediumText14(context, 'Activity',fontWeight: FontWeight.w600),
              UiHelper.verticalSpace(height: 4),
              smallText12(context, 'Lorem ipsum dolor sit amet consectetur. Scelerisque consectetur euismod nam. Viverra gravida tincidunt et ac vulputate.',
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  //  final bucket = state.buckketList!.data![index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14.0),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/metalbucket.png', height: 30,width: 30,),
                            UiHelper.horizontalSpace(width: 8),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smallText12(context,"Company Name",fontWeight: FontWeight.w500,fontSize:12),
                                  UiHelper.verticalSpace(height: 6),
                                  smallText12(context,"Request ID",fontWeight: FontWeight.w500,fontSize:10),
                                  UiHelper.verticalSpace(height: 4),
                                  smallText12(context,"Status",fontWeight: FontWeight.w500,fontSize:10),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                smallText12(context,"-",fontWeight: FontWeight.w500,fontSize:12),
                                UiHelper.verticalSpace(height: 8),
                                smallText12(context,"-",fontWeight: FontWeight.w500,fontSize:10),
                                UiHelper.verticalSpace(height: 4),
                                smallText12(context,"-",fontWeight: FontWeight.w500,fontSize:10),
                              ],
                            ),
                            UiHelper.horizontalSpace(width: 18),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smallText12(context,"Thiru",fontWeight: FontWeight.w500,fontSize:12,maxLines: 1,overflow: TextOverflow.ellipsis),
                                  UiHelper.verticalSpace(height: 8),
                                  smallText12(context,"543",fontWeight: FontWeight.w500,fontSize:10),
                                  UiHelper.verticalSpace(height: 4),
                                  smallText12(context,"Pending",fontWeight: FontWeight.w500,fontSize:10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12,)
                    ],
                  );
                },
              )

            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateRequest(),
                ),
              );*/
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(color: Colors.black, width: 5)),
            backgroundColor: Colors.white,
            child: Icon(Icons.add, size: 45, color: btnclr),
          ),
        ),
      ),
    );
  }

////////////create/manages//////////
  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/bucketlist.png',
              height: 75,
              width: 75,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mediumText14(context, "Welcome to",),
                UiHelper.verticalSpace(height: 4,),
                largeText16(context,  "THE BUCKET LIST",fontSize: 18,fontWeight: FontWeight.bold),
              ],
            ),
          ],
        ),
      ],
    );
  }

  ////////////////////track request///////////
  Widget _buildCreateRequestSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => SubscriptionPage(),
            //     ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/requestimg.png', height: 20,width: 20,),
                  const SizedBox(width: 8),
                  mediumText14(context, "Create request/ Manage requests",fontWeight: FontWeight.w500),
                ],
              ),
              UiHelper.verticalSpace(height: 8),
              smallText12(context, 'Upload a bid proposal to be bid out or manage existing requests.'),
              UiHelper.verticalSpace(height: 18),
              brownButton(context: context, labelText: 'Create /Manage',width: 130,height: 27,fontSize: 12,fontWeight: FontWeight.w400,borderRadiusValue:54,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => SubscriptionPage(),
                  //     ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  ///////////////////view billing///////////
  Widget _buildTrackAndBillingSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/trackimg.png',height: 20,width: 20,
                        //   height: 2.h,
                      ),
                      const SizedBox(width: 8),
                      mediumText14(context, "Track Request",fontSize: 14,fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  smallText12(context, "Monitor the status of your requests in real-time",fontSize: 10),
                  UiHelper.verticalSpace(height: 18),
                  brownButton(context: context, labelText: 'Track',width: 80,height: 28,fontSize: 12,fontWeight: FontWeight.w400,borderRadiusValue: 54,
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => BucketList()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/billingimg.png',height: 20,width: 20,
                        //   height: 2.h,
                      ),
                      const SizedBox(width: 8),
                      mediumText14(context, "Billing",fontSize: 14,fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  smallText12(context, "View and manage billing information and invoices.",fontSize: 10),
                  UiHelper.verticalSpace(height: 18),
                  brownButton(context: context, labelText: 'Track',width: 80,height: 28,fontSize: 12,fontWeight: FontWeight.w400,borderRadiusValue: 54,
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ListClient()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
