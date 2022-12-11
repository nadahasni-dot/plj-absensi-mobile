import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  final String? image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 78,
          height: 78,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(78),
                child: Builder(builder: (context) {
                  if (image == null) {
                    return Image.asset(
                      'assets/images/placeholder-akun.jpg',
                      width: 78,
                      height: 78,
                      fit: BoxFit.cover,
                    );
                  }

                  return CachedNetworkImage(
                    imageUrl: image!,
                    width: 78,
                    height: 78,
                    fit: BoxFit.cover,
                  );
                }),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  'assets/icons/edit-round.svg',
                  width: 26,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
