import 'package:flutter/cupertino.dart';

export 'package:date_format/date_format.dart';
export 'package:dio/dio.dart';
export 'package:myexercises/page/cart_page.dart';

export '../components/circle_progress_barPainter.dart';
export '../model/netImageModel.dart';
export '../model/one_model.dart';
export '../page/chat.dart';
export '../page/chat_entry_page.dart';
export '../page/click_test_page.dart';
export '../page/clock_page.dart';
export '../page/expandable_text_page.dart';
export '../page/expandable_text_page.dart';
export '../page/floating_player_page.dart';
export '../page/star_page.dart';
export '../page/swiper_page.dart';
export '../page/test_page.dart';

TextStyle textStyle(
    {Color color, double size = 10, FontWeight weight = FontWeight.w400}) {
  return TextStyle(
      color: color != null ? color : Color(0xffd9d9d9).withOpacity(0.5),
      fontWeight: weight,
      fontSize: size);
}
