// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TalentMatch';

  @override
  String get dislike => 'No me gusta';

  @override
  String get explore => 'Explorar';

  @override
  String get favorites => 'Favoritos';

  @override
  String get applied => 'Aplicado';

  @override
  String get welcomeTitle => '¡Bienvenido a TalentMatch!';

  @override
  String get welcomeMessage =>
      '• Sube tu currículum\n• Explora ofertas de trabajo\n--> Desliza a la derecha para favorito\n<-- Desliza a la izquierda para no me gusta\n\nTalentMatch clasifica trabajos según tu currículum.';

  @override
  String get gotIt => 'Entendido';

  @override
  String get searchJobs => 'Buscar trabajos...';

  @override
  String get uploadResume => 'Subir Currículum';

  @override
  String get resumeUploaded => '¡Currículum subido exitosamente!';

  @override
  String get noJobsFound => 'No se encontraron trabajos';

  @override
  String relevance(int percent) {
    return 'Relevancia: $percent%';
  }

  @override
  String get apply => 'Aplicar';

  @override
  String get markApplied => 'Marcar como Aplicado';

  @override
  String get appliedStatus => 'Aplicado';

  @override
  String get unapply => 'Desmarcar';

  @override
  String get delete => 'Eliminar';

  @override
  String get favorite => 'Favorito';

  @override
  String get showMore => 'Mostrar Más 🔽';

  @override
  String get showLess => 'Mostrar Menos';

  @override
  String get button => 'Botón';
}
