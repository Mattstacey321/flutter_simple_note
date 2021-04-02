import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quill/models/documents/nodes/leaf.dart';
import 'package:get/get.dart';

import '../utils/loading_indicator.dart';
import 'circle_icon.dart';
import 'custom_app_bar.dart';

class EmbedBuilder extends StatefulWidget {
  final Embed node;
  final VoidCallback? onRemove;
  EmbedBuilder(this.node, {this.onRemove});
  @override
  _EmbedBuilderState createState() => _EmbedBuilderState();
}

class _EmbedBuilderState extends State<EmbedBuilder> {
  bool isHover = false;
  bool isLeave = false;
  Embed get node => widget.node;

  @override
  Widget build(BuildContext context) {
    switch (node.value.type) {
      case 'image':
        String imageUrl = node.value.data;
        return MouseRegion(
          onEnter: (event) {
            if (event.localDelta.dx.abs() <= 4) {
              setState(() {
                isHover = true;
              });
            }
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              BotToast.showAnimationWidget(
                backgroundColor: Colors.grey.withOpacity(0.2),
                animationDuration: 500.milliseconds,
                onlyOne: true,
                animationReverseDuration: 500.milliseconds,
                wrapToastAnimation: (animation, cancelFunc, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    child: child,
                  );
                },
                toastBuilder: (cancelFunc) {
                  return Scaffold(
                    backgroundColor: Colors.black.withOpacity(0.9),
                    appBar: CustomAppBar(
                      childs: [],
                      onTapBack: () => cancelFunc(),
                      homeIcon: Icon(EvaIcons.close),
                    ),
                    body: Container(
                        height: Get.height,
                        width: Get.width,
                        padding: EdgeInsets.all(20),
                        child: imageUrl.startsWith('http')
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) =>
                                    Center(child: LoadingIndicators().defaultLoading()),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                              )
                            : Image.file(File(imageUrl))),
                  );
                },
              );
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: imageUrl.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              Center(child: LoadingIndicators().defaultLoading()),
                          errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                        )
                      : Image.file(
                          File(imageUrl),
                        ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: widget.onRemove == null ? 0 : (isHover ? 1 : 0),
                    duration: 200.milliseconds,
                    curve: Curves.ease,
                    child: CircleIcon(
                      bgColor: Colors.white,
                      icon: Icon(
                        EvaIcons.close,
                        color: Colors.black,
                        size: 20,
                      ),
                      tooltip: "Remove",
                      onTap: widget.onRemove!,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        throw UnimplementedError(
            'Embeddable type "${node.value.type}" is not supported by default embed '
            'builder of QuillEditor. You must pass your own builder function to '
            'embedBuilder property of QuillEditor or QuillField widgets.');
    }
  }
}

/*Widget embedBuilder(Embed node) {
  
}*/
