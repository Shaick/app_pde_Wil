import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class ConsultaStatusCard extends StatelessWidget {
  final ConsultaViewModel consulta;

  const ConsultaStatusCard(this.consulta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                'STATUS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(width: 6),
              /*
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: consulta.color,
                ),
                height: 8,
                width: 8,
              ),
              */
            ],
          ),
          const SizedBox(height: 12),
          Text(
            consulta.status,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
