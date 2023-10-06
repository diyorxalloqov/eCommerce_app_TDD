import 'package:ecommerce_app_with_tdd/core/constants/extensions/size.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/data/repository/eCommerceRepositoryImpl.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/domain/usecase/eCommerceUseCase.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/presentation/cubit/e_commerce/e_commerce_cubit.dart';
import 'package:ecommerce_app_with_tdd/utils/enum.dart';
import 'package:ecommerce_app_with_tdd/utils/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late ECommerceCubit eCommerceCubit;

  @override
  void initState() {
    eCommerceCubit = ECommerceCubit(GetEcommerceUseCase(
        repo: RepositoryProvider.of<ECommerceRepositoryImpl>(context)))
      ..getdatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: eCommerceCubit,
      child: BlocListener<ECommerceCubit, EcommerceState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        },
        listenWhen: (state1, state2) {
          return state2.status == ActionStatus.isError;
        },
        child: BlocBuilder<ECommerceCubit, EcommerceState>(
          builder: (context, state) {
            if (state.status == ActionStatus.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state.status == ActionStatus.isSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${state.data.length}+ Iteams ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 61.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [Text("Sort"), Icon(Icons.swap_vert)],
                              ),
                            ),
                            addWidth(12.w),
                            Container(
                              width: 61.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Filter"),
                                  Icon(Icons.filter_alt_outlined)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    addHeigth(17.h),
                    Expanded(
                      child: GridView.builder(
                        itemCount: state.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 16.h,
                            crossAxisCount: 2,
                            mainAxisExtent: 245,
                            childAspectRatio: 245 / 165,
                            crossAxisSpacing: 16),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Image.network(
                                  state.data[index].image.toString(),
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.data[index].title.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.clip,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      addHeigth(4.h),
                                      Text(
                                        state.data[index].description
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      addHeigth(4.h),
                                      Text(
                                          "${state.data[index].currencySymbol}${state.data[index].price}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      addHeigth(4.h),
                                      SizedBox(
                                          height: context.heigth * 0.025,
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: List.generate(
                                                    state.data[index].rating!
                                                        .toInt(),
                                                    (index) => InkWell(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.star,
                                                          size: 18.sp,
                                                          color: Colors.orange,
                                                        ))),
                                              ),
                                              addWidth(4.w),
                                              Text(state.data[index].rating
                                                  .toString())
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("xatolik ${state.error}"),
              );
            }
          },
        ),
      ),
    );
  }
}
