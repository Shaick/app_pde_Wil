import 'package:app_pde/app/models/consulta.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';

import 'custom_list_tile.dart';
import 'leading_rounded_box.dart';

class ConsultasListView extends StatelessWidget {
  final List<ConsultaViewModel>? consultas;
  final Future<void> Function() onRefresh;
  final void Function(ConsultaViewModel) onTap;
  // final void Function(ConsultaViewModel)? onTap2;
  //final void Function(ConsultaViewModel)? onTap3;
  const ConsultasListView({
    Key? key,
    required this.consultas,
    required this.onRefresh,
    required this.onTap,
    //this.onTap2,
    // this.onTap3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return consultas?.isEmpty ?? false
        ? _buildEmptyWarning()
        : _buildConsultas();
  }

  Widget _buildEmptyWarning() {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: onRefresh,
      child: Stack(
        children: [
          ListView(),
          const Center(
            child: Text(
              'Nenhuma consulta para mostrar',
              style: const TextStyle(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultas() {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: consultas!.length,
        itemBuilder: (context, index) {
          final consulta = consultas![index];
          return Material(
            child: InkWell(
              onTap: () => onTap(consulta),
              child: CustomListTile(
                title: consulta.nomeMateria,
                subtitle: consulta.dataInicio,
                trailing: const Icon(
                  MdiIcons.chevronRight,
                  color: AppColors.accent,
                ),
                icon: consulta.situacao == SituacaoConsulta.disponiveis &&
                        consulta.isOrcamento == true
                    ? const Icon(
                        Icons.monetization_on,
                        color: AppColors.monetizationIcon,
                      )
                    : consulta.icon,
                leading: LeadingRoundedBox(
                  text: consulta.idNumerico,
                  color: consulta.color ?? AppColors.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
