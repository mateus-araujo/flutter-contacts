import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/android/views/details/views/address.view.dart';
import 'package:contacts/app/android/views/details/views/crop_picture.view.dart';
import 'package:contacts/app/android/views/details/views/details.view.dart';
import 'package:contacts/app/android/views/details/views/take_picture.view.dart';
import 'package:contacts/app/shared/modules/app/app_module.dart';
import 'package:contacts/app/shared/widgets/future_module_loading.dart';

class ContactRoutesAndroid {
  static List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DetailsView(id: args.data['id'])),
    ChildRoute(
      '/address',
      child: (_, args) => AddressView(contact: args.data['contact']),
    ),
    ChildRoute(
      '/take-picture',
      child: (_, args) =>
          FutureModuleLoading<AppModule>(child: TakePictureView()),
    ),
    ChildRoute(
      '/crop-picture',
      child: (_, args) => FutureModuleLoading<AppModule>(
        child: CropPictureView(path: args.data['path']),
      ),
    ),
  ];
}
