import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final bool filled;
  final EdgeInsetsGeometry? contentPadding;
  final bool hasSavedData;
  final bool isRequired;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor,
    this.filled = true,
    this.contentPadding,
    this.hasSavedData = false,
    this.isRequired = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;
  bool _hasFocus = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hasFocus 
                      ? theme.primaryColor 
                      : (widget.hasSavedData ? Colors.green[700] : Colors.grey[700]),
                ),
              ),
              if (widget.hasSavedData) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: Colors.green[600],
                ),
              ],
              if (widget.isRequired && !widget.hasSavedData) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Text Field
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          obscureText: _obscureText,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          readOnly: widget.readOnly,
          textCapitalization: widget.textCapitalization,
          style: TextStyle(
            fontSize: 16,
            color: widget.enabled ? Colors.black87 : Colors.grey[600],
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            
            // Prefix Icon
            prefixIcon: widget.prefixIcon != null
                ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Icon(
                      widget.prefixIcon,
                      color: _hasFocus 
                          ? theme.primaryColor 
                          : Colors.grey[500],
                      size: 20,
                    ),
                  )
                : null,
            
            // Suffix Icon
            suffixIcon: _buildSuffixIcon(),
            
            // Styling
            filled: widget.filled,
            fillColor: widget.fillColor ?? 
                (widget.enabled ? Colors.grey[50] : Colors.grey[100]),
            
            contentPadding: widget.contentPadding ?? 
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            
            // Border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.hasSavedData ? Colors.green[300]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.hasSavedData ? Colors.green[300]! : Colors.grey[300]!,
                width: widget.hasSavedData ? 1.5 : 1,
              ),
            ),
            
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            
            // Error styling
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
            
            // Counter styling
            counterStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey[500],
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(
          widget.suffixIcon,
          color: Colors.grey[500],
          size: 20,
        ),
        onPressed: widget.onSuffixIconPressed,
      );
    }
    
    return null;
  }
}