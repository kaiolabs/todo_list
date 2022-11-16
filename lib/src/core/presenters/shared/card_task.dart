import 'package:flutter/material.dart';
import 'package:todo_list/src/core/presenters/functions/functions.dart';
import 'package:todo_list/src/core/presenters/shared/favorited_button.dart';
import 'package:todo_list/src/core/presenters/shared/tag_card.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';

import '../theme/font_family_outlet.dart';

class CardTask extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String date;
  final String priority;
  final String category;
  final String status;
  final BaseController baseController;
  final Function()? onTap;
  const CardTask(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.priority,
      required this.category,
      required this.onTap,
      required this.status,
      required this.id,
      required this.baseController});

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  Color color = ColorOutlet.colorCardGreen;
  ValueNotifier<bool> isFavorited = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    if (widget.status != 'done') {
      if (int.parse(widget.date) < 2) {
        color = ColorOutlet.colorCardRed;
      } else if (int.parse(widget.date) < 4) {
        color = ColorOutlet.colorCardYellow;
      } else if (int.parse(widget.date) > 7) {
        color = ColorOutlet.colorCardGreen;
      }
    } else {
      color = ColorOutlet.colorCardGreen;
    }
    DB.checkFavorite(widget.id).then((value) {
      isFavorited.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SizeOutlet.paddingSizeMedium),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
          ),
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
              onTap: widget.onTap ?? () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeOutlet.paddingSizeDefault, vertical: SizeOutlet.paddingSizeDefault),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: SizeOutlet.paddingSizeSmall),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.82,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    widget.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: ColorOutlet.colorPrimary,
                                      fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                                      fontSize: SizeOutlet.textSizeSmall1,
                                    ),
                                  ),
                                ),
                                FavoritedButton(
                                  isFavorited: isFavorited,
                                  size: SizeOutlet.iconSizeDefault,
                                  onTap: () async {
                                    isFavorited.value = !isFavorited.value;
                                    DB.setFavorite(
                                      id: widget.id,
                                      favorite: isFavorited.value,
                                    );
                                    DB.getTaskFavorite().then((value) {
                                      widget.baseController.tasksFavorite.value = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.82,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: SizeOutlet.paddingSizeSmall),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: SizeOutlet.paddingSizeSmall),
                                          child: TagCard(
                                            title: widget.category,
                                            icon: Icon(
                                              Functions.categoryIcon(widget.category),
                                              color: ColorOutlet.colorPrimaryLight,
                                              size: SizeOutlet.iconSizeMicro,
                                            ),
                                          ),
                                        ),
                                        TagCard(
                                          title: widget.priority,
                                          icon: const Icon(
                                            Icons.priority_high,
                                            color: ColorOutlet.colorPrimaryLight,
                                            size: SizeOutlet.iconSizeMicro,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeSmall)),
                                      border: Border.fromBorderSide(BorderSide(color: color)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: SizeOutlet.paddingSizeSmall,
                                        vertical: SizeOutlet.paddingSizeMicro,
                                      ),
                                      child: Text(
                                        (widget.status != 'done')
                                            ? (int.parse(widget.date) > 0)
                                                ? 'Expires in ${widget.date} days'
                                                : 'Expired in ${widget.date.replaceAll('-', '')} days'
                                            : 'Task completed',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: color,
                                          fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                          fontSize: SizeOutlet.textSizeMicro1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: SizeOutlet.paddingSizeDefault),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.09,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeSmall)),
                                    border: Border.fromBorderSide(BorderSide(color: ColorOutlet.colorPrimaryLight)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: SizeOutlet.paddingSizeSmall,
                                      vertical: SizeOutlet.paddingSizeMicro,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(bottom: SizeOutlet.paddingSizeSmall),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: ColorOutlet.colorPrimaryLight,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'Description',
                                            style: TextStyle(
                                              color: ColorOutlet.colorPrimaryLight,
                                              fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                              fontSize: SizeOutlet.textSizeMicro1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.description,
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: ColorOutlet.colorPrimaryLight,
                                            fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                            fontSize: SizeOutlet.textSizeMicro1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
