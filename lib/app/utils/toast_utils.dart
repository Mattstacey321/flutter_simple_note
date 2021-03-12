import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';

class ToastUtils {
  static const toastAlignment = Alignment(0, 0.8);
  void addNoteSuccess() {
    BotToast.showText(text: "Create note success", align: toastAlignment);
  }

  void addNoteFail() {
    BotToast.showText(text: "Create note fail", align: toastAlignment);
  }

  void removeNoteSuccess(){
    BotToast.showText(text: "Remove note success", align: toastAlignment);
  }

   void removeNoteFail(){
    BotToast.showText(text: "Remove note fail", align: toastAlignment);
  }
}
