import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchInputWidget extends StatefulWidget {
  @override
  _SearchInputWidgetState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 7,
                  offset: Offset(0, 1))
            ]),
        child: TextFormField(
          controller: _inputController,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: FadeAnimation(
                delay: 1.3,
                child: IconButton(
                  icon: Icon(Icons.search, size: 27.0),
                  onPressed: () =>
                      _doQuery(), // We can use Stateless Widget and remove the controller by passing value inside doQuery but maybe we'll need the function somewhere else
                ),
              )),
          onChanged: (value) {
            _doQuery();
          },
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      ),
    );
  }

  void _doQuery() {
    // FocusManager.instance.primaryFocus?.unfocus();
    Get.find<InitDataController>().filterCoupons(query: _inputController.text);
  }
}
