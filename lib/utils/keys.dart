import 'package:flutter/foundation.dart';

class Keys {
  static const currentDateWidget = Key('currentDateWidget');
  static const userAvatarWidget = Key('userAvatarWidget');
  static const toDoListBodyWidget = Key('toDoListBodyWidget');
  static Key itemTarefaDismissableWidget(int index) => Key('itemTarefa_$index');

  static const addTarefaButton = Key('addTarefaButton');
  static const addTarefaModal = Key('addTarefaModal');
  static const addTarefaTitleTextField = Key('addTarefaTitleTextField');
  static const addTarefaModalOkButton = Key('addTarefaModalOkButton');
  static const addTarefaModalCancelarButton =
      Key('addTarefaModalCancelarButton');
}
