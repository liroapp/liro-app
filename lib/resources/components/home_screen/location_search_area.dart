import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_fonts.dart';
import 'package:liro/resources/constants/app_spacings.dart';
import 'package:liro/views/search_screen.dart';

class LocationSearchArea extends StatelessWidget {
  const LocationSearchArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            height: MediaQuery.of(context).size.height * .16,
            decoration: BoxDecoration(
                color: AppColors.darkPrimaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .20 - 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            AppAssets.originIcon,
                            height: 24,
                            width: 24,
                          ),
                          SvgPicture.asset(
                            AppAssets.dashIcon,
                            height: 30,
                            width: 30,
                          ),
                          SvgPicture.asset(
                            AppAssets.destinationIcon,
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppSpaces.horizontalspace10,
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .80 - 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(isFromLocation: true),
                                    ));
                                  },
                                  child:
                                      BlocBuilder<LocationBloc, LocationState>(
                                    builder: (context, state) {
                                      if (state is LocationSelectedState &&
                                          state.fromLocation.isNotEmpty) {
                                        return Text(
                                          state.fromLocation,
                                          style: AppFonts.greyText16,
                                        );
                                      } else {
                                        return const Text(
                                          'Select from location',
                                          style: AppFonts.greyText12,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.whiteColor.withOpacity(.1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(isFromLocation: false),
                                    ));
                                  },
                                  child:
                                      BlocBuilder<LocationBloc, LocationState>(
                                    builder: (context, state) {
                                      if (state is LocationSelectedState &&
                                          state.toLocation.isNotEmpty) {
                                        return Text(
                                          state.toLocation,
                                          style: AppFonts.greyText16,
                                        );
                                      } else {
                                        return const Text(
                                          'Select to location',
                                          style: AppFonts.greyText12,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<LocationBloc>()
                                      .add(LocationGetDirectionsEvent());
                                },
                                child: const Icon(
                                  Icons.directions,
                                  size: 32,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.primaryColor,
            thickness: 3,
            height: 0,
            indent: 0,
          ),
        ],
      ),
    );
  }
}
