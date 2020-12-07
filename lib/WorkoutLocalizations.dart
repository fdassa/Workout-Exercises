import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WorkoutLocalizations {
  WorkoutLocalizations(this.locale);

  final Locale locale;

  static WorkoutLocalizations of(BuildContext context) {
    return Localizations.of<WorkoutLocalizations>(context, WorkoutLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'categories': 'Categories',
      'lowBattery': 'Low battery',
      'lowBatteryBody': 'You have less than 25% battery left!',
      'postedBy': 'Posted by:',
      'errorMessage': 'Something went wrong, try again later.',
      'exerciseDetails': 'Exercise Details',
      'mainMuscles': 'Main muscles',
      'secondaryMuscles': 'Secondary muscles',
      'equipments': 'Equipments:',
    },
    'pt': {
      'categories': 'Categorias',
      'lowBattery': 'Pouca bateria',
      'lowBatteryBody': 'Você está com menos de 25% de bateria!',
      'postedBy': 'Feito por:',
      'errorMessage': 'Algo deu errado, tente novamente mais tarde.',
      'exerciseDetails': 'Detalhes do Exercício',
      'mainMuscles': 'Músculos principais',
      'secondaryMuscles': 'Músculos secundários',
      'equipments': 'Equipamentos:',
    },
  };

  String get categories {
    return _localizedValues[locale.languageCode]['categories'];
  }

  String get lowBattery {
    return _localizedValues[locale.languageCode]['lowBattery'];
  }

  String get lowBatteryBody {
    return _localizedValues[locale.languageCode]['lowBatteryBody'];
  }

  String get postedBy {
    return _localizedValues[locale.languageCode]['postedBy'];
  }

  String get errorMessage {
    return _localizedValues[locale.languageCode]['errorMessage'];
  }

  String get exerciseDetails {
    return _localizedValues[locale.languageCode]['exerciseDetails'];
  }

  String get mainMuscles {
    return _localizedValues[locale.languageCode]['mainMuscles'];
  }

  String get secondaryMuscles {
    return _localizedValues[locale.languageCode]['secondaryMuscles'];
  }

  String get equipments {
    return _localizedValues[locale.languageCode]['equipments'];
  }
}

class WorkoutLocalizationsDelegate extends LocalizationsDelegate<WorkoutLocalizations> {
  const WorkoutLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<WorkoutLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<WorkoutLocalizations>(WorkoutLocalizations(locale));
  }

  @override
  bool shouldReload(WorkoutLocalizationsDelegate old) => false;
}