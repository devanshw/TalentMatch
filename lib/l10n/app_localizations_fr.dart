// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'TalentMatch';

  @override
  String get dislike => 'Je n\'aime pas';

  @override
  String get explore => 'Explorer';

  @override
  String get favorites => 'Favoris';

  @override
  String get applied => 'Postulé';

  @override
  String get welcomeTitle => 'Bienvenue sur TalentMatch!';

  @override
  String get welcomeMessage =>
      '• Téléchargez votre CV\n• Explorez les offres d\'emploi\n--> Balayez à droite pour favori\n<-- Balayez à gauche pour je n\'aime pas\n\nTalentMatch classe les emplois selon votre CV.';

  @override
  String get gotIt => 'Compris';

  @override
  String get searchJobs => 'Rechercher des emplois...';

  @override
  String get uploadResume => 'Télécharger le CV';

  @override
  String get resumeUploaded => 'CV téléchargé avec succès!';

  @override
  String get noJobsFound => 'Aucun emploi trouvé';

  @override
  String relevance(int percent) {
    return 'Pertinence: $percent%';
  }

  @override
  String get apply => 'Postuler';

  @override
  String get markApplied => 'Marquer comme Postulé';

  @override
  String get appliedStatus => 'Postulé';

  @override
  String get unapply => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get favorite => 'Favori';

  @override
  String get showMore => 'Voir Plus 🔽';

  @override
  String get showLess => 'Voir Moins';

  @override
  String get button => 'Bouton';
}
