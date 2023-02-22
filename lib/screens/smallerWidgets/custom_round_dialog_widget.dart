import 'package:flutter/material.dart';

class CustomRoundDialogWidget extends StatefulWidget {
  final String displayedText;
  final Widget dialogContentWidget;
  final double submitFontSize;
  final Function? submitFunction;
  final Function(String)? updateFunction;
  final String submitText;
  final bool onlyCloseOption;
  final String closeText;
  final String documentID;
  final double? horizontalPadding;
  final bool noPadding;

  CustomRoundDialogWidget({
    required this.displayedText,
    required this.dialogContentWidget,
    this.submitFontSize = 15,
    this.submitFunction,
    this.noPadding = false,
    this.documentID = '',
    this.updateFunction,
    this.horizontalPadding,
    this.submitText = 'Confirm',
    this.onlyCloseOption = false,
    this.closeText = 'Cancel',
  });

  @override
  _CustomRoundDialogWidgetState createState() =>
      _CustomRoundDialogWidgetState();
}

class _CustomRoundDialogWidgetState extends State<CustomRoundDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding != null
                ? widget.horizontalPadding!
                : 5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        backgroundColor: (Colors.grey.shade200),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.displayedText,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'komikax',
                              color: (Colors.black87),
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        TextButton(
                          // focusNode: widget.focusNodes?[2],
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'X',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.red.shade700,
                                fontFamily: 'komikax',
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    widget.noPadding
                        ? widget.dialogContentWidget
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10, right: 10, bottom: 5),
                            child: widget.dialogContentWidget,
                          ),

                    // const SizedBox(
                    //   height: 10,
                    // ),
                    widget.onlyCloseOption
                        ? Container()
                        : Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (widget.submitFunction != null) {
                                      bool success = widget.submitFunction!();

                                      if (success) {
                                        Navigator.pop(context);
                                      }
                                    } else if (widget.updateFunction != null) {
                                      bool success = widget
                                          .updateFunction!(widget.documentID);

                                      if (success) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  child: Text(widget.submitText)),
                              // CustomGradientButtonWidget(
                              //   fontSize: 15.sp,
                              //   onPressMethod: () {
                              //     if (widget.submitFunction != null) {
                              //       bool success = widget.submitFunction!();
                              //
                              //       if (success) {
                              //         Navigator.pop(context);
                              //       }
                              //     } else if (widget.updateFunction != null) {
                              //       bool success = widget
                              //           .updateFunction!(widget.documentID);
                              //
                              //       if (success) {
                              //         Navigator.pop(context);
                              //       }
                              //     }
                              //   },
                              //   buttonColorList: [
                              //     Colors.red.shade900,
                              //     Colors.redAccent
                              //   ],
                              //   horizontalTextPadding: 5.w,
                              //   linearGradient: true,
                              //   displayedText: widget.submitText,
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
