import 'package:tuple/tuple.dart';

import '../models/submodels/height.dart';

enum FilterType {
  DISPLAY_NAME,
  AGE,
  WEIGHT,
  HEIGHT,
  SHORT_BIO,
  LONG_BIO,
  USER_ID,
  GENDER,
  FACEBOOK,
  TWITTER,
  INSTAGRAM,
  PARTNER_STATUS,
  ETHNICITY,
  I_AM,
  IM_INTO,
  IM_OPEN_TO,
  WHAT_I_DO,
  WHAT_IM_LOOKING_FOR,
  WHAT_INTERESTS_ME,
  WHERE_I_LIVE,
  SEX_PREFERENCE,
  NSFW_FRIENDLY,
  IS_TRAVELING,
  HIV_STATUS,
  LAST_TESTED,
  PRONOUNS,
  HASHTAGS
}

enum FilterOperation {
  NOT_EQUAL_TO,
  LESS_THAN,
  LESS_THAN_EQUAL,
  BETWEEN,
  EQUAL,
  GREATER_THAN,
  GREATER_THAN_EQUAL,
}

class FilterData<T, S> {
  late T first;
  late S? second;

  FilterData({required this.first, this.second});
}

class ProfileFilter {
  late FilterType? type;
  late FilterOperation? operation;
  late FilterData? value;

  ProfileFilter() {
    type = null;
    operation = null;
    value = null;
  }

  ProfileFilter.setAll({this.type, this.operation, this.value});
}

class ProfileQuery {
  late List<ProfileFilter> profileFilters = [];

  getDisplayNameFilter(String displayNameQuery) {
    ProfileFilter displayNameFilter = ProfileFilter.setAll(
        type: FilterType.DISPLAY_NAME,
        operation: FilterOperation.EQUAL,
        value: FilterData(first: displayNameQuery));
    return displayNameFilter;
  }

  getAgeFilter(int ageQueryMin, int ageQueryMax) {
    ProfileFilter ageFilter = ProfileFilter.setAll(
      type: FilterType.AGE,
      operation: FilterOperation.BETWEEN,
      value: FilterData(first: ageQueryMin, second: ageQueryMax),
    );
    return ageFilter;
  }

  getWeightFilter(int weightQueryMin, int weightQueryMax) {
    ProfileFilter weightFilter = ProfileFilter.setAll(
      type: FilterType.WEIGHT,
      operation: FilterOperation.BETWEEN,
      value: FilterData(first: weightQueryMin, second: weightQueryMax),
    );
    return weightFilter;
  }

  getHeightFilter(Height heightQueryMin, Height heightQueryMax) {
    ProfileFilter heightFilter = ProfileFilter.setAll(
      type: FilterType.HEIGHT,
      operation: FilterOperation.BETWEEN,
      value: FilterData(first: heightQueryMin, second: heightQueryMax),
    );
    return heightFilter;
  }
}
