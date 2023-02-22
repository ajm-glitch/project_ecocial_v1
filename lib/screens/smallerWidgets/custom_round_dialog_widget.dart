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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        widget.displayedText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: (Colors.black87),
                          // fontWeight: FontWeight.bold
                        ),
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.onlyCloseOption
                                  ? Container()
                                  : Row(
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(
                                            160, 38, 42, 1.0),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text(widget.submitText,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(90, 155, 115, 1),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(widget.closeText,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),)),
                            ],
                          ),
                    const SizedBox(
                      height: 30,
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
