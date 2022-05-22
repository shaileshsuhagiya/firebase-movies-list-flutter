import 'package:flutter/material.dart';

class DefaultProfilePicture extends StatelessWidget {
  final FileImage? fileImage;

   const DefaultProfilePicture({Key? key, this.fileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        /*image: DecorationImage(
            fit: BoxFit.contain,
            image: (fileImage ?? const AssetImage("")) as ImageProvider<Object>),*/
      ),
    );
  }
}
