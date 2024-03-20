import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liro/blocs/location_bloc/location_bloc.dart';
import 'package:liro/resources/assets/app_assets.dart';
import 'package:liro/resources/components/info_box.dart';
import 'package:liro/resources/constants/app_paddings.dart';
import 'package:liro/resources/constants/app_spacings.dart';

class InfoArea extends StatelessWidget {
  const InfoArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.fullpadding10,
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationSelectedState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InfoBox(
                    info: state.distance ?? '_ _',
                    icon: AppAssets.carIcon,
                  ),
                ),
                AppSpaces.horizontalspace10,
                Expanded(
                  child: InfoBox(
                    info: state.duration ?? '_ _',
                    icon: AppAssets.timeIcon,
                  ),
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InfoBox(
                    info: '_ _',
                    icon: AppAssets.carIcon,
                  ),
                ),
                AppSpaces.horizontalspace10,
                Expanded(
                  child: InfoBox(
                    info: '_ _',
                    icon: AppAssets.timeIcon,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

