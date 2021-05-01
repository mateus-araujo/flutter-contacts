import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:contacts/app/android/views/contact_form/contact_form.view.dart';
import 'package:contacts/app/android/views/details/views/address.view.dart';
import 'package:contacts/app/android/views/details/views/crop_picture.view.dart';
import 'package:contacts/app/android/views/details/views/details.view.dart';
import 'package:contacts/app/android/views/details/views/take_picture.view.dart';
import 'package:contacts/app/android/views/home/home.view.dart';
import 'package:contacts/app/navigation/routes.dart';

class Navigation {
  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.address:
        return _buildRoute(settings, AddressView());
      case Routes.cropPicture:
        final args = settings.arguments as Map;
        return _buildRoute(settings, CropPictureView(path: args['path']));
      case Routes.contactForm:
        final args = settings.arguments as Map;
        return _buildRoute(settings, ContactFormView(model: args['model']));
      case Routes.details:
        final args = settings.arguments as Map;
        return _buildRoute(settings, DetailsView(id: args['id']));
      case Routes.home:
        return _buildRoute(settings, HomeView());
      case Routes.takePicture:
        return _buildRoute(settings, TakePictureView());
      default:
        throw 'Route ${settings.name} is not defined';
    }
  }

  PageRoute _buildRoute(RouteSettings settings, Widget builder) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (BuildContext context) => builder,
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) => builder,
        settings: settings,
      );
    }
  }
}
