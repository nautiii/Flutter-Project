import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlassToolBar extends StatelessWidget implements PreferredSize {
  const GlassToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          height: 48.0 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
              right: 8.0, top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 24.0,
                spreadRadius: -8.0,
              )
            ],
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white54, Colors.white30, Colors.white24]),
            border: Border.all(width: 2.0, color: Colors.white30),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              IconButton(
                  onPressed: () => GoRouter.of(context).go('/login'),
                  icon: const Icon(Icons.arrow_back),
                  splashRadius: 16.0),
              const IconButton(
                  onPressed: null,
                  iconSize: 24.0,
                  disabledColor: Colors.transparent,
                  icon: Icon(Icons.info_outline),
                  splashRadius: 16.0),
              Expanded(
                child: Text('Dreavy',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      splashRadius: 16.0),
                  Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60, width: 2.0),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(64.0),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.person),
                          ),
                        ),
                      )),
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
  Size get preferredSize => const Size.fromHeight(56.0);
}
