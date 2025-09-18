import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CompanyBrandingWidget extends StatelessWidget {
  final double? logoSize;
  final bool showCompanyName;
  final bool showCnpj;
  final TextStyle? nameStyle;
  final TextStyle? cnpjStyle;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CompanyBrandingWidget({
    Key? key,
    this.logoSize = 60,
    this.showCompanyName = true,
    this.showCnpj = false,
    this.nameStyle,
    this.cnpjStyle,
    this.alignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final usuario = authProvider.usuario;
        
        if (usuario == null) {
          return _buildDefaultBranding(context);
        }

        return Column(
          mainAxisAlignment: alignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo da empresa
            _buildLogo(context, authProvider),
            
            if (showCompanyName && (usuario.nomeFantasia?.isNotEmpty == true || usuario.empresa?.isNotEmpty == true)) ...
              [
                const SizedBox(height: 8),
                Text(
                  usuario.nomeFantasia ?? usuario.empresa ?? '',
                  style: nameStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getPrimaryColor(authProvider),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            
            if (showCnpj && usuario.cnpj?.isNotEmpty == true) ...
              [
                const SizedBox(height: 4),
                Text(
                  'CNPJ: ${_formatCnpj(usuario.cnpj!)}',
                  style: cnpjStyle ?? Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
          ],
        );
      },
    );
  }

  Widget _buildLogo(BuildContext context, AuthProvider authProvider) {
    final logoPath = authProvider.logoPath;
    
    if (logoPath != null && logoPath.isNotEmpty) {
      final file = File(logoPath);
      
      if (file.existsSync()) {
        return Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              file,
              width: logoSize,
              height: logoSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildDefaultIcon(context, authProvider);
              },
            ),
          ),
        );
      }
    }
    
    return _buildDefaultIcon(context, authProvider);
  }

  Widget _buildDefaultIcon(BuildContext context, AuthProvider authProvider) {
    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        color: _getPrimaryColor(authProvider).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getPrimaryColor(authProvider).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.business,
        size: (logoSize ?? 60) * 0.6,
        color: _getPrimaryColor(authProvider),
      ),
    );
  }

  Widget _buildDefaultBranding(BuildContext context) {
    return Column(
      mainAxisAlignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.business,
            size: (logoSize ?? 60) * 0.6,
            color: Colors.blue.shade800,
          ),
        ),
        if (showCompanyName) ...
          [
            const SizedBox(height: 8),
            Text(
              'AutoGestor',
              style: nameStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
      ],
    );
  }

  Color _getPrimaryColor(AuthProvider authProvider) {
    final corPrimaria = authProvider.corPrimaria;
    
    if (corPrimaria != null && corPrimaria.isNotEmpty) {
      try {
        // Remove # se presente
        String colorString = corPrimaria.replaceAll('#', '');
        
        // Adiciona FF para alpha se não presente
        if (colorString.length == 6) {
          colorString = 'FF$colorString';
        }
        
        return Color(int.parse(colorString, radix: 16));
      } catch (e) {
        // Se não conseguir parsear a cor, usa a padrão
        return Colors.blue.shade800;
      }
    }
    
    return Colors.blue.shade800;
  }

  String _formatCnpj(String cnpj) {
    // Remove caracteres não numéricos
    final numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (numbers.length == 14) {
      return '${numbers.substring(0, 2)}.${numbers.substring(2, 5)}.${numbers.substring(5, 8)}/${numbers.substring(8, 12)}-${numbers.substring(12, 14)}';
    }
    
    return cnpj;
  }
}

// Widget para aplicar o tema da empresa
class CompanyThemedContainer extends StatelessWidget {
  final Widget child;
  final bool applyGradient;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CompanyThemedContainer({
    Key? key,
    required this.child,
    this.applyGradient = false,
    this.borderRadius,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final primaryColor = _getPrimaryColor(authProvider);
        final secondaryColor = _getSecondaryColor(authProvider);
        
        return Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: applyGradient ? null : primaryColor.withOpacity(0.05),
            gradient: applyGradient ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor,
                secondaryColor,
              ],
            ) : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            border: Border.all(
              color: primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: child,
        );
      },
    );
  }

  Color _getPrimaryColor(AuthProvider authProvider) {
    final corPrimaria = authProvider.corPrimaria;
    
    if (corPrimaria != null && corPrimaria.isNotEmpty) {
      try {
        String colorString = corPrimaria.replaceAll('#', '');
        if (colorString.length == 6) {
          colorString = 'FF$colorString';
        }
        return Color(int.parse(colorString, radix: 16));
      } catch (e) {
        return Colors.blue.shade800;
      }
    }
    
    return Colors.blue.shade800;
  }

  Color _getSecondaryColor(AuthProvider authProvider) {
    final corSecundaria = authProvider.corSecundaria;
    
    if (corSecundaria != null && corSecundaria.isNotEmpty) {
      try {
        String colorString = corSecundaria.replaceAll('#', '');
        if (colorString.length == 6) {
          colorString = 'FF$colorString';
        }
        return Color(int.parse(colorString, radix: 16));
      } catch (e) {
        return Colors.blue.shade600;
      }
    }
    
    return Colors.blue.shade600;
  }
}

// Widget para botões com tema da empresa
class CompanyThemedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double? height;

  const CompanyThemedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final primaryColor = _getPrimaryColor(authProvider);
        
        if (isOutlined) {
          return SizedBox(
            width: width,
            height: height ?? 48,
            child: OutlinedButton.icon(
              onPressed: onPressed,
              icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
              label: Text(text),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }
        
        return SizedBox(
          width: width,
          height: height ?? 48,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
            label: Text(text),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getPrimaryColor(AuthProvider authProvider) {
    final corPrimaria = authProvider.corPrimaria;
    
    if (corPrimaria != null && corPrimaria.isNotEmpty) {
      try {
        String colorString = corPrimaria.replaceAll('#', '');
        if (colorString.length == 6) {
          colorString = 'FF$colorString';
        }
        return Color(int.parse(colorString, radix: 16));
      } catch (e) {
        return Colors.blue.shade800;
      }
    }
    
    return Colors.blue.shade800;
  }
}