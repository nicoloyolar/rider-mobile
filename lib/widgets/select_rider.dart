import 'package:flutter/material.dart';
import 'package:rider/theme/app_text_styles.dart';

class SeleccionRiderWidget extends StatefulWidget {
  final Function(String) onRiderSelected;

  const SeleccionRiderWidget({super.key, required this.onRiderSelected});

  @override
  _SeleccionRiderWidgetState createState() => _SeleccionRiderWidgetState();
}

class _SeleccionRiderWidgetState extends State<SeleccionRiderWidget> {
  String riderSeleccionado = 'Vehículo tradicional';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona tu Rider',
          style: AppTextStyles.subtitle,
        ),
        const SizedBox(height: 12),
        _opcionRider('Vehículo tradicional', 'Rider básico', 0),
        _opcionRider('Alta gama', 'Rider París (+1.000 pesos)', 1000),
        _opcionRider('Mayor capacidad', 'Rider XL (desde 5.000 pesos)', 5000),
      ],
    );
  }

  Widget _opcionRider(String titulo, String descripcion, int extraCosto) {
    final bool seleccionado = riderSeleccionado == titulo;
    final Color primary = Theme.of(context).primaryColor;
    final Color secondaryText = Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return GestureDetector(
      onTap: () {
        setState(() {
          riderSeleccionado = titulo;
        });
        widget.onRiderSelected(titulo);
      },
      child: Card(
        elevation: seleccionado ? 5 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                seleccionado ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: seleccionado ? primary : secondaryText,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    descripcion,
                    style: AppTextStyles.caption,
                  ),
                  if (extraCosto > 0)
                    Text(
                      '+ \$${extraCosto.toStringAsFixed(0)}',
                      style: AppTextStyles.caption.copyWith(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
