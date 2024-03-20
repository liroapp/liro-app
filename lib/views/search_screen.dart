import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/components/input_fields.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_spacings.dart';

class SearchScreen extends StatelessWidget {
  final bool isFromLocation;
  SearchScreen({super.key, required this.isFromLocation});

  final _fromController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.searchScreenBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<LocationBloc, LocationState>(
              listener: (context, state) {},
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CustomInputField(
                  fieldIcon: Icons.gps_fixed_sharp,
                  borderColor: Colors.transparent,
                  focusedborderColor: Colors.transparent,
                  bgColor: AppColors.darkPrimaryColor,
                  hintText: isFromLocation
                      ? 'Choose start location'
                      : 'Choose destination',
                  controller: _fromController,
                  autofocus: true,
                  onChanged: (searchTerm) {
                    context
                        .read<LocationBloc>()
                        .add(SearchLocationEvent(searchTerm: searchTerm));
                  },
                ),
              ),
            ),
            AppSpaces.verticalspace5,
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state is LocationSearchErrorState) {
                  return Center(child: Text(state.error));
                } else if (state is LocationSearchSuccessState) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: state.fromPredictions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: Colors.grey.shade600, width: .5)),
                          child: SvgPicture.asset(
                            AppAssets.destinationIcon,
                            width: 20,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ),
                        title:
                            Text(state.fromPredictions[index]['description']),
                        onTap: () {
                          context.read<LocationBloc>().add(
                                LocationCoordinatesEvent(
                                    placeId: state.fromPredictions[index]
                                        ['place_id'],
                                    isFromCoordinates: isFromLocation),
                              );

                          Navigator.of(context).pop();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey.shade800,
                        height: 8,
                        thickness: .2,
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
