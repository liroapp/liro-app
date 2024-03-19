import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/components/input_fields.dart';
import 'package:liro/resources/constants/app_colors.dart';
import 'package:liro/resources/constants/app_paddings.dart';
import 'package:liro/resources/constants/app_spacings.dart';

class SearchScreen extends StatelessWidget {
  final bool isFromLocation;
  SearchScreen({super.key, required this.isFromLocation});

  final _fromController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocListener<LocationBloc, LocationState>(
              listener: (context, state) {},
              child: CustomInputField(
                fieldIcon: Icons.gps_fixed_sharp,
                borderColor: Colors.transparent,
                bgColor: AppColors.darkPrimaryColor,
                
                hintText: isFromLocation
                    ? 'Choose start location'
                    : 'Choose destination',
                controller: _fromController,
                onChanged: (searchTerm) {
                  context
                      .read<LocationBloc>()
                      .add(SearchLocationEvent(searchTerm: searchTerm));
                },
              ),
            ),
            AppSpaces.verticalspace20,
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state is LocationSearchErrorState) {
                  return Center(child: Text(state.error));
                } else if (state is LocationSearchSuccessState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.fromPredictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
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
