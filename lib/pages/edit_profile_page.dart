import 'dart:typed_data';
import 'package:chat_line/models/controllers/auth_controller.dart';
import 'package:chat_line/models/controllers/chat_controller.dart';
import 'package:chat_line/models/extended_profile.dart';
import 'package:chat_line/platform_dependent/image_uploader_abstract.dart';
import 'package:chat_line/shared_components/alert_message_popup.dart';
import 'package:chat_line/shared_components/app_drawer.dart';
import 'package:chat_line/shared_components/height_input.dart';
import 'package:flutter/material.dart';

import '../models/submodels/height.dart';
import '../sanity/image_url_builder.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(
      {super.key,
      required this.authController,
      required this.chatController,
      required this.imageUploader,
      this.drawer});

  final AuthController authController;
  final ChatController chatController;
  final ImageUploader? imageUploader;
  final AppDrawer? drawer;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _loginUsername = "";
  String _displayName = "";

  // String _filename = "";

  String _shortBio = "";
  String _longBio = "";
  String _iAm = "";
  String _imInto = "";
  String _imOpenTo = "";
  String _whatIDo = "";
  String _whatImLookingFor = "";
  String _whatInterestsMe = "";
  String _whereILive = "";
  String _sexPreferences = "";

  int _age = 0;
  int _weight = 0;

  late ExtendedProfile? extProfile = null;

  void _setUsername(String newUsername) {
    setState(() {
      _loginUsername = newUsername;
    });
  }

  void _setDisplayName(String newDisplayName) {
    setState(() {
      _displayName = newDisplayName;
    });
  }

  void _setShortBio(String newShortBio) {
    setState(() {
      _shortBio = newShortBio;
    });
  }

  void _setLongBio(String newLongBio) {
    setState(() {
      _longBio = newLongBio;
    });
  }

  void _setIAm(String newIAm) {
    setState(() {
      _iAm = newIAm;
    });
  }

  void _setImInto(String newImInto) {
    setState(() {
      _imInto = newImInto;
    });
  }

  void _setImOpenTo(String newImOpenTo) {
    setState(() {
      _imOpenTo = newImOpenTo;
    });
  }

  void _setWhatIDo(String newWhatIDo) {
    setState(() {
      _whatIDo = newWhatIDo;
    });
  }

  void _setWhatImLookingFor(String newWhatImLookingFor) {
    setState(() {
      _whatImLookingFor = newWhatImLookingFor;
    });
  }

  void _setWhatInterestsMe(String newWhatInterestsMe) {
    setState(() {
      _whatInterestsMe = newWhatInterestsMe;
    });
  }

  void _setWhereILive(String newWhereILive) {
    setState(() {
      _whereILive = newWhereILive;
    });
  }

  void _setSexPreferences(String newSexPreference) {
    setState(() {
      _sexPreferences = newSexPreference;
    });
  }

  void _setWeight(int newWeight) {
    setState(() {
      _weight = newWeight;
    });
  }

  void _setAge(int newAge) {
    setState(() {
      _age = newAge;
    });
  }

  var _filename;

  Future<void> _updateProfile(context) async {
    try {
      var authUser = await widget.authController.updateUser(
          _loginUsername,
          _displayName,
          widget.imageUploader?.filename ?? "",
          widget.imageUploader?.fileData,
          context);
      print("updated fields in authuser result: $authUser");
      print("id to create ${authUser?.uid}");

      ExtendedProfile newProfile = ExtendedProfile(
        shortBio: _shortBio != "" ? _shortBio : null,
        height: _height,
        longBio: _longBio != "" ? _longBio : null,
        age: _age != 0 ? _age : null,
        weight: _weight != 0 ? _weight : null,
        iAm: _iAm != "" ? _iAm : null,
        imInto: _imInto != "" ? _imInto : null,
        imOpenTo: _imOpenTo != "" ? _imOpenTo : null,
        whatIDo: _whatIDo != "" ? _whatIDo : null,
        whatImLookingFor: _whatImLookingFor != "" ? _whatImLookingFor : null,
        whatInterestsMe: _whatInterestsMe != "" ? _whatInterestsMe : null,
        whereILive: _whereILive != "" ? _whereILive : null,
        sexPreferences: _sexPreferences != "" ? _sexPreferences : null,
      );

      print("parsed request from user form: $newProfile");

      var aUser = await widget.chatController
          .updateExtProfileChatUser(authUser?.uid ?? "", context, newProfile);
      print("updated extended profile $aUser");
    } catch (e) {
      print(e);
    }
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const AlertMessagePopup(
              title: "Success",
              message: "Profile Updated Success",
              isError: false);
        });
  }

  // void _updateProfilePhoto(context) async {
  //   // var file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   // setState(() {
  //   //   _filename = file?.path ?? "";
  //   // });
  //
  //   FileUploadInputElement uploadInput = FileUploadInputElement();
  //   uploadInput.click();
  //
  //   uploadInput.onChange.listen((e) {
  //     final files = uploadInput.files;
  //     if (files?.length == 1) {
  //       final File file = files![0];
  //       final reader = FileReader();
  //       reader.onLoadEnd.listen((e) {
  //         setState(() {
  //           _filename = uploadInput.value ?? "";
  //           _fileData = reader.result;
  //         });
  //         print("loaded: ${file.name} from ${uploadInput.value} ");
  //         print("type: ${reader.result.runtimeType}");
  //       });
  //       reader.onError.listen((e) {
  //         print(e);
  //       });
  //       reader.readAsArrayBuffer(file);
  //     }
  //   });
  // }

  _getMyProfileImage() {
    if (widget.imageUploader != null &&
        (widget.imageUploader?.filename ?? "") != "") {
      return Image.memory(
        Uint8List.fromList(widget.imageUploader?.fileData),
        height: 100,
        width: 100,
      );
    }

    if (widget.authController.myAppUser?.profileImage != null) {
      return Image.network(MyImageBuilder()
              .urlFor(widget.authController.myAppUser?.profileImage)
              ?.height(100)
              .width(100)
              .url() ??
          "");
    }

    return Image.asset(height: 100, width: 100, 'assets/blankProfileImage.png');
  }

  Height? _height;

  _updateHeight(int newFeet, int newInches) {
    setState(() {
      _height = Height.withValues(newFeet, newInches);
    });
  }

  var _fileData;

  _updateFileDataItems(response) async {
    // print("In edit profile page $response");
    setState(() {
      _filename = response['filename'];
      _fileData = response['fileData'];
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        title: Text("Chat Line - Edit Profile"),
      ),
      body: Padding(
        key: ObjectKey(widget.imageUploader?.filename),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Edit Profile',
            ),
            Flexible(
              child: ListView(
                children: [
                  ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _getMyProfileImage(),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            var theResponse =
                                await widget.imageUploader?.uploadImage();

                            await _updateFileDataItems(theResponse);
                          },
                          child: Text("Change Profile Photo"),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: Key(widget.authController.loggedInUser?.email ?? ""),
                      initialValue: widget.authController.loggedInUser?.email,
                      onChanged: (e) {
                        _setUsername(e);
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          (widget.authController.myAppUser?.displayName ?? "") +
                              "-display-name"),
                      initialValue:
                          widget.authController.myAppUser?.displayName,
                      onChanged: (e) {
                        _setDisplayName(e);
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Display Name',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            key: ObjectKey(
                                "${widget.chatController.extProfile?.age.toString() ?? ""}-age"),
                            initialValue: widget.chatController.extProfile?.age
                                    .toString() ??
                                "",
                            onChanged: (e) {
                              _setAge(int.parse(e));
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Age',
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            key: ObjectKey(
                                "${widget.chatController.extProfile?.weight.toString() ?? ""}-weight"),
                            initialValue: widget
                                    .chatController.extProfile?.weight
                                    .toString() ??
                                "",
                            onChanged: (e) {
                              _setWeight(int.parse(e));
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Weight',
                            ),
                          ),
                        ),
                        Flexible(
                            child: HeightInput(
                          initialValue:
                              widget.chatController.extProfile?.height,
                          updateHeight: _updateHeight,
                        )),
                      ],
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.shortBio}-short-bio"),
                      initialValue: widget.chatController.extProfile?.shortBio,
                      onChanged: (e) {
                        _setShortBio(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Short Bio',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.longBio}-long-bio"),
                      initialValue:
                          widget.chatController.extProfile?.longBio ?? "",
                      onChanged: (e) {
                        _setLongBio(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Long Bio',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.iAm}-i-am"),
                      // controller: _longBioController,
                      initialValue: widget.chatController.extProfile?.iAm ?? "",
                      onChanged: (e) {
                        _setIAm(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'I am:',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.imInto}-im-into"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.imInto ?? "",
                      onChanged: (e) {
                        _setImInto(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "I'm Into",
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.imOpenTo}-im-open-to"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.imOpenTo ?? "",
                      onChanged: (e) {
                        _setImOpenTo(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "I'm Open to",
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.whatIDo}-what-i-do"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.whatIDo ?? "",
                      onChanged: (e) {
                        _setWhatIDo(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'What I do:',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.whatImLookingFor}-what-im-looking-for"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.whatImLookingFor ??
                              "",
                      onChanged: (e) {
                        _setWhatImLookingFor(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "What I'm Looking for:",
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.whatInterestsMe}-what-interests-me"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.whatInterestsMe ??
                              "",
                      onChanged: (e) {
                        _setWhatInterestsMe(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'What Interests me:',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.whereILive}-where-i-live"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.whereILive ?? "",
                      onChanged: (e) {
                        _setWhereILive(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Where I Live:',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      key: ObjectKey(
                          "${widget.chatController.extProfile?.sexPreferences}-sex-preferences"),
                      // controller: _longBioController,
                      initialValue:
                          widget.chatController.extProfile?.sexPreferences ??
                              "",
                      onChanged: (e) {
                        _setSexPreferences(e);
                      },
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Sex Preferences:',
                      ),
                    ),
                  ),
                  ListTile(
                    title: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        _updateProfile(context);
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
