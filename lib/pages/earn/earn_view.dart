import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/pages/earn/earn_controller.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_summary_item_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_date_util.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class EarnView extends StatefulWidget {
  const EarnView({super.key});

  @override
  State<EarnView> createState() => _EarnViewState();
}

class _EarnViewState extends State<EarnView> with TickerProviderStateMixin {
  final AppService appService = Get.find<AppService>();
  final EarnController controller = Get.put(EarnController());
  // bool _isFirstLoad = true;
  late List<Tab> tabs;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabs = [
      Tab(text: appService.getTrans('My Orders')),
      Tab(text: appService.getTrans('My Earnings')),
    ];
    // _isFirstLoad = appService.firstLoad['earn']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['earn'] = false;
    });

    _tabController = TabController(
        length: tabs.length,
        vsync: this,
        initialIndex: appService.initEarnTabIndex);

    controller.getOrderList();
    controller.getOrderLogList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Gap(30.h),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              physics: const ClampingScrollPhysics(),
              indicatorSize: TabBarIndicatorSize.label,
              tabAlignment: TabAlignment.start,
              labelStyle:
                  TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
              indicator: null,
              labelColor: AppColors.fontPrimary,
              indicatorColor: AppColors.buttonBackground,
              tabs: tabs,
              onTap: (value) {
                print('onTab = ${value}');
                if (value == 0) {
                  controller.getOrderList();
                } else {
                  controller.getOrderLogList();
                }
              },
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _myOrderWidget(),
                  _myEarningsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myOrderWidget() {
    return Obx(() {
      if (controller.isLoading1.value) return const SizedBox();

      return ListView.builder(
        itemCount: (controller.orderList.value?.data ?? []).length,
        itemBuilder: (BuildContext context, int index) {
          OrderModel item = controller.orderList.value!.data[index];
          return _getOrderItem(item);
        },
      );
    });
  }

  Widget _myEarningsWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          Obx(
            () => Row(
              children:
                  List.generate(controller.myEarningTabs.value.length, (index) {
                final item = controller.myEarningTabs.value[index];
                return EarnSummaryItemWidget(
                    index: index,
                    prize: item.price,
                    icon: item.icon,
                    label: appService.getTrans(item.label),
                    isSelected: item.id == controller.earningIndex.value,
                    onPressed: () {
                      controller.earningIndex.value = index;
                      // filter ui
                    });
              }),
            ),
          ),
          SizedBox(
            height: 250.h,
            child: DateScroller(),
          ),
          Obx(() {
            return Expanded(
              child: controller.isLoading2.value
                  ? const SizedBox()
                  : ListView.builder(
                      itemCount: controller.orderLogs.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _getOrderLogItem(
                            controller.orderLogs.value[index]);
                      },
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget _getOrderItem(OrderModel item) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            color: AppColors.cardBackground),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${appService.getTrans('No ')} ${item.orderNo}',
                  style: TextStyle(
                      color: AppColors.fontPrimary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: item.fast == -1
                          ? AppColors.buttonBackground
                          : AppColors.level,
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Text(
                      appService.getTrans(
                          item.fast == -1 ? 'Not Awarded' : 'Awarded'),
                      style: TextStyle(
                          color: AppColors.fontPrimary, fontSize: 15.sp)))
            ]),
            if (double.parse(item.orderAmount) != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppImage.asset('earn/coins1.png', width: 40.w),
                      Gap(10.w),
                      Text(appService.getTrans('Earnings'),
                          style: TextStyle(
                              color: AppColors.fontPrimary, fontSize: 18.sp)),
                      Gap(20.w),
                      item.status == 0
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.fontSecondary,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(20.w)),
                              child: Text(appService.getTrans("Unsettled"),
                                  style: TextStyle(
                                      color: AppColors.fontSecondary,
                                      fontSize: 15.sp)))
                          : double.parse(item.orderAmount) > 0
                              ? Text(
                                  '+${double.parse(item.orderAmount).toPrecision(4)} USDT',
                                  style: TextStyle(
                                      color: AppColors.fontMenu3,
                                      fontSize: 15.sp))
                              : Text('${item.orderAmount} USDT',
                                  style: TextStyle(
                                      color: AppColors.font3, fontSize: 15.sp))
                    ],
                  ),
                  double.parse(item.outAmount) != 0
                      ? Container()
                      : Text(
                          item.updateAt != null
                              ? AppDateUtil.YMdhms(item.updateAt ?? 0)
                              : AppDateUtil.YMdhms(item.createdAt),
                          style: TextStyle(
                              color: AppColors.fontSecondary, fontSize: 15.sp),
                          textAlign: TextAlign.right,
                        )
                ],
              ),
            if (double.parse(item.outAmount) != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppImage.asset('earn/coins2.png', width: 40.w),
                      Gap(10.w),
                      Text(appService.getTrans('Blessing Earnings'),
                          style: TextStyle(
                              color: AppColors.fontPrimary, fontSize: 18.sp)),
                      Gap(20.w),
                      item.status == 0
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.fontSecondary,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(20.w)),
                              child: Text(appService.getTrans("Unsettled"),
                                  style: TextStyle(
                                      color: AppColors.fontSecondary,
                                      fontSize: 15.sp)))
                          : double.parse(item.outAmount) > 0
                              ? Text(
                                  '+${double.parse(item.outAmount).toPrecision(4)} USDT',
                                  style: TextStyle(
                                      color: AppColors.fontMenu3,
                                      fontSize: 15.sp))
                              : Text('${item.orderAmount} USDT',
                                  style: TextStyle(
                                      color: AppColors.font3, fontSize: 15.sp))
                    ],
                  ),
                  Text(
                    item.updateAt != null
                        ? AppDateUtil.YMdhms(item.updateAt ?? 0)
                        : AppDateUtil.YMdhms(item.createdAt),
                    style: TextStyle(
                        color: AppColors.fontSecondary, fontSize: 15.sp),
                    textAlign: TextAlign.right,
                  )
                ],
              )
          ],
        ));
  }

  Widget _getOrderLogItem(OrderLogModel item) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            color: AppColors.cardBackground),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              (item.type) > 1
                  ? AppImage.asset('earn/dividend.png', width: 50.w)
                  : AppImage.asset('earn/burn_gains.png', width: 50.w),
              Gap(10.w),
              Text(appService.getTrans((item.type) > 1 ? "Dividend" : "Burn"),
                  style:
                      TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp))
            ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('+${item.outAmount} USDT',
                      style: TextStyle(
                          color: AppColors.fontMenu3, fontSize: 18.sp)),
                  Gap(5.h),
                  Text(AppDateUtil.YMdhms(item.createdAt),
                      style: TextStyle(
                          color: AppColors.fontSecondary, fontSize: 18.sp))
                ])
          ],
        ));
  }
}

class DateScroller extends StatelessWidget {
  final List<String> days = ["26", "27", "28", "29", "30", "31", "1"];
  final int selectedIndex = 3; // Assume "29" is selected

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // The curved line
          Positioned.fill(
            child: CustomPaint(
              painter: CurvePainter(selectedIndex: selectedIndex),
            ),
          ),
          // The date list
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (index == selectedIndex)
                        Text(
                          "JAN",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      SizedBox(height: 5),
                      CircleAvatar(
                        backgroundColor: index == selectedIndex
                            ? Colors.blueAccent
                            : Colors.transparent,
                        child: Text(
                          days[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final int selectedIndex;

  CurvePainter({required this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    // Start point
    path.moveTo(0, size.height / 2);
    // Control points and curve drawing
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.2,
        size.width, size.height * 0.5);

    canvas.drawPath(path, paint);

    // Draw the selected point circle
    final circleX = (size.width / 6) * selectedIndex + size.width * 0.05;
    final circleY = size.height * 0.5;

    canvas.drawCircle(Offset(circleX, circleY), 8, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}