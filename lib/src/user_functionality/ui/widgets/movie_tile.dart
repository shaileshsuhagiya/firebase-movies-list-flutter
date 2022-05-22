import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/app_colors.dart';
import '../../../configs/app_configurations.dart';
import '../../business_logic/models/movie_model.dart';
import 'default_profile_view.dart';


Widget movieListTile(Result data) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
    decoration: const BoxDecoration(boxShadow: [BoxShadow(
      color: Colors.grey,
      blurRadius: 3.0,
    ),], color: AppColor.tileColor,borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 120,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: CachedNetworkImage(
              imageUrl:Config.baseImageUrl+data.backdropPath!,
              imageBuilder: (BuildContext context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
                  ),
                );
              },
              placeholder: (BuildContext context, _) => const DefaultProfilePicture(),
              errorWidget: (BuildContext context, _, __) =>
              const DefaultProfilePicture(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title ?? "-", style: const TextStyle(color: AppColor.textColor,fontSize: 16,  fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),maxLines: 1,),
                  const SizedBox(height: 5,),
                  Text(data.overview ?? "-",maxLines: 3,overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
