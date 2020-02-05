import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilter;
  final Map<String, bool> currentFilters;
  FilterScreen(this.currentFilters, this.saveFilter);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoFree = false;
  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.saveFilter({
                'gluten': _glutenFree,
                'lactose': _lactoFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              });
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile("Gluten-free",
                    "Only include gluten-free meals.", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                Divider(
                  thickness: 2,
                ),
                _buildSwitchListTile("Lactose-free",
                    "Only include lactose-free meals.", _lactoFree, (newValue) {
                  setState(() {
                    _lactoFree = newValue;
                  });
                }),
                Divider(
                  thickness: 2,
                ),
                _buildSwitchListTile(
                    "Vegetarian", "Only include vegetarian meals.", _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                Divider(
                  thickness: 2,
                ),
                _buildSwitchListTile(
                    "Vegan", "Only include vegan meals.", _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
