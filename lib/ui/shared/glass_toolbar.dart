import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlassToolBar extends StatelessWidget implements PreferredSize {
  const GlassToolBar({
    Key? key,
    required this.backArrowFunction,
    required this.avatar,
  }) : super(key: key);

  final void Function() backArrowFunction;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          height: 52.0 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            right: 8.0,
            top: MediaQuery.of(context).padding.top,
          ),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 24.0,
                spreadRadius: -8.0,
              )
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.white54, Colors.white30, Colors.white24],
            ),
            border: Border.all(width: 2.0, color: Colors.white30),
          ),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: backArrowFunction,
                icon: const Icon(Icons.arrow_back),
                splashRadius: 16.0,
              ),
              const IconButton(
                onPressed: null,
                iconSize: 24.0,
                disabledColor: Colors.transparent,
                icon: Icon(Icons.info_outline),
                splashRadius: 16.0,
              ),
              Expanded(
                child: Text(
                  'Dreavy',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    splashRadius: 16.0,
                  ),
                  Hero(
                    tag: 'picture',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60, width: 2.0),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              avatar != null && avatar!.isNotEmpty ? 0.0 : 4.0,),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(64.0),
                            child: GestureDetector(
                              onTap: () => GoRouter.of(context).push('/profile'),
                              child: avatar != null && avatar!.isNotEmpty
                                  ? ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(16.0),
                                        child: Image.memory(
                                          base64Decode(avatar!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : const Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
