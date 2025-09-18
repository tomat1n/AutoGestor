import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiltroPeriodoDialog extends StatefulWidget {
  final DateTime dataInicio;
  final DateTime dataFim;

  const FiltroPeriodoDialog({
    super.key,
    required this.dataInicio,
    required this.dataFim,
  });

  @override
  State<FiltroPeriodoDialog> createState() => _FiltroPeriodoDialogState();
}

class _FiltroPeriodoDialogState extends State<FiltroPeriodoDialog> {
  late DateTime _dataInicio;
  late DateTime _dataFim;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _dataInicio = widget.dataInicio;
    _dataFim = widget.dataFim;
  }

  Future<void> _selecionarDataInicio() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataInicio,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );

    if (data != null) {
      setState(() {
        _dataInicio = data;
        // Se a data de início for maior que a data fim, ajustar
        if (_dataInicio.isAfter(_dataFim)) {
          _dataFim = _dataInicio;
        }
      });
    }
  }

  Future<void> _selecionarDataFim() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataFim,
      firstDate: _dataInicio,
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );

    if (data != null) {
      setState(() {
        _dataFim = data;
      });
    }
  }

  void _definirPeriodoRapido(String periodo) {
    final agora = DateTime.now();
    DateTime inicio;

    switch (periodo) {
      case 'hoje':
        inicio = DateTime(agora.year, agora.month, agora.day);
        setState(() {
          _dataInicio = inicio;
          _dataFim = agora;
        });
        break;
      case 'ontem':
        final ontem = agora.subtract(const Duration(days: 1));
        inicio = DateTime(ontem.year, ontem.month, ontem.day);
        setState(() {
          _dataInicio = inicio;
          _dataFim = DateTime(ontem.year, ontem.month, ontem.day, 23, 59, 59);
        });
        break;
      case 'semana':
        inicio = agora.subtract(Duration(days: agora.weekday - 1));
        setState(() {
          _dataInicio = DateTime(inicio.year, inicio.month, inicio.day);
          _dataFim = agora;
        });
        break;
      case 'mes':
        inicio = DateTime(agora.year, agora.month, 1);
        setState(() {
          _dataInicio = inicio;
          _dataFim = agora;
        });
        break;
      case '30dias':
        inicio = agora.subtract(const Duration(days: 30));
        setState(() {
          _dataInicio = inicio;
          _dataFim = agora;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.date_range, color: Colors.blue),
          SizedBox(width: 8),
          Text('Filtrar Período'),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Períodos rápidos
            Text(
              'Períodos Rápidos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChipPeriodo('Hoje', 'hoje'),
                _buildChipPeriodo('Ontem', 'ontem'),
                _buildChipPeriodo('Esta Semana', 'semana'),
                _buildChipPeriodo('Este Mês', 'mes'),
                _buildChipPeriodo('Últimos 30 dias', '30dias'),
              ],
            ),
            const SizedBox(height: 24),
            
            // Seleção personalizada
            Text(
              'Período Personalizado',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Data de início
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data de Início',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _selecionarDataInicio,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _dateFormat.format(_dataInicio),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                
                // Data de fim
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data de Fim',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _selecionarDataFim,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _dateFormat.format(_dataFim),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Informação do período
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Período selecionado: ${_calcularDiferenca()} dias',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'inicio': _dataInicio,
              'fim': _dataFim,
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Aplicar Filtro'),
        ),
      ],
    );
  }

  Widget _buildChipPeriodo(String label, String valor) {
    return ActionChip(
      label: Text(label),
      onPressed: () => _definirPeriodoRapido(valor),
      backgroundColor: Colors.blue.shade50,
      side: BorderSide(color: Colors.blue.shade200),
      labelStyle: TextStyle(
        color: Colors.blue.shade700,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  int _calcularDiferenca() {
    return _dataFim.difference(_dataInicio).inDays + 1;
  }
}