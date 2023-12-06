import 'package:connection/models/profile.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';

import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

import '../models/lop.dart';
import '../repositories/lop_repository.dart';

class PageDangKyLop extends StatefulWidget {
  PageDangKyLop({super.key});

  @override
  State<PageDangKyLop> createState() => _PageDangKyLopState();
}

class _PageDangKyLopState extends State<PageDangKyLop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = "";
  String ten = "";
  int idlop = 0;
  String tenlop = "";
  @override
  void initState() {
    // TODO: implement initState
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Thêm thông tin cơ bản',
              style: AppConstant.textfancyheader2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Bạn không thể quay trở lại trang sau khi rời đi. vì vậy hãy kiểm tra kỹ nhé",
              style: AppConstant.textError,
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputText(
              title: "Tên",
              value: ten,
              width: size.width,
              callback: (output) {
                ten = output;
              },
            ),
            CustomInputText(
              title: "MSSV",
              value: mssv,
              width: size.width,
              callback: (output) {
                mssv = output;
              },
            ),
            listlop!.isEmpty
                ? FutureBuilder(
                    future: LopRepository().getDsLop(),
                    builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        listlop = snapshot.data;
                        return CustomInputDropDown(
                          width: size.width,
                          list: listlop!,
                          title: "Lớp",
                          valueId: idlop,
                          valueName: tenlop,
                          callback: (outputId, outputName) {
                            idlop = outputId;
                            tenlop = outputName;
                          },
                        );
                      } else {
                        return Text('Loi xay ra');
                      }
                    })
                : CustomInputDropDown(
                    width: size.width,
                    list: listlop!,
                    title: "Lớp",
                    valueId: idlop,
                    valueName: tenlop,
                    callback: (outputId, outputName) {
                      idlop = outputId;
                      tenlop = outputName;
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () async {
                  profile.student.mssv = mssv;
                  profile.student.idlop = idlop;
                  profile.student.tenlop = tenlop;
                  profile.user.first_name = ten;
                  await UserRepository().updateProfile();
                  await StudentRepository().dangkyLop();
                },
                child: CustomButton(textButton: 'Lưu thông tin')),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, PageMain.routename);
              },
              child: Text(
                "Rời khỏi trang>>",
                style: AppConstant.textlink,
              ),
            )
          ],
        ),
      ))),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  const CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.valueName,
    required this.callback,
    required this.list,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;
  final Function(int outputId, String outputName) callback;
  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";
  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == "" ? "Khong Co" : outputName,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200]),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Container(
                                width: widget.width * 0.8,
                                child: Text(
                                  e.ten,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                )),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputText extends StatefulWidget {
  const CustomInputText({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
  });

  final double width;
  final String title;
  final String value;
  final Function(String output) callback;
  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  int status = 0;
  String output = "";
  @override
  void initState() {
    // TODO: implement initState
    output = widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  output == "" ? "Khong Co" : output,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200]),
                    width: widget.width - 50,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      initialValue: output,
                      onChanged: (value) {
                        setState(() {
                          output = value;
                          widget.callback(output);
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 0;
                        widget.callback(output);
                      });
                    },
                    child: Icon(
                      Icons.save,
                      size: 18,
                    ),
                  )
                ],
              ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
