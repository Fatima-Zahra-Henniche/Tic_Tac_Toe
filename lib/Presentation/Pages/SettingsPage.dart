import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(dynamic) onOptionSelected;

  const SettingsPage({required this.onOptionSelected});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  dynamic selectedOption = const Color(0xFF00061a); // Set a default option

  List<dynamic> backgroundOptions = [
    Colors.white, // Default option
    const Color(0xFF00061a),
    'imgs/bg2.png',
    'imgs/bg3.png',
    'imgs/bg4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Container(
          height: 45,
          width: 365,
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {
              _showOptionsDialog();
            },
            child: const Text(
              'Change Background',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Background'),
          content: SingleChildScrollView(
            child: ListBody(
              children: backgroundOptions.map((option) {
                return ListTile(
                  leading: _buildOptionIcon(option),
                  title: Text(_getOptionTitle(option)),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedOption = option;
                      widget.onOptionSelected(option);
                    });
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionIcon(dynamic option) {
    if (option is Color) {
      return Container(
        width: 24,
        height: 24,
        color: option,
      );
    } else if (option is String) {
      return Image.asset(
        option,
        width: 24,
        height: 30,
      );
    }
    return const SizedBox();
  }

  String _getOptionTitle(dynamic option) {
    if (option is Color) {
      return 'Color';
    } else if (option is String) {
      return 'Image';
    }
    return '';
  }
}
