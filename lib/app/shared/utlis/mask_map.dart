//Mapa de Endpoints da Api Utilizados
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Map<String, MaskTextInputFormatter> masks = {
  "cpf": new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')}),
  "cel": new MaskTextInputFormatter(mask: '+## (##) #####-####'),
};
