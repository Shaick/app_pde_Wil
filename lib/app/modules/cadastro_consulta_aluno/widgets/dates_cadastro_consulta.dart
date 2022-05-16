import 'package:app_pde/app/modules/cadastro_consulta_aluno/cadastro_consulta_aluno_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/detalhes_consulta_section_header.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DatesCadastroConsulta extends StatefulWidget {
  const DatesCadastroConsulta({Key? key}) : super(key: key);

  @override
  _DatesCadastroConsultaState createState() => _DatesCadastroConsultaState();
}

class _DatesCadastroConsultaState
    extends ModularState<DatesCadastroConsulta, CadastroConsultaAlunoStore> {
  final formatDate = "d-MM-yyyy";
  final formatHours = "hh:mm:ss";
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final afterSixMonths = now.add(const Duration(days: 180));
    return Column(
      children: [
        const PageSectionHeader('Para quando?'),
        const SizedBox(height: 12),
        DateTimePicker(
          cursorColor: AppColors.primary,
          controller: controller.ctrlDataConsulta,
          validator: (value) => controller.validaDataConsulta(value!),
          firstDate: now,
          lastDate: afterSixMonths,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.event),
            labelText: 'Data *',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DateTimePicker(
                validator: (value) => controller.validaHoraInicio(value!),
                controller: controller.ctrlHoraInicio,
                type: DateTimePickerType.time,
                firstDate: now,
                lastDate: afterSixMonths,
                decoration: const InputDecoration(
                  fillColor: AppColors.primary,
                  suffixIcon: Icon(Icons.access_time),
                  labelText: 'Inicio *',
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: DateTimePicker(
                validator: (value) => controller.validaHoraFinal(value!),
                controller: controller.ctrlHoraFim,
                type: DateTimePickerType.time,
                dateMask: formatHours,
                firstDate: now,
                lastDate: afterSixMonths,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.access_time),
                  labelText: 'Fim *',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
