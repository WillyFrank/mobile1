import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final PreferredSizeWidget? customAppBar;
  final bool extendBodyBehindAppBar;

  const CustomScaffold({
    super.key,
    this.child,
    this.backgroundColor,
    this.customAppBar,
    this.extendBodyBehindAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: customAppBar ??
            AppBar(
              iconTheme: IconThemeData(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black54),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'App Title',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        body: ResponsiveScaledBox(
          width: ResponsiveValue<double>(
            context,
            conditionalValues: [
              const Condition.equals(name: MOBILE, value: 400),
              const Condition.equals(name: TABLET, value: 700),
              const Condition.equals(name: DESKTOP, value: 1200),
              const Condition.equals(name: '4K', value: 1600),
            ],
          ).value,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade50,
                      Colors.white,
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
