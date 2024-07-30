import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>
    with SingleTickerProviderStateMixin {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
    _nameController.text = "hello world!";
    _nameController.selection = TextSelection(
      baseOffset: 2,
      extentOffset: _nameController.text.length,
    );

    _nameController.addListener(() {
      if (kDebugMode) {
        print("nameController: ${_nameController.text}");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _pswController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Third Page"), actions: const [
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            ),
          )
        ]),
        body: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("hi"), Text("world")],
              ),
            ),
            Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    _switchSelected = value;
                  });
                }),
            Checkbox(
                value: _checkboxSelected,
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value!;
                  });
                }),
            TextField(
              // autofocus: true,
              decoration: const InputDecoration(
                  hintText: "请输入用户名",
                  labelText: "用户名",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )),
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "请输入密码",
                  labelText: "密码",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder()),
              controller: _pswController,
            ),
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "请输入用户名",
                        labelText: "用户名",
                        icon: Icon(Icons.person),
                      ),
                      validator: (v) {
                        return v!.trim().isEmpty ? "用户名不能为空" : null;
                      },
                    ),
                    TextFormField(
                      controller: _pswController,
                      decoration: const InputDecoration(
                        hintText: "请输入密码",
                        labelText: "密码",
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (v) {
                        return v!.trim().length > 5 ? null : "密码不能少于6位";
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  if (kDebugMode) {
                                    print("登录成功");
                                    Fluttertoast.showToast(
                                        msg: '登录成功',
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "登录",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(16),
                child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    value: _animationController.value,
                    valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                        .animate(_animationController)))
          ],
        ));
  }
}
