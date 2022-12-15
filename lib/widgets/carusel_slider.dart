import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/comments.dart';

class CarouselSliderImage extends StatelessWidget {
  final List imagesList;

  const CarouselSliderImage({super.key, required this.imagesList});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsFileUploadCubit, bool>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
            child: Text(
              'Фото пользователей',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF165932),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.only(right: 4),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute(index));
                    },
                    child: (imagesList[index].contains('assets')
                        ? Image.asset(imagesList[index], fit: BoxFit.cover, width: 80, height: 45)
                        : Image.file(
                            File(imagesList[index]),
                            fit: BoxFit.cover,
                            width: 80,
                            height: 45,
                          ))),
              ),
              itemCount: imagesList.length,
            ),
          )
        ],
      ),
    );
  }

  Route _createRoute(index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OpenCarousel(index: index, imagesList: imagesList),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

// Слайдер на весь экран
class OpenCarousel extends StatelessWidget {
  final List imagesList;
  final int index;

  const OpenCarousel({super.key, this.index = 0, required this.imagesList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          mini:true,
          backgroundColor: Colors.white30,
          onPressed: () => context.router.pop(),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          )),
      //appBar: AppBar(),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            initialPage: index,
            enableInfiniteScroll: false,
            //height: MediaQuery.of(context).size.height,
            viewportFraction: 1,
          ),
          items: imagesList
              .map(
                (item) => GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Center(
                    child: (item.contains('assets')
                        ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                            child: Image.asset(
                              item,
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                            ))
                        : Image.file(
                            File(item),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          )),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
