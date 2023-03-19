import 'package:chat_line/db/profile_filter.dart';

const String USER = '''
          _id,
          email,
          userId,
          displayName,
          profileImage,
          loginProviders[]{
            displayName,
            email,
            providerId,
            photoURL
          }
''';

const String EXT_PROFILE = '''
          _id,
          age,
          userId,
          weight,
          height,
          gender,
          shortBio,
          longBio,
          facebook,
          twitter,
          instagram,
          partnerStatus,
          ethnicity,
          iAm,
          imInto,
          imOpenTo,
          whatIDo,
          whatImLookingFor,
          whatInterestsMe,
          whereILive,
          sexPreference,
          nsfwFriendly,
          isTraveling,
          hivStatus,
          lastTested,
          "pronouns": pronouns[],
          "hashtags": hashtags[],
''';

class GroqQueries {
  // String getCocktailQuery(List<String>? requiredIngredients, String? searchTerms) {
  //   String? ingredientsClause;
  //     String preClause = "";
  //   if (requiredIngredients != null && requiredIngredients.length > 0) {
  //     ingredientsClause ??= "";
  //     // ingredientsClause = requiredIngredients.reduce((preClause:string, reqIngredient, index)=>{
  //     // preClause += `(references(*[references('${reqIngredient}')]._id) || references('${reqIngredient}'))`
  //     //
  //     // if(index < requiredIngredients.length - 1) {
  //     // if(isAndSearch) {
  //     // preClause += " && "
  //     //
  //     // } else {
  //     //
  //     // preClause += " || "
  //     // }
  //     // }
  //     //
  //     // return preClause
  //     // },"")
  //
  //     var index = 0;
  //     for (var reqIngredient in requiredIngredients) {
  //       preClause +=
  //           "(references(\"$reqIngredient\") || references(*[references(\"$reqIngredient\")]._id))";
  //
  //       if (index < requiredIngredients.length - 1) {
  //         // if(isAndSearch) {
  //         //   preClause += " && "
  //         //
  //         // } else {
  //
  //         preClause += " || ";
  //         // }
  //       }
  //     }
  //
  //     if(requiredIngredients.length > 1) {
  //       preClause = preClause.substring(0, preClause.length - 4);
  //     }
  //     // ingredientsClause = " && ($preClause)";
  //   }
  //
  //   String? searchStringClause;
  //
  //   if (searchTerms != null && searchTerms.isNotEmpty) {
  //     searchStringClause = " && title match \"*${searchTerms}*\"";
  //   // queryParams = {
  //   //     ...queryParams,
  //   // }
  //   }
  //
  //
  //   String query = "*[_type == \"Cocktail\"${searchStringClause!= null?'$searchTerms':''}${ingredientsClause!= null?' && ($preClause)':''}] {$COCKTAIL}";
  //
  //   print("submiting cocktail ${query} ${requiredIngredients?.length}");
  //   return query;
  // }
  //
  // String getLiquorTypeQuery() {
  //   return LIQUOR_TYPE;
  // }

  // String getProfileQuery(List<ProfileFilter> profileFilters) {
  //   String filters = "";
  //
  //   if (liquorTypeIds.length > 0) {
  //     String idString = "";
  //     for (var element in liquorTypeIds) {
  //       idString += "\"${element}\",";
  //     }
  //
  //     idString = idString.substring(0, idString.length - 1);
  //
  //     print("idstring: $idString");
  //     filters = " && references(${idString})";
  //   }
  //
  //   String query = '''*[_type == "Ingredient"$filters] {
  //   $INGREDIENT
  //   }''';
  //
  //   return query;
  // }

  GroqQueries();
}
