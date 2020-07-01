import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/pages/register/domain/publicitymethods_model.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';

class PublicityMethods extends StatefulWidget {
  @override
  _PublicityState createState() => _PublicityState();
}

class _PublicityState extends State<PublicityMethods> {
   List<bool> _values=[false,false,false,false];
  
  var _selecteCategorys = [];
  _onCategorySelected(bool selected, categoryid, i) {
    if (selected == true) {
      setState(() {
        _values[i] = selected;
        _selecteCategorys.add(categoryid);
      });
    } else {
      setState(() {
        _values[i] = selected;
        _selecteCategorys.remove(categoryid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final servicesProvider = GetPublicity();
    return FutureBuilder(
        future: servicesProvider.getpublicity(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PublicityMethodsModel>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;

            return Container(
                width: size.width,
                height: size.width > size.height
                    ? size.height * 0.60
                    : size.height * 0.40,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productos.length,
                    itemBuilder: (context, i) =>
                        _createCheckBox(context, productos[i], i)));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createCheckBox(
      BuildContext context, PublicityMethodsModel prod, int index) {
    final userInfo = Provider.of<UserInfo>(context);
    return CheckboxListTile(
        value: _values[index],
        title: new Text('${prod.name}'),
        onChanged: (bool selected) {
          _onCategorySelected(selected, prod.name, index);
          userInfo.publi = prod.name;
          print(userInfo.publi);
        });
  }
}
