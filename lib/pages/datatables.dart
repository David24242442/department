// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';

class Datatables extends StatefulWidget {
  final String name;
  final String department;
  final String message;

  const Datatables({
    Key? key,
    required this.name,
    required this.department,
    required this.message,
  }) : super(key: key);

  @override
  _DatatablesState createState() => _DatatablesState();
}

class _DatatablesState extends State<Datatables> {
  List<DataRow> _rows = [];
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_rows.isEmpty) {
      addNewData(context, widget.name, widget.department, widget.message);
    }
  }

  void addNewData(
      BuildContext context, String name, String department, String message) {
    setState(() {
      _rows.add(DataRow(cells: [
        DataCell(Text(name)),
        DataCell(Text(department)),
        DataCell(Text(TimeOfDay.now().format(context))),
        DataCell(
          GestureDetector(
            onTap: () => _showMessageDialog(context, message),
            child: _buildMessageContainer(message),
          ),
        ),
      ]));
    });
  }

  void _showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessageContainer(String message) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        message.length > 10 ? message.substring(0, 10) : message,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF778d6f),
        title: Text('DataTables'),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: SingleChildScrollView(
        child: PaginatedDataTable(
          header: Text('Paginated Data'),
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Department')),
            DataColumn(label: Text('Time')),
            DataColumn(label: Text('Message')),
          ],
          source: _DataSource(_rows),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value!;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<DataRow> _rows;

  _DataSource(this._rows);

  @override
  DataRow getRow(int index) => _rows[index];

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rows.length;

  @override
  int get selectedRowCount => 0;
}
