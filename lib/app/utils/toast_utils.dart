import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static const toastAlignment = Alignment(0, 0.8);
  void addNoteSuccess() {
    BotToast.showText(text: "Create note success", align: toastAlignment);
  }

  void addNoteFail({String? message}) {
    BotToast.showText(text: message == null ? "Create note fail" : message, align: toastAlignment);
  }

  void removeNoteSuccess() {
    BotToast.showText(text: "Remove note success", align: toastAlignment);
  }

  void removeNoteFail() {
    BotToast.showText(text: "Remove note fail", align: toastAlignment);
  }

  void updateNoteSuccess() {
     BotToast.showText(text: "Update note success", align: toastAlignment);
  }

  void updateNoteFail() {
    BotToast.showText(text: "Can not update", align: toastAlignment);
  }

  void addFolderSuccess() {
    BotToast.showText(text: "Add folder success", align: toastAlignment);
  }

  void addFolderFail() {
    BotToast.showText(text: "Add folder fail", align: toastAlignment);
  }

  void updateFolderSuccess() {
    BotToast.showText(text: "Update folder success", align: toastAlignment);
  }

  void updateFolderFail(){
    BotToast.showText(text: "Can not update folder", align: toastAlignment);
  }

  void removeFolderSuccess(){
    BotToast.showText(text: "Remove folder success", align: toastAlignment);
  }

  void removeFolderFail(){
    BotToast.showText(text: "Remove folder fail", align: toastAlignment);
  }
  
}
