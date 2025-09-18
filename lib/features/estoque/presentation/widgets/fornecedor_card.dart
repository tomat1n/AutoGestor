import 'package:flutter/material.dart';
import '../../domain/entities/fornecedor.dart';

class FornecedorCard extends StatelessWidget {
  final Fornecedor fornecedor;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onToggleActive;
  final VoidCallback? onDelete;

  const FornecedorCard({
    super.key,
    required this.fornecedor,
    this.onTap,
    this.onEdit,
    this.onToggleActive,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com nome e status
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fornecedor.nome,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (fornecedor.razaoSocial != null && 
                            fornecedor.razaoSocial!.isNotEmpty &&
                            fornecedor.razaoSocial != fornecedor.nome)
                          Text(
                            fornecedor.razaoSocial!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: fornecedor.ativo ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      fornecedor.ativo ? 'Ativo' : 'Inativo',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Informações de contato
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (fornecedor.cnpj != null && fornecedor.cnpj!.isNotEmpty)
                          _buildInfoRow(
                            Icons.business,
                            'CNPJ: ${_formatCnpj(fornecedor.cnpj!)}',
                          )
                        else if (fornecedor.cpf != null && fornecedor.cpf!.isNotEmpty)
                          _buildInfoRow(
                            Icons.person,
                            'CPF: ${_formatCpf(fornecedor.cpf!)}',
                          ),
                        
                        if (fornecedor.email != null && fornecedor.email!.isNotEmpty)
                          _buildInfoRow(
                            Icons.email,
                            fornecedor.email!,
                          ),
                        
                        if (fornecedor.telefone != null && fornecedor.telefone!.isNotEmpty)
                          _buildInfoRow(
                            Icons.phone,
                            _formatTelefone(fornecedor.telefone!),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Endereço (se disponível)
              if (fornecedor.endereco != null && fornecedor.endereco!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _buildInfoRow(
                    Icons.location_on,
                    _buildEnderecoCompleto(),
                  ),
                ),
              
              const SizedBox(height: 12),
              
              // Botões de ação
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onToggleActive != null)
                    TextButton.icon(
                      onPressed: onToggleActive,
                      icon: Icon(
                        fornecedor.ativo ? Icons.visibility_off : Icons.visibility,
                        size: 16,
                      ),
                      label: Text(fornecedor.ativo ? 'Desativar' : 'Ativar'),
                      style: TextButton.styleFrom(
                        foregroundColor: fornecedor.ativo ? Colors.orange : Colors.green,
                      ),
                    ),
                  
                  if (onEdit != null)
                    TextButton.icon(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Editar'),
                    ),
                  
                  if (onDelete != null)
                    TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, size: 16),
                      label: const Text('Excluir'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildEnderecoCompleto() {
    final parts = <String>[];
    
    if (fornecedor.endereco != null && fornecedor.endereco!.isNotEmpty) {
      parts.add(fornecedor.endereco!);
    }
    
    if (fornecedor.cidade != null && fornecedor.cidade!.isNotEmpty) {
      parts.add(fornecedor.cidade!);
    }
    
    if (fornecedor.estado != null && fornecedor.estado!.isNotEmpty) {
      parts.add(fornecedor.estado!);
    }
    
    if (fornecedor.cep != null && fornecedor.cep!.isNotEmpty) {
      parts.add('CEP: ${_formatCep(fornecedor.cep!)}');
    }
    
    return parts.join(', ');
  }

  String _formatCnpj(String cnpj) {
    // Remove caracteres não numéricos
    final numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numbers.length == 14) {
      return '${numbers.substring(0, 2)}.${numbers.substring(2, 5)}.${numbers.substring(5, 8)}/${numbers.substring(8, 12)}-${numbers.substring(12)}';
    }
    
    return cnpj;
  }

  String _formatCpf(String cpf) {
    // Remove caracteres não numéricos
    final numbers = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numbers.length == 11) {
      return '${numbers.substring(0, 3)}.${numbers.substring(3, 6)}.${numbers.substring(6, 9)}-${numbers.substring(9)}';
    }
    
    return cpf;
  }

  String _formatTelefone(String telefone) {
    // Remove caracteres não numéricos
    final numbers = telefone.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numbers.length == 11) {
      return '(${numbers.substring(0, 2)}) ${numbers.substring(2, 7)}-${numbers.substring(7)}';
    } else if (numbers.length == 10) {
      return '(${numbers.substring(0, 2)}) ${numbers.substring(2, 6)}-${numbers.substring(6)}';
    }
    
    return telefone;
  }

  String _formatCep(String cep) {
    // Remove caracteres não numéricos
    final numbers = cep.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numbers.length == 8) {
      return '${numbers.substring(0, 5)}-${numbers.substring(5)}';
    }
    
    return cep;
  }
}